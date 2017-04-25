//
//  Manager.swift
//  Catalogo Pockemon
//
//  Created by Kipo on 4/24/17.
//  Copyright © 2017 Kipo. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol ManagerDelegate {
    func endPointResponse (tag: String, json: JSON)
}

class Manager {
    var delegate: ManagerDelegate?
    var url = "https://pokeapi.co/api/"
    var version: String?
    var tag: String?
    let endPoints: JSON = [
    "pokemon": "pokemon/",
    "type": "type/"]
    
    init(tag:String, version: String) {
        self.tag = tag
        self.version = version
    }
    
    func getPokemon (endpoint: String, idPokemon: String) -> Void {
        let urlString = url + (version)! + "/" + endPoints[endpoint].stringValue + idPokemon
        Alamofire.request(urlString).response { (response) in
        let json: JSON = JSON(data: response.data!)
        self.delegate?.endPointResponse(tag: self.tag!, json: json)
        }
    }
    func getPokemonByType(endpoint: String, pokemonType: String) -> Void {
        let urlString = url + (version)! + "/" + endPoints[endpoint].stringValue + pokemonType
        Alamofire.request(urlString).response { (response) in
            let json: JSON = JSON(data: response.data!)
            self.delegate?.endPointResponse(tag: self.tag!, json: json)
        }
    }
}
