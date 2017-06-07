//
//  Dreaming.swift
//  Sweet Dreams
//
//  Created by Alberto Garcia Ramos on 07/06/2017.
//  Copyright © 2017 Alberto Garcia Ramos. All rights reserved.
//

import UIKit

class Dreaming: UIViewController {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var dreamTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hidesBottomBarWhenPushed = true
        
        dream()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dream () {
        loading.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
            // Action we would do while loading -> Calibrate sensors
            self.loading.stopAnimating()
            
            let alertController = UIAlertController(title: "Nuevo sueño", message: "Escriba un título para el sueño", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let saveAction = UIAlertAction(title: "Aceptar", style: .default, handler: {
                alert -> Void in
                
                let titleTextField = alertController.textFields![0] as UITextField
                
                if let newTitle = titleTextField.text {
                    self.dreamTitle = newTitle
                }
                self.performSegue(withIdentifier: "newDreamSegue", sender: self)
            })
            
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Introduce un título"
            }
            alertController.addAction(saveAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TabBarController {
            
            destination.dreamTitle = dreamTitle
        }

    }
}
