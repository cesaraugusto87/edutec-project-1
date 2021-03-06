//
//  morePageController.swift
//  Catalogo Pockemon
//
//  Created by Cesar Augusto Sanchez Coraspe on 21/04/17.
//  Copyright © 2017 Kipo. All rights reserved.
//

import UIKit
import ALLoadingView

class morePageController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var moreTbl: UITableView!
    let moreOptions: [String] = ["Definicion de las Clasificaciones","Mis Pokemones Favoritos","Acerca de"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moreTbl?.delegate = self
        moreTbl?.dataSource = self
        ALLoadingView.manager.hideLoadingView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "moreOptionsCell", for: indexPath) as! moreOptionsCell
        
        cell.optionName?.text = moreOptions[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        switch indexPath.row {
        case 0:
            let details = storyboard?.instantiateViewController(withIdentifier: "pokemonTypeController") as! pokemonTypeController
            self.navigationController?.pushViewController(details, animated: true)
            break
        case 1:
            let details = storyboard?.instantiateViewController(withIdentifier: "favoritesPageController") as! favoritePageController
            self.navigationController?.pushViewController(details, animated: true)
            break
        case 2:
            let details = storyboard?.instantiateViewController(withIdentifier: "aboutPage") as! aboutPageController
            self.navigationController?.pushViewController(details, animated: true)
            break
        default:
            print("Sin accion")
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
