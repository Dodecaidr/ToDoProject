//
//  Task.swift
//  SkillBox14
//
//  Created by Илья Лобков on 01/12/2019.
//  Copyright © 2019 Илья Лобков. All rights reserved.
//
import UIKit
import RealmSwift

class CellTask: UITableViewCell {
    
    @IBOutlet weak var nameTaskLabel: UILabel!
    
    @IBOutlet weak var notesTaskLabel: UILabel!
    
}

class Task: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let realm = try! Realm()
    var token: NotificationToken?
    var model: TaskListToDoModel?
    
    @IBOutlet weak var tableTask: UITableView! {
        didSet {
            tableTask.dataSource = self
            tableTask.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        guard let _ = model else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        token = realm.observe({ (_, _) in
            //self.updateModels()
            DispatchQueue.main.async {
                self.tableTask.reloadData()
            }
        })    }
    
    func updateModels() {
        var models: [TaskListToDoModel] = []
        models = StorageManager.tasks()
        let modelsFilter = models.filter({/*$0.id == self.model?.id*/self.model?.id == $0.id})
        model = modelsFilter.first
        DispatchQueue.main.async {
            self.tableTask.reloadData()
        }
        
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            guard let model = self.model else {
                return
            }
            let taskDelete = model.tasks[indexPath.row]
            StorageManager.deleteObjectTask(for: taskDelete)
            self.token?.invalidate()
        }
        return UISwipeActionsConfiguration(actions: [actionDelete])
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
                self.token?.invalidate()
                self.updateModels()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionAdd.addAction(okAction)
        actionAdd.addAction(cancelAction)
        
        self.present(actionAdd, animated: true, completion: nil)
        
    }
    
}
