//
//  WeatherTableViewController.swift
//  SkillBox14
//
//  Created by Илья Лобков on 20.01.2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    
    var arrayWether: [Weather] = []
    var errorDownload: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        JSonRequest().loadAlomaCatigories { list in
            self.arrayWether = list
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard arrayWether.count != 0 else {
            
            let wetherMass = WetherManager.noConect()
            
            return wetherMass.count
            
        }
        return arrayWether.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WetherCell", for: indexPath) as! WetherCell
        
        if arrayWether.count != 0 {
            let model = arrayWether[indexPath.row]
            print (model)
            let modelIcon = model.weather[0]?.icon
            
            cell.wetherDataLabel.text = model.dt_txt
            cell.wetherTemperatureLabel.text = "\(Int(model.main?.temp ?? 0))˚C"
            cell.wetherImageView.image = UIImage.init(named: String( modelIcon ?? "01d"))
            
        } else {
            let wetherMass = WetherManager.noConect()
            cell.wetherTemperatureLabel.text = String( wetherMass[indexPath.row].temp)
            cell.wetherDataLabel.text = wetherMass[indexPath.row].data
            cell.wetherImageView.image = UIImage.init(named: wetherMass[indexPath.row].icon)
        }
        
        return cell
    }
}
