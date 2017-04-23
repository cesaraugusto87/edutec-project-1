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



class pokemonDetailsController: UIViewController{
    
    var pokemonId: String?
    var pageId: String?
    let imageUrl: String = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
    let apiUrl: String = "https://pokeapi.co/api/v2/pokemon/"
    
    @IBOutlet var pokemonImage: UIImageView!
    @IBOutlet var pokemonName: UILabel!
    @IBOutlet var pokemonAbilities: UILabel!
    @IBOutlet var weight: UILabel!
    @IBOutlet var height: UILabel!
    
    override func viewWillAppear(_ animated: Bool){
        ALLoadingView.manager.blurredBackground = true
        ALLoadingView.manager.showLoadingView(ofType: .basic, windowMode: .fullscreen)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
       loadDataFromApi();
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func loadDataFromApi() -> Void {
        Alamofire.request(apiUrl+pokemonId!).responseJSON
            { response in
                
                if let JSON = response.result.value {
                    
                    
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
                    
                    for pokemonType in (response.object(forKey: "types") as! NSArray) {
                        let type = pokemonType as! NSDictionary
                        let typeName =  (type.object(forKey: "type") as! NSDictionary).object(forKey: "name")
                        let imageName = (typeName as! String)
                        let image = UIImage(named: imageName)
                        let imageView = UIImageView(image: image!)
                        
                        imageView.frame = CGRect(x: 16, y: 513, width: 60, height: 54)
                        self.view.addSubview(imageView)
                    }
                    ALLoadingView.manager.hideLoadingView()
                    
                }
        }
        
    }
    
}
