//
//  ViewController.swift
//  Catalogo Pockemon
//
//  Created by Kipo on 4/21/17.
//  Copyright © 2017 Kipo. All rights reserved.
//

import UIKit
import Alamofire

class allPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        code
    }

    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 19
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadDatafromapi();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDatafromapi() {
    Alamofire.request("https://pokeapi.co/api/v2/pokemon/").responseJSON { response in
       print(response.result)   // result of response serialization
    
    if let JSON = response.result.value {
    print("JSON: \(JSON)")
    }
    }
    }
}

