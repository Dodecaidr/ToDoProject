//
//  RealmToDo.swift
//  SkillBox14
//
//  Created by Илья Лобков on 01/12/2019.
//  Copyright © 2019 Илья Лобков. All rights reserved.
//


import RealmSwift

class TaskToDo: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var notes = ""
    @objc dynamic var isCompleted = false
}

class TaskListToDo: Object {
    @objc dynamic var name = ""
    @objc dynamic var id: String = ""
    var tasks = List<TaskToDo>()
}


struct TaskToDoModel {
    var id: String = UUID().uuidString
    var name: String
    var notes: String
    var isCompleted: Bool
}

struct TaskListToDoModel {
    var id: String = UUID().uuidString
    var name: String
    var tasks: [TaskToDoModel] = []
}
