//
//  UserDefaultsView.swift
//  SkillBox14
//
//  Created by Илья Лобков on 30/11/2019.
//  Copyright © 2019 Илья Лобков. All rights reserved.
//
import UIKit

class UserDefaultsView: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = Persistance.shered.userName
        surnameLabel.text = Persistance.shered.userSurnamame
    }
    
    @IBAction func updateButton(_ sender: Any) {
        
        Persistance.shered.userName = nameTextField.text
        Persistance.shered.userSurnamame = surnameTextField.text
        nameLabel.text = Persistance.shered.userName
        surnameLabel.text = Persistance.shered.userSurnamame
    }
    
    // Mark: - настройка касаний
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        surnameTextField.resignFirstResponder()
    }
}
