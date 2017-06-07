//
//  StoringSettings.swift
//  Sweet Dreams
//
//  Created by Alberto Garcia Ramos on 07/06/2017.
//  Copyright © 2017 Alberto Garcia Ramos. All rights reserved.
//

import UIKit

class StoringSettings: UIViewController {
    
    @IBOutlet weak var cloudStoring: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectCloudStoring(_ sender: Any) {
        if cloudStoring.isOn {
            let shareText = "Hello, world!"
            
            let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
            present(vc, animated: true, completion: nil)
        }
    }
}
