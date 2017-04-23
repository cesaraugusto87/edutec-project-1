//
//  byCategoriesController.swift
//  Catalogo Pockemon
//
//  Created by Cesar Augusto Sanchez Coraspe on 23/04/17.
//  Copyright © 2017 Kipo. All rights reserved.
//

import UIKit
import ALLoadingView
import Alamofire
import AlamofireImage


class bycategoriesController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var pokemonArray: NSArray? = NSArray()
    var apiUrl: String?
    var backPageLink: String?
    var nextPageLink: String?
    var pageCounter: Int = 0

    @IBOutlet var pokemonTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool){
        if ( (pokemonArray?.count)! == 0 ) {
            ALLoadingView.manager.blurredBackground = true
            ALLoadingView.manager.showLoadingView(ofType: .basic, windowMode: .fullscreen)
        }else{
            ALLoadingView.manager.hideLoadingView(withDelay: 0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadDataFromApi(url: apiUrl!);
        pokemonTable?.dataSource = self
        pokemonTable?.delegate = self
        ALLoadingView.manager.hideLoadingView()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (pokemonArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonByTypeCell", for: indexPath) as! pokemonCell
        let pokemonInfo: [String: AnyObject] = pokemonArray![indexPath.row] as! [String: AnyObject]
        
        cell.pokemonName?.text = ((pokemonInfo["pokemon"] as? NSDictionary)?["name"] as! String).capitalized
        
       let pokemonId = ((((pokemonInfo["pokemon"] as? NSDictionary)?["url"] as! String).components(separatedBy: "/") as NSArray)[6]) as! String
        
        let pokemonImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/" + pokemonId+".png"
        
        cell.pokemonPicture?.af_setImage(withURL: URL(string: pokemonImage)!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = storyboard?.instantiateViewController(withIdentifier: "pokemonDetails") as! pokemonDetailsController
        let pokemonInfo: [String: AnyObject] = pokemonArray![indexPath.row] as! [String: AnyObject]
        
        details.pokemonId = ((((pokemonInfo["pokemon"] as? NSDictionary)?["url"] as! String).components(separatedBy: "/") as NSArray)[6]) as? String
        
        
        self.navigationController?.pushViewController(details, animated: true)
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
                        self.pokemonArray = response.object(forKey: "pokemon")! as? NSArray
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
