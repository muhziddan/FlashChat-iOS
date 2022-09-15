//
//  ChatViewController.swift
//  Flash Chat
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var messages: [MessageModel] = [
        MessageModel(sender: "1@2.com", body: "Hey"),
        MessageModel(sender: "a@b.com", body: "Hello"),
        MessageModel(sender: "1@2.com", body: "How is life")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self

        title = Constants.applicationName
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    

    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError  {
            print(signOutError)
        }
    }
    
    
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableView.cellIdentifier, for: indexPath)
        cell.selectionStyle = .none
        
        var cellContent = cell.defaultContentConfiguration()
        cellContent.text = messages[0].body
        cellContent.secondaryText = messages[0].sender
        
        cell.contentConfiguration = cellContent
        return cell
    }
    
    
}
