//
//  JSonStruct.swift
//  SkillBox14
//
//  Created by Илья Лобков on 22/01/2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import Foundation
import RealmSwift

//class RealmRequest: Object {
//    var weather = List<RealmWeather>()
//}
//class RealmWeather: Object {
//    var main = List<RealmTempucher>()
//    @objc dynamic var dt_txt = ""
//    var weather = List<RealmIconStatus>()
//}
//class RealmTempucher: Object {
//    dynamic var temp : Float? = 0
//}
//class RealmIconStatus: Object {
//    @objc dynamic var icon = ""
//}

class Wether: Object{
    @objc dynamic var data = ""
    @objc dynamic var icon = ""
    @objc dynamic var temp : Int = 0
}

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
