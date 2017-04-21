//
//  ViewController.swift
//  Catalogo Pockemon
//
//  Created by Kipo on 4/21/17.
//  Copyright © 2017 Kipo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    

}

