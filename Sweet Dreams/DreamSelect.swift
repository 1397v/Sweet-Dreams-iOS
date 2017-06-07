//
//  DreamSelect.swift
//  Sweet Dreams
//
//  Created by Alberto Garcia Ramos on 07/06/2017.
//  Copyright © 2017 Alberto Garcia Ramos. All rights reserved.
//

import UIKit

class DreamSelect: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var names:[String] = ["Amigos","Amor", "Aventura", "Deseos", "Familia", "Futuro", "Relajación", "Sexo", "Viaje", "Volar"]
    var filteredCodes: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hidesBottomBarWhenPushed = true
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        tableView.allowsMultipleSelection = true
        filteredCodes = names
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as! TopicCell
        cell.topic.text = filteredCodes[indexPath.row]
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        cell.selectionStyle = .none // to prevent cells from being "highlighted"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCodes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if filteredCodes[indexPath.row] == "Sexo" {
            let alertController = UIAlertController(title: "Lo sentimos", message: "La opción sexo sólo está disponible en la versión premium", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    // MARK: - SearchBar
    
    // This method updates filteredCodes based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredCodes is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredCodes = searchText.isEmpty ? names : names.filter({(dataString: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        tableView.reloadData()
    }

}
