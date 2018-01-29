//
//  ViewController.swift
//  Todoey
//
//  Created by Jörg Külheim on 08.01.18.
//  Copyright © 2018 Jörg Külheim. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        let newItem  = Item()
        newItem.title = "Eintrag 1"
        itemArray.append(newItem)

        let newItem2  = Item()
        newItem2.title = "Eintrag 2"
        itemArray.append(newItem2)

        let newItem3  = Item()
        newItem3.title = "Eintrag 3"
        itemArray.append(newItem3)

                if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
                    itemArray = items
                }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
          return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK - Add New ITems

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen when add item is clicked
            let item = Item()
            item.title = textField.text!
            self.itemArray.append(item)
            self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
      
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
        
    }
    
}

