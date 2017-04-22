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

class allPage: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var pokemonTable: UITableView?
    
    var pokemonArray: NSArray? = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadDataFromApi();
        pokemonTable?.dataSource = self
        pokemonTable?.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (pokemonArray?.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! pokemonCell
        let pokemonInfo: [String: AnyObject] = pokemonArray![indexPath.row] as! [String: AnyObject]
        
        
        cell.pokemonName?.text = pokemonInfo["name"] as? String
        
        let pokemonId = (((pokemonInfo["url"] as! String).components(separatedBy: "/") as NSArray)[6]) as! String
        
        let pokemonImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/" + pokemonId+".png"
        
        cell.pokemonPicture?.af_setImage(withURL: URL(string: pokemonImage)!)
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDataFromApi() -> Void {
        Alamofire.request("https://pokeapi.co/api/v2/pokemon/").responseJSON
            { response in
                
                if let JSON = response.result.value {
                    let response = JSON as! NSDictionary
                    self.pokemonArray = response.object(forKey: "results")! as? NSArray
                    self.pokemonTable?.reloadData()
                                   }
        }
        
       }
}

