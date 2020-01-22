//
//  JSonRequest.swift
//  SkillBox14
//
//  Created by Илья Лобков on 20.01.2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import Foundation
import Alamofire

class JSonRequest {
    func loadAlomaCatigories(callback: @escaping ([Weather])->()) {
        Alamofire.request( "http://api.openweathermap.org/data/2.5/forecast?q=Moscow,ru&appid=f4e8241056c46e3ab2fa1983bf196af9&units=metric", method: .get).responseJSON { response in
            
            if let data = response.data {
                do {
                    let cityWether = try JSONDecoder().decode(Request.self, from: data)
                    var listAloma: [Weather] = []
                    cityWether.list.forEach { weather in
                        if let weather = weather {
                            listAloma.append(weather)
                        }
                    }
                    callback(listAloma)
                } catch let error {
                    print(error)
                }
            }
        }
    }
}
