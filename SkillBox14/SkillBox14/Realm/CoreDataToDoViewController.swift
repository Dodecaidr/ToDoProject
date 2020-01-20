//
//  CoreDataToDoViewController.swift
//  SkillBox14
//
//  Created by Илья Лобков on 14/01/2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit
import CoreData

class CoreDataToDoViewController: UITableViewController {
    
    var toDoItems: [TaskCoreData] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
          loadDataTask ()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDoItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let task = toDoItems[indexPath.row ]
        
        cell.textLabel?.text = task.taskToDo
        
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
                
                self.saveTask(taskToDo: (actionAdd.textFields?.first!.text)!)
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actionAdd.addAction(okAction)
        actionAdd.addAction(cancelAction)
        
        self.present(actionAdd, animated: true, completion: nil)
        
    }
    
    //Mark: - Button table
    
    func saveTask(taskToDo: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistenContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "TaskCoreData", in: context)
        let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! TaskCoreData
        taskObject.taskToDo = taskToDo
        print("save complite")
        
        do {
            try context.save()
            toDoItems.append(taskObject)
        } catch {
            print(error.localizedDescription )
        }
    }
    
    //Mark: - rest func
    private func loadDataTask () {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistenContainer.viewContext
        
        let fetchRequest: NSFetchRequest<TaskCoreData> = TaskCoreData.fetchRequest()
        
        do {
            toDoItems = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
