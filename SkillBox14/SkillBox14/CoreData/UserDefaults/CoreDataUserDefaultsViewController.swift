//
//  CoreDataUserDefaultsViewController.swift
//  SkillBox14
//
//  Created by Илья Лобков on 19.01.2020.
//  Copyright © 2020 Илья Лобков. All rights reserved.
//

import UIKit
import CoreData

class CoreDataUserDefaultsViewController: UIViewController {
    @IBOutlet weak var nameTextLable: UILabel!
    @IBOutlet weak var surnameTextLable: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    
    var usersData: [UserDataCoreData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistenContainer.viewContext
        
        let fetchRequest: NSFetchRequest<UserDataCoreData> = UserDataCoreData.fetchRequest()
        
        do {
            usersData = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        
        if usersData.count == 0 {
            
            nameTextLable.text = "Enter Name"
            surnameTextLable.text = "Enter Surname"
            
        } else {
            
            nameTextLable.text = usersData[0].name
            surnameTextLable.text = usersData[0].surname
            
        }
    }
    
    @IBAction func buttonCoreData(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistenContainer.viewContext
        
        if usersData.count == 0 {
            let entity = NSEntityDescription.entity(forEntityName: "UserDataCoreData", in: context)
            let userDataObject = NSManagedObject(entity: entity!, insertInto: context) as! UserDataCoreData
            userDataObject.name = nameTextField.text
            userDataObject.surname = surnameTextField.text
            print("save complite")
            
            do {
                try context.save()
                //      toDoItems.append(taskObject)
            } catch {
                print(error.localizedDescription )
            }
            
            nameTextLable.text = userDataObject.name
            surnameTextLable.text = userDataObject.surname
            
            // Использовать функцию перезагрузки вью для того что бы небыло перезаписи при первом запуске
            
        } else {
            
            usersData[0].name = nameTextField.text
            usersData[0].surname = surnameTextField.text
            nameTextLable.text = usersData[0].name
            surnameTextLable.text = usersData[0].surname
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        surnameTextField.resignFirstResponder()
    }
}
