//
//  SensorsSettings.swift
//  Sweet Dreams
//
//  Created by Alberto Garcia Ramos on 07/06/2017.
//  Copyright © 2017 Alberto Garcia Ramos. All rights reserved.
//

import UIKit

class SensorsSettings: UIViewController {
    
    @IBOutlet weak var calibrateButton: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var textInfo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loading.hidesWhenStopped = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calibrate(_ sender: Any) {
        
        calibrateButton.isHidden = true
        loading.startAnimating()
        self.textInfo.text = "\nCalibrando..."
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            // Action we would do while loading -> Calibrate sensors
            self.loading.stopAnimating()
            self.textInfo.text = "¡Sensores recalibrados con éxito!"
            self.calibrateButton.isHidden = false
        }
    }
}
