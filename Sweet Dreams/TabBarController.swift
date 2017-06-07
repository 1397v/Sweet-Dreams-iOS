//
//  TabBarController.swift
//  Sweet Dreams
//
//  Created by Alberto Garcia Ramos on 07/06/2017.
//  Copyright © 2017 Alberto Garcia Ramos. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    var dreamTitle:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedIndex = 1;
    }
    
    @IBAction func unwindFromDreaming (segue: UIStoryboardSegue) -> Void {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.dreams.append(DreamElement(newTitle: dreamTitle))
        
        self.selectedIndex = 0;
    }
}
