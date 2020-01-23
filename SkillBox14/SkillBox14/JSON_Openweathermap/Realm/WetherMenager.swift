//
//  WetherMenager.swift
//  SkillBox14
//
//  Created by Илья Лобков on 23.01.2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import Foundation
import RealmSwift

class WetherManager {
    
    static func saveObject (data:String,image:String,temperature:Int) {
        let realm = try! Realm()
        let wetherRealm = Wether()
        
        wetherRealm.data = data
        wetherRealm.icon = image
        wetherRealm.temp = temperature
        
        try! realm.write {
            realm.add(wetherRealm)
        }
    }
    
    static func deliteObject() {
        let realm = try! Realm()
        let wether = realm.objects(Wether.self)
        guard wether.count != 0 else { return }
        try! realm.write {
            for element in wether {
                realm.delete(element)
            }
        }
    }
    
    static func noConect()->[Wether] {
        let realm = try! Realm()
        let wether = realm.objects(Wether.self)
        var wetherMas:[Wether] = []
        for element in wether {
            wetherMas.append(element)
        }
        return wetherMas
    }
}
