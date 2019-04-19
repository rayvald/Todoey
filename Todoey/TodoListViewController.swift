//
//  ViewController.swift
//  Todoey
//
//  Created by Osvaldo Murillo on 4/18/19.
//  Copyright © 2019 Osvaldo Murillo. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Practice Swift", "Play Warframe", "To do exercise"]
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = item
        }
    }
    
    //MARK - TableView DataSource Methods
    
    //1- Number of Rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //Begin TableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark //Returns the table cell at the specified index path and add accessory checkmark
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        print(itemArray[indexPath.row])
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        
        var newItem = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add New", style: .default) { (action) in
            self.itemArray.append(newItem.text!)
            self.defaults.setValue(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            newItem = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

}

