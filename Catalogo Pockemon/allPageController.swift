//
//  ViewController.swift
//  Catalogo Pockemon
//
//  Created by Cesar Augusto Sanchez Coraspe on 21/04/17.
//  Copyright © 2017 Kipo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import ALLoadingView
import SwiftyJSON
import CoreData


class allPage: UIViewController, UITableViewDataSource, UITableViewDelegate, ManagerDelegate {
    
    var pokemonArray: NSArray? = NSArray()
    var apiUrl: String = "https://pokeapi.co/api/v2/pokemon/"
    var backPageLink: String?
    var nextPageLink: String?
    var pageCounter: Int = 0
    var pokemonData: NSManagedObject?
    
    @IBOutlet var quantityTitle: UILabel!
    @IBOutlet var pokemonTable: UITableView?
    
    @IBAction func backPage(_ sender: UIButton) {
        if ((backPageLink) != nil) {
            ALLoadingView.manager.blurredBackground = true
            ALLoadingView.manager.showLoadingView(ofType: .basic, windowMode: .fullscreen)
            loadDataFromApi(url: backPageLink!)
            pageCounter = pageCounter - 2
            quantityTitle.text = "Viendo " + String(pageCounter * 20) + " de 1600"
        }
    }
    @IBAction func nextPage(_ sender: Any) {
        if ((nextPageLink) != nil) {
            ALLoadingView.manager.blurredBackground = true
            ALLoadingView.manager.showLoadingView(ofType: .basic, windowMode: .fullscreen)
            loadDataFromApi(url: nextPageLink!)
            pageCounter = pageCounter + 2
            quantityTitle.text = "Viendo " + String(pageCounter * 20) + " de 1600"
        }
    }
    
    override func viewWillAppear(_ animated: Bool){
        if ( (pokemonArray?.count)! == 0 ) {
        ALLoadingView.manager.blurredBackground = true
        ALLoadingView.manager.showLoadingView(ofType: .basic, windowMode: .fullscreen)
        }else{
            ALLoadingView.manager.hideLoadingView(withDelay: 0)
        }
    }
    
    func endPointResponse(tag: String, json: NSDictionary) {
        if (tag == "allPokemons"){
            
            self.pokemonArray = json.object(forKey: "results")! as? NSArray
            self.backPageLink = json.object(forKey: "previous")! as? String
            self.nextPageLink = json.object(forKey: "next")! as? String
            self.pokemonTable?.reloadData()
            ALLoadingView.manager.hideLoadingView()

        }
    }
    
    func getPokemons() -> Void {
        let manager: Manager = Manager(tag: "allPokemons", version: "v2")
        manager.delegate = self
        manager.getPokemon(endpoint: "pokemon", idPokemon: "1")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     //   loadDataFromApi(url: apiUrl);
        pokemonTable?.dataSource = self
        pokemonTable?.delegate = self
        ALLoadingView.manager.hideLoadingView()
        getPokemons()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = storyboard?.instantiateViewController(withIdentifier: "pokemonDetails") as! pokemonDetailsController
    
        if(pageCounter > 1){
            details.pokemonId = String((indexPath.row+1) + (pageCounter * 10))
        }else{
            details.pokemonId = String(indexPath.row+1)
        }
        tableView.deselectRow(at: indexPath, animated: false)
        self.navigationController?.pushViewController(details, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (pokemonArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let favorite = UITableViewRowAction(style: .normal, title: "♡") { action, index in
            let context = self.getContext()
            let entity = NSEntityDescription.entity(forEntityName: "Pokemon", in: context)
            let pokemonInfo: [String: AnyObject] = self.pokemonArray![indexPath.row] as! [String: AnyObject]
            let pokemonId = (((pokemonInfo["url"] as! String).components(separatedBy: "/") as NSArray)[6]) as! String
            let newFavorite = NSManagedObject(entity: entity!, insertInto: context)
            
            newFavorite.setValue(pokemonId, forKey: "id")
            newFavorite.setValue((pokemonInfo["name"] as? String), forKey: "name")
            newFavorite.setValue(self.apiUrl+pokemonId, forKey: "url")
            
            do {
                try context.save()
                let alertController = UIAlertController(title: "Se agrego el Pokemon a tus Favoritos", message: "Puedes consultar tus favoritos en la opcion mas", preferredStyle: .alert)
                self.present(alertController, animated: true, completion: nil)
                let okAction = UIAlertAction(title:"Ok",style: .default) {(action:UIAlertAction) in
                }
                alertController.addAction(okAction)
            } catch let error as NSError {
                print("No se obtener la información: \(error), \(error.userInfo)")
            }
            
        }
        favorite.backgroundColor = UIColor.orange
        
        return [favorite]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! pokemonCell
        let pokemonInfo: [String: AnyObject] = pokemonArray![indexPath.row] as! [String: AnyObject]
        
        cell.pokemonName?.text = (pokemonInfo["name"] as? String)?.capitalized
        
        let pokemonId = (((pokemonInfo["url"] as! String).components(separatedBy: "/") as NSArray)[6]) as! String
        
        let pokemonImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/" + pokemonId+".png"
        
        cell.pokemonPicture?.af_setImage(withURL: URL(string: pokemonImage)!)
        
        cell.animationCell?.startCanvasAnimation()
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDataFromApi(url: String) -> Void {
        apiUrl = url
        
        Alamofire.request(url).responseJSON
            { response in
                switch (response.result) {
                case .success:
                if let JSON = response.result.value {
                    let response = JSON as! NSDictionary
                    self.pokemonArray = response.object(forKey: "results")! as? NSArray
                    self.backPageLink = response.object(forKey: "previous")! as? String
                    self.nextPageLink = response.object(forKey: "next")! as? String
                    self.pokemonTable?.reloadData()
                    ALLoadingView.manager.hideLoadingView()
                }
                    break
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        print("Server Down")
                    }
                    print("\n\nAuth request failed with error:\n \(error)")
                    break
                }
        }
       }
}

