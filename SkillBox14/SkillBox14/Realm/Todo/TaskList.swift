//
//  TaskList.swift
//  SkillBox14
//
//  Created by Илья Лобков on 01/12/2019.
//  Copyright © 2019 Илья Лобков. All rights reserved.
//

import UIKit

class TaskList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableTaskList: UITableView!
    
    var models: [TaskListToDoModel] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateModels()
    }
    
    func updateModels() {
        models = StorageManager.tasks()
        tableTaskList.reloadData()
    }
    
    // Mark: - Настройка таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell")
        
        cell?.textLabel?.text = models[indexPath.row].name
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell")
        
        cell?.isSelected = false
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "NewTask", sender: tableView.cellForRow(at: indexPath))
    }
    
    // Mark: - передача данных
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowNewTask" {
            guard let indexPath = tableTaskList.indexPathForSelectedRow else { return }
            if let newTaskVC = segue.destination as? Task {
                let task = models[indexPath.row]
                newTaskVC.model = task
            }
        }
    }
    // Mark: - удаление спомощью нового метода iOS13
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            let taskDelete = self.models[indexPath.row]
            //            tableView.deleteRows(at: [indexPath], with: .automatic )
            StorageManager.deleteObject(for: taskDelete)
            self.updateModels()
        }
        return UISwipeActionsConfiguration(actions: [actionDelete])
    }
    
    
    
    // Mark: - Настройка Action добовления
    
    @IBAction func addTaskList(_ sender: UIBarButtonItem) {
        
        let actionAdd = UIAlertController(title: "New Task", message: nil, preferredStyle: .alert)
        
        actionAdd.addTextField { (nameTask) in
            nameTask.autocapitalizationType = .sentences
            nameTask.placeholder = "Name New Task"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if let text = actionAdd.textFields?.first?.text {
                let task = TaskListToDoModel(name: text)
                StorageManager.saveObject(for: task)
                self.updateModels()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actionAdd.addAction(okAction)
        actionAdd.addAction(cancelAction)
        
        self.present(actionAdd, animated: true, completion: nil)
        
    }
    
    // Mark: - TabelVewDelegate
    
    
    
    @IBAction func CancelAction (_ segue: UIStoryboardSegue) {}
    
}


