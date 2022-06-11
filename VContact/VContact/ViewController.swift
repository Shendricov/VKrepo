//
//  ViewController.swift
//  VContact
//
//  Created by Wally on 29.04.2022.
//

import UIKit

class Session {
    private init() { }
    
    static let user = Session()
    
    var token: String = " "
    var userID: Int = 0
}

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
            alertError(message: "Enter login and password")
            return }
        if users[name] == password {
            performSegue(withIdentifier: "segueAfterRegistration", sender: nil)
        } else {
            alertError(message: "Your login or password wrong.")
            return } 
    }
   
    private func alertError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func logoOutUnwind (_ segue: UIStoryboardSegue) {}
}

