//
//  Library.swift
//  Sweet Dreams
//
//  Created by Alberto Garcia Ramos on 07/06/2017.
//  Copyright © 2017 Alberto Garcia Ramos. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class Library: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var dreams:[String:DreamElement] = [:]
    var dreamTitles:[String] = []
    var filteredDreams: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        for dream in appDelegate.dreams {
            dreams[dream.title] = dream
            dreamTitles.append(dream.title)
        }
        filteredDreams = dreamTitles
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        dreams.removeAll()
        dreamTitles.removeAll()
        filteredDreams.removeAll()
        
        for dream in appDelegate.dreams {
            dreams[dream.title] = dream
            dreamTitles.append(dream.title)
        }
        filteredDreams = dreamTitles
        tableView.reloadData()
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DreamCell", for: indexPath) as! DreamCell
        cell.title.text = filteredDreams[indexPath.row]
        cell.date.text = dreams[filteredDreams[indexPath.row]]!.date
        cell.duration.text = dreams[filteredDreams[indexPath.row]]!.duration
        cell.dreamImage.image = UIImage(named: dreams[filteredDreams[indexPath.row]]!.dream)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDreams.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Opciones", message: "", preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancelar", style: .cancel) { _ in
            return
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let playActionButton = UIAlertAction(title: "Reproducir", style: .default)
        { _ in
            
            let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
        actionSheetControllerIOS8.addAction(playActionButton)
        
        let renameActionButton = UIAlertAction(title: "Renombrar", style: .default)
        { _ in
            
            let alertController = UIAlertController(title: "Cambiar título", message: "Escriba el nuevo título para el sueño", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let saveAction = UIAlertAction(title: "Aceptar", style: .default, handler: {
                alert -> Void in
                
                let titleTextField = alertController.textFields![0] as UITextField
                
                if let newTitle = titleTextField.text {
                    self.dreams[newTitle] = self.dreams[self.filteredDreams[indexPath.row]]
                    self.dreams.removeValue(forKey: self.filteredDreams[indexPath.row])
                    
                    self.filteredDreams[indexPath.row] = newTitle
                    if let index = self.dreamTitles.index(of: self.filteredDreams[indexPath.row]) {
                        self.dreamTitles[index] = newTitle
                    }
                }
                
                self.tableView.reloadData()
            })
            
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Introduce un nuevo título"
            }
            alertController.addAction(saveAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        actionSheetControllerIOS8.addAction(renameActionButton)
        
        let shareActionButton = UIAlertAction(title: "Compartir", style: .default)
        { _ in
            
            let shareText = self.dreams[self.filteredDreams[indexPath.row]]?.title
            let image = UIImage(named: self.dreams[self.filteredDreams[indexPath.row]]!.dream)
            
            let vc = UIActivityViewController(activityItems: [shareText!, image!], applicationActivities: [])
            self.present(vc, animated: true, completion: nil)
        }
        actionSheetControllerIOS8.addAction(shareActionButton)
        
        let deleteActionButton = UIAlertAction(title: "Eliminar", style: .destructive)
        { _ in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.dreams.remove(at: appDelegate.dreams.index(where:  { $0.title == self.filteredDreams[indexPath.row] })!)
                
            self.dreams.removeValue(forKey: self.filteredDreams[indexPath.row])
            if let index = self.dreamTitles.index(of: self.filteredDreams[indexPath.row]) {
                self.dreamTitles.remove(at: index)
            }
            self.filteredDreams.remove(at: indexPath.row)
            
            self.tableView.reloadData()
        }
        actionSheetControllerIOS8.addAction(deleteActionButton)
        
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
        
        
    }
    
    // MARK: - SearchBar
    
    // This method updates filteredCodes based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredCodes is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredDreams = searchText.isEmpty ? dreamTitles : dreamTitles.filter({(dataString: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        tableView.reloadData()
    }
}
