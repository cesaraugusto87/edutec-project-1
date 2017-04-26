//
//  favoritesPageController.swift
//  Catalogo Pockemon
//
//  Created by Kipo on 4/26/17.
//  Copyright © 2017 Kipo. All rights reserved.
//

import UIKit
import CoreData

class favoritePageController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var favoritePokemonTable: UITableView!
    
     var pokemons: [NSManagedObject] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        favoritePokemonTable?.dataSource = self
        favoritePokemonTable?.delegate = self
        getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritePokemonsCell", for: indexPath) as! favoritePokemonsCell
        let pokemonInfo = pokemons[indexPath.row]
        
        cell.pokemonName?.text = (pokemonInfo.value(forKey: "name") as? String)?.capitalized
        
        let pokemonId = (pokemonInfo.value(forKey: "id") as? String)
        
        let pokemonImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/" + pokemonId!+".png"
        
        cell.pokemonImage?.af_setImage(withURL: URL(string: pokemonImage)!)
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let context = getContext()
            do {
                context.delete(self.pokemons[indexPath.row])
            try context.save()
                self.pokemons.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch let error as NSError {
                print("No se obtener la información: \(error), \(error.userInfo)")
            }
        }
    }

    
    func getData() {
        do {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pokemon")
            pokemons = try context.fetch(fetchRequest) as [NSManagedObject]!
        }
        catch {
            print("Fetching Failed")
        }
    }
    
    
    
}
