//
//  tabBarController.swift
//  Catalogo Pockemon
//
//  Created by Cesar Augusto Sanchez Coraspe on 21/04/17.
//  Copyright © 2017 Kipo. All rights reserved.
//

import UIKit
import ALLoadingView

class tabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ALLoadingView.manager.hideLoadingView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
