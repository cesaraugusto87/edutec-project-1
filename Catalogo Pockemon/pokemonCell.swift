//
//  pokemonCell.swift
//  Catalogo Pockemon
//
//  Created by Cesar Augusto Sanchez Coraspe on 21/04/17.
//  Copyright © 2017 Kipo. All rights reserved.
//

import UIKit
import Canvas

class pokemonCell: UITableViewCell {
    
    
    @IBOutlet var pokemonName: UILabel?
    @IBOutlet var pokemonPicture: UIImageView?
    @IBOutlet var animationCell: CSAnimationView?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization codes
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    
}
