//
//  ViewController.swift
//  VContact
//
//  Created by Wally on 29.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    var users: Dictionary<String,String> = ["": ""]
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    @IBAction func enterButoon(_ sender: UIButton) {
        guard let name = loginTextField.text,
              let password = passwordTextField.text
              else {
            alertError(message: "Необходимо указать логин и пароль.")
            return }
        if users[name] == password {
            performSegue(withIdentifier: "segueAfterRegistration", sender: nil)
        } else {
            alertError(message: "Указанный логин или пароль отсутствуют.")
            return } 
    }
   
    private func alertError(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}

