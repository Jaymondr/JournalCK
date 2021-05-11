//
//  EntryTableViewController.swift
//  Journal
//
//  Created by Jaymond Richardson on 5/10/21.
//

import UIKit

class EntryTableViewController: UITableViewController {
    //MARK: - Outlets
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        EntryController.shared.fetchEntriesWith { (_) in
            //            DispatchQueue.main.async {
            
            self.tableView.reloadData()
            //            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    
    //MARK: - Actions
    
    
    @IBAction func addEntryButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return EntryController.shared.entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        let entry = EntryController.shared.entries[indexPath.row]
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.timestamp.formatToString()
        
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination  as? EntryDetailViewController else {return}
            let entryToSend = EntryController.shared.entries[indexPath.row]
            destinationVC.entry = entryToSend
            
            
        }
    }
}
