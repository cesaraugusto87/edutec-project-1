//
//  aboutPageController.swift
//  Catalogo Pockemon
//
//  Created by Cesar Augusto Sanchez Coraspe on 22/04/17.
//  Copyright © 2017 Kipo. All rights reserved.
//

import UIKit
import ReachabilitySwift


class aboutPageController: UIViewController {
    
    let reachability = Reachability()!

    override func viewDidLoad() {
        super.viewDidLoad()
    reachability.whenReachable = { reachability in
    // this is called on a background thread, but UI updates must
    // be on the main thread, like this:
    DispatchQueue.main.async {
    if reachability.isReachableViaWiFi {
        print("Reachable via WiFi")
    } else {
        print("Reachable via Cellular")
            }
        }
    }
    reachability.whenUnreachable = { reachability in
    // this is called on a background thread, but UI updates must
    // be on the main thread, like this:
    DispatchQueue.main.async {
    print("Not reachable")
            }
        }
    }
}
