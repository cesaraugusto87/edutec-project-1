//
//  pokemonTypeController.swift
//  Catalogo Pockemon
//
//  Created by Cesar Augusto Sanchez Coraspe on 22/04/17.
//  Copyright © 2017 Kipo. All rights reserved.
//

import UIKit
import SwiftyJSON

class pokemonTypeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var pokemonTypesTbl: UITableView!
    
    var pokemonTypes: NSArray? = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadJSONInfo()
        pokemonTypesTbl?.delegate = self
        pokemonTypesTbl?.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = storyboard?.instantiateViewController(withIdentifier: "bycategoriesController") as! bycategoriesController
        let apiInfo: [String: AnyObject] = pokemonTypes![indexPath.row] as! [String: AnyObject]
        
        details.apiUrl = apiInfo["url"] as? String
        
        self.navigationController?.pushViewController(details, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (pokemonTypes?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonTypeCell", for: indexPath) as! pokemonTypeCell
        let typeInfo: [String: AnyObject] = pokemonTypes![indexPath.row] as! [String: AnyObject]
        
        cell.pokemonTypeName?.text = typeInfo["name"] as? String
        cell.pokemonTypeImage?.image = UIImage(named: typeInfo["value"] as! String)
        
        return cell
    }
    
    func loadJSONInfo() -> Void {
        if let path = Bundle.main.path(forResource: "typeinfo", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let info = try JSONSerialization.jsonObject(with: data, options: []) as! NSArray
                pokemonTypes = info
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path")
        }
    }

}
