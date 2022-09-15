//
//  RegisterViewController.swift
//  Flash Chat iOS13
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e.localizedDescription)
                return
            } else {
                self.performSegue(withIdentifier: Constants.Segue.registerToChat, sender: self)
            }
        }
    }
    
    
}
