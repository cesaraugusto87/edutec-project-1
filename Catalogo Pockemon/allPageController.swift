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


class allPage: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var pokemonArray: NSArray? = NSArray()
    var apiUrl: String = "https://pokeapi.co/api/v2/pokemon/"
    var backPageLink: String?
    var nextPageLink: String?
    var pageCounter: Int = 1
    
    @IBOutlet var pokemonTable: UITableView?
    
    @IBAction func backPage(_ sender: UIButton) {
        if ((backPageLink) != nil) {
        loadDataFromApi(url: backPageLink!)
            pageCounter = pageCounter - 1
        }
    }
    @IBAction func nextPage(_ sender: Any) {
        if ((nextPageLink) != nil) {
            loadDataFromApi(url: nextPageLink!)
            pageCounter = pageCounter + 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ALLoadingView.manager.hideLoadingView()
        loadDataFromApi(url: apiUrl);
        pokemonTable?.dataSource = self
        pokemonTable?.delegate = self
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
        
        
        self.navigationController?.pushViewController(details, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (pokemonArray?.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! pokemonCell
        let pokemonInfo: [String: AnyObject] = pokemonArray![indexPath.row] as! [String: AnyObject]
        
        cell.pokemonName?.text = (pokemonInfo["name"] as? String)?.capitalized
        
        let pokemonId = (((pokemonInfo["url"] as! String).components(separatedBy: "/") as NSArray)[6]) as! String
        
        let pokemonImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/" + pokemonId+".png"
        
        cell.pokemonPicture?.af_setImage(withURL: URL(string: pokemonImage)!)
        
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

