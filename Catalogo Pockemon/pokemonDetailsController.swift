//
//  pokemonDetailsController.swift
//  Catalogo Pockemon
//
//  Created by Cesar Augusto Sanchez Coraspe on 22/04/17.
//  Copyright © 2017 Kipo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import ALLoadingView
import Canvas
import CoreData

class pokemonDetailsController: UIViewController{
    
    var pokemonId: String?
    var loadedPokemon: Bool = false
    let imageUrl: String = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
    let apiUrl: String = "https://pokeapi.co/api/v2/pokemon/"
    
    @IBOutlet var pokemonImage: UIImageView!
    @IBOutlet var pokemonName: UILabel!
    @IBOutlet var pokemonAbilities: UILabel!
    @IBOutlet var weight: UILabel!
    @IBOutlet var height: UILabel!
    @IBOutlet var animationImage: CSAnimationView!
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    
    @IBAction func addToFavorites(_ sender: Any) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Pokemon", in: context)
        let newFavorite = NSManagedObject(entity: entity!, insertInto: context)
        
        newFavorite.setValue(pokemonId, forKey: "id")
        newFavorite.setValue(pokemonName.text, forKey: "name")
        newFavorite.setValue(apiUrl+pokemonId!, forKey: "url")
        
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
    override func viewWillAppear(_ animated: Bool){
        if(loadedPokemon == false) {
            ALLoadingView.manager.blurredBackground = true
            ALLoadingView.manager.showLoadingView(ofType: .basic, windowMode: .fullscreen)
        }else{
            ALLoadingView.manager.hideLoadingView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
       loadDataFromApi();
        ALLoadingView.manager.hideLoadingView()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func loadDataFromApi() -> Void {
        Alamofire.request(apiUrl+pokemonId!).responseJSON
            { response in
                if let JSON = response.result.value {
                    
                    self.loadedPokemon = true
                    
                    let response = JSON as! NSDictionary
                    self.pokemonName.text = (response.object(forKey: "name") as? String)?.capitalized
                    
                    for abilitites in (response.object(forKey: "abilities") as! NSArray) {
                        let name = abilitites as! NSDictionary
                        let ability = ((name.object(forKey: "ability") as! NSDictionary).object(forKey: "name")) as? String
                        self.pokemonAbilities.text = self.pokemonAbilities.text! + " " + ability!.capitalized
                    }
                    
                    self.weight.text = (String((response.object(forKey: "weight") as? Int)!) + " Kg").capitalized
                    self.height.text = (String((response.object(forKey: "height") as? Int)!) + " cm").capitalized
                    self.pokemonImage?.af_setImage(withURL: URL(string: self.imageUrl+self.pokemonId! + ".png")!)
                    var xPosition = 16
                    var yPosition = 513
                    for pokemonType in (response.object(forKey: "types") as! NSArray) {
                        let type = pokemonType as! NSDictionary
                        let typeName =  (type.object(forKey: "type") as! NSDictionary).object(forKey: "name")
                        let imageName = (typeName as! String)
                        let image = UIImage(named: imageName)
                        let imageView = UIImageView(image: image!)
                        
                        imageView.frame = CGRect(x: xPosition, y: yPosition, width: 60, height: 54)
                        
                        if(xPosition == 348){
                            xPosition = 16
                            yPosition = 593
                        }else{
                            xPosition = xPosition + 84
                        }
                        
                        self.view.addSubview(imageView)
                    }
                    ALLoadingView.manager.hideLoadingView()
                    self.animationImage.startCanvasAnimation()
                }
        }
        
    }
    
    
    
}
