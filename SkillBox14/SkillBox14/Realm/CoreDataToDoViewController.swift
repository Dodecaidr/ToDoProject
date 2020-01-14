//
//  CoreDataToDoViewController.swift
//  SkillBox14
//
//  Created by Илья Лобков on 14/01/2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit

class CoreDataToDoViewController: UITableViewController {
    
    var toDoItems: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = toDoItems[indexPath.row ]
        
        return cell
    }
    
    @IBAction func addTaskButtonAction(_ sender: Any) {
        
        let actionAdd = UIAlertController(title: "New Task", message: nil, preferredStyle: .alert)
        
        actionAdd.addTextField { (task) in
            task.autocapitalizationType = .sentences //Для ввода с заглавной буквы
            task.placeholder = "Name New Task"
        }
        
        let okAction = UIAlertAction(title: "ok", style: .default) { _ in
            if actionAdd.textFields?.first?.text != nil {
                self.toDoItems.append((actionAdd.textFields?.first!.text)!)

                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actionAdd.addAction(okAction)
        actionAdd.addAction(cancelAction)
        
        self.present(actionAdd, animated: true, completion: nil)
        
    }
    
    
    
}
