//
//  ViewController.swift
//  VContact
//
//  Created by Wally on 29.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var login: UITextField!
    @IBOutlet var password: UITextField!
    var users: Dictionary<String,String> = ["Admin": "1234"]
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier {
        case "enterToTheFirstScene":
            let name = login.text!
            let password = password.text!
            guard name != "",password != ""  else {
                alertNoLogin()
                return false}
            if users[name] == password {
                return true
            } else {
                alertWrongLogin()
                return false }
        
        default:
            break
        }
        return false
    }

    private func alertNoLogin() {
        let alert = UIAlertController(title: "Ошибка", message: "Необходимо указать логин и пароль.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    private func alertWrongLogin() {
        let alert = UIAlertController(title: "Ошибка", message: "Указанный логин или пароль отсутствуют.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

