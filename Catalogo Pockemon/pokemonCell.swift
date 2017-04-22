//
//  pokemonCell.swift
//  Catalogo Pockemon
//
//  Created by Cesar Augusto Sanchez Coraspe on 21/04/17.
//  Copyright © 2017 Kipo. All rights reserved.
//

import UIKit

class pokemonCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization codes
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
}
