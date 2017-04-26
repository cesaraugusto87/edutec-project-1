//
//  favoritePokemonsCell.swift
//  Catalogo Pockemon
//
//  Created by Kipo on 4/26/17.
//  Copyright © 2017 Kipo. All rights reserved.
//

import UIKit

class favoritePokemonsCell: UITableViewCell {
    
    @IBOutlet var pokemonImage: UIImageView!
    @IBOutlet var pokemonName: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
