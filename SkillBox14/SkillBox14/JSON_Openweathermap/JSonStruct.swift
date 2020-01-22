//
//  JSonStruct.swift
//  SkillBox14
//
//  Created by Илья Лобков on 22/01/2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import Foundation

struct Request:Decodable {
    var list : [Weather?]
}

struct Weather:Decodable {
    var main : Tempucher?
    var dt_txt : String?
    var weather : [IconStatus?]
}

struct Tempucher:Decodable {
    var temp : Float?
}

struct IconStatus:Decodable {
    var icon : String?
}
