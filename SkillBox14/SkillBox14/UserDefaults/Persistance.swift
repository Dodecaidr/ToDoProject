//
//  Persistance.swift
//  SkillBox14
//
//  Created by Илья Лобков on 30/11/2019.
//  Copyright © 2019 Илья Лобков. All rights reserved.
//

import Foundation

class Persistance {
    static let shered = Persistance()
    
    private let kUserNameKey = "Persistance.kUserNameKey"
    private let kUserSurnamameKey = "Persistance.kUserSurnamameKey "
    
    var userName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserNameKey) }
        get { return UserDefaults.standard.string(forKey: kUserNameKey) }
    }
    
    var userSurnamame: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserSurnamameKey) }
        get { return UserDefaults.standard.string(forKey: kUserSurnamameKey) }
        
    }
}
