//
//  ChatViewController.swift
//  Flash Chat
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [MessageModel] = [
        MessageModel(sender: "1@2.com", body: "Hey"),
        MessageModel(sender: "a@b.com", body: "Hello"),
        MessageModel(sender: "1@2.com", body: "How is life")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.TableView.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.TableView.cellIdentifier)

        title = Constants.applicationName
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        guard let messageSender = Auth.auth().currentUser?.email, let messageBody = messageTextfield.text else {return}
        
        db.collection(Constants.FStore.collectionName).addDocument(data: [
            Constants.FStore.senderField: messageSender,
            Constants.FStore.bodyField: messageBody
        ]) { error in
            if let e = error {
                print(e)
            }
        }
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableView.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLabel.text = messages[indexPath.row].body
        
        // use this code below when you are not editing the .xib or .storyboard file
//        cell.selectionStyle = .none
//
//        var cellContent = cell.defaultContentConfiguration()
//        cellContent.text = messages[0].body
//        cellContent.secondaryText = messages[0].sender
//
//        cell.contentConfiguration = cellContent
        return cell
    }
    
    
}
