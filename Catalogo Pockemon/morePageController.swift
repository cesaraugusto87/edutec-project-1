//
//  morePageController.swift
//  Catalogo Pockemon
//
//  Created by Cesar Augusto Sanchez Coraspe on 21/04/17.
//  Copyright © 2017 Kipo. All rights reserved.
//

import UIKit

class morePage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var moreTbl: UITableView!
    let moreOptions: NSArray = ["Definicion de las Clasificaciones","Cargar mas Pokemones","Acerca de"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moreTbl.delegate = self
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moreOptionsCell", for: indexPath) as! moreOptionsCell
        
        cell.optionName.text = moreOptions[indexPath.row] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
