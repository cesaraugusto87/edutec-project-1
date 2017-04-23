//
//  pokemonTypeController.swift
//  Catalogo Pockemon
//
//  Created by Cesar Augusto Sanchez Coraspe on 22/04/17.
//  Copyright © 2017 Kipo. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

class pokemonTypeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var pokemonTypesTbl: UITableView!
    
    @IBAction func viewPokemonTypes () {
        
    }
    
    var pokemonTypes: JSON?
    var typesList: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pokemonTypesTbl?.delegate = self
        pokemonTypesTbl?.dataSource = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonTypeCell", for: indexPath) as! pokemonTypeCell
        let typeInfo: NSManagedObject = typesList[indexPath.row]
        
         cell.pokemonTypeName.text = typeInfo.value(forKey: "name") as? String
         cell.pokemonTypeImage?.image = UIImage(named: typeInfo.value(forKey: "value") as! String)
        
        return cell
    }
    
    func loadJSONInfo() -> Void {
        if let path = Bundle.main.path(forResource: "pokemonType", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                pokemonTypes = JSON(data: data)
            } catch let error {
                print(error.localizedDescription)
                
            }
        } else {
            print("Invalid filename/path")
        }
    }

}
