//
//  pokemonTypeCell.swift
//  Catalogo Pockemon
//
//  Created by Cesar Augusto Sanchez Coraspe on 22/04/17.
//  Copyright © 2017 Kipo. All rights reserved.
//

import UIKit


class pokemonTypeCell: UITableViewCell {
    
    @IBOutlet var pokemonTypeImage: UIImageView!
    @IBOutlet var pokemonTypeName: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
