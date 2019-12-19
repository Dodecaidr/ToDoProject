//
//  StorageManager.swift
//  SkillBox14
//
//  Created by Илья Лобков on 08/12/2019.
//  Copyright © 2019 Илья Лобков. All rights reserved.
//

import RealmSwift

class StorageManager {
    
    static func tasks() -> [TaskListToDoModel] {
        let realm = try! Realm()
        let objects = realm.objects(TaskListToDo.self)
        var models: [TaskListToDoModel] = []
        objects.forEach {
            var model = TaskListToDoModel(id: $0.id, name: $0.name, tasks: [])
            $0.tasks.forEach {
                let subtask = TaskToDoModel(id: $0.id, name: $0.name, notes: $0.notes, isCompleted: $0.isCompleted)
                model.tasks.append(subtask)
            }
            models.append(model)
        }
        return models
    }
    
    static func saveObject(for task: TaskListToDoModel) {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id == %@", argumentArray: [task.id])
        if let object = realm.objects(TaskListToDo.self).filter(predicate).first {
            try! realm.write {
                object.name = task.name
                realm.delete(object.tasks)
                task.tasks.forEach {
                    let todo = TaskToDo()
                    todo.name = $0.name
                    todo.notes = $0.notes
                    todo.isCompleted = $0.isCompleted
                    object.tasks.append(todo)
                }
            }
        }
        else {
            let newTask = TaskListToDo()
            newTask.name = task.name
            task.tasks.forEach {
                let newTodo = TaskToDo()
                newTodo.name = $0.name
                newTodo.notes = $0.notes
                newTodo.isCompleted = $0.isCompleted
                newTask.tasks.append(newTodo)
            }
            try! realm.write {
                realm.add(newTask)
            }
        }
    }
    
    static func deleteObject(for task: TaskListToDoModel) {
        let predicate = NSPredicate(format: "id == %@", argumentArray: [task.id])
        let realm = try! Realm()
        if let object = realm.objects(TaskListToDo.self).filter(predicate).first {
            try! realm.write {
                realm.delete(object.tasks)
                realm.delete(object)
            }
        }
    }
    
    static func saveObjectTask(_ TaskToDo:TaskToDo) {
        let realms = try! Realm()
        try! realms.write {
            realms.add(TaskToDo)
        }
    }
    
    static func deleteObjectTask(_ taskToDo: TaskToDo) {
        let realms = try! Realm()
        try! realms.write {
            realms.delete(taskToDo)
        }
    }
    
}
