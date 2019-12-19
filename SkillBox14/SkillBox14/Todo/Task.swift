//
//  Task.swift
//  SkillBox14
//
//  Created by Илья Лобков on 01/12/2019.
//  Copyright © 2019 Илья Лобков. All rights reserved.
//
import UIKit

class CellTask: UITableViewCell {
    
    @IBOutlet weak var nameTaskLabel: UILabel!
    
    @IBOutlet weak var notesTaskLabel: UILabel!
    
}

class Task: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var tableTask: UITableView! {
        didSet {
            tableTask.dataSource = self
            tableTask.delegate = self
        }
    }
    
    var model: TaskListToDoModel?
    
    override func viewDidLoad() {
        super .viewDidLoad()
        guard let _ = model else {
            self.navigationController?.popViewController(animated: true)
            return
        }
            // task.taskListToDo = taskList
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.tasks.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTask") as! CellTask
        guard let model = model else {
            return UITableViewCell()
        }
        cell.nameTaskLabel.text = model.tasks[indexPath.row].name
        cell.notesTaskLabel.text = model.tasks[indexPath.row].notes
    
        return cell
       
    }

    @IBAction func addTaskButton(_ sender: Any) {
        
        let actionAdd = UIAlertController(title: "New Task", message: nil, preferredStyle: .alert)
        actionAdd.addTextField { (nameTask) in
            nameTask.autocapitalizationType = .sentences
            nameTask.placeholder = "Name New Task"
        }
        actionAdd.addTextField { (notesTask) in
            notesTask.autocapitalizationType = .sentences
            notesTask.placeholder = "Notes New Task"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if let name = actionAdd.textFields?.first?.text, let note = actionAdd.textFields?.last?.text {
                guard var model = self.model else {
                    return
                }
                let subtask = TaskToDoModel(name: name, notes: note, isCompleted: false)
                model.tasks.append(subtask)
                StorageManager.saveObject(for: model)
                self.navigationController?.popViewController(animated: true)
            }
        }
                
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
              
        actionAdd.addAction(okAction)
        actionAdd.addAction(cancelAction)
               
        self.present(actionAdd, animated: true, completion: nil)
            
    }
    
}
