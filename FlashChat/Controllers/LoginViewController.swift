//
//  LoginViewController.swift
//  Flash Chat iOS13
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e.localizedDescription)
            } else {
                self.performSegue(withIdentifier: "LoginToChatVC", sender: self)
            }
        }
    }
    
}
