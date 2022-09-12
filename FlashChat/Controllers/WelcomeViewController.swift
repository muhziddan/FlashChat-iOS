//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = ""
        var charIndex = 0
        let label = "⚡️FlashChat"
        for char in label {
            Timer.scheduledTimer(withTimeInterval: 0.1 * Double(charIndex), repeats: false) { timer in
                self.titleLabel.text?.append(char)
            }
            charIndex += 1
        }
       
    }
    

}
