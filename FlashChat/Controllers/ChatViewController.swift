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
    
    var messages: [MessageModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.TableView.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.TableView.cellIdentifier)

        title = Constants.applicationName
        navigationItem.hidesBackButton = true
        
        loadMessages()
    }
    
    func loadMessages() {
        
        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
                
            if let err = error {
                print(err.localizedDescription)
            } else {
                self.messages = []
                guard let snapshotDocuments = querySnapshot?.documents else {return}
                for doc in snapshotDocuments {
                    let data = doc.data()
                    guard let sender = data[Constants.FStore.senderField] as? String, let message = data[Constants.FStore.bodyField] as? String else {return}
                    
                    let newMessage = MessageModel(sender: sender, body: message)
                    self.messages.append(newMessage)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        guard let messageSender = Auth.auth().currentUser?.email, let messageBody = messageTextfield.text else {return}
        
        db.collection(Constants.FStore.collectionName).addDocument(data: [
            Constants.FStore.senderField: messageSender,
            Constants.FStore.bodyField: messageBody,
            Constants.FStore.dateField: Date().timeIntervalSince1970
        ]) { error in
            if let e = error {
                print(e.localizedDescription)
            }
        }
        
        messageTextfield.text = ""
    }
    

    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError  {
            print(signOutError.localizedDescription)
        }
    }
    
    
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentMessage = messages[indexPath.row]
        guard let currentUser = Auth.auth().currentUser?.email else {return UITableViewCell()}
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableView.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLabel.text = messages[indexPath.row].body
        
        if currentMessage.sender == currentUser {
            cell.otherProfilePictureImageView.isHidden = true
            cell.profilePictureImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
            cell.messageLabel.textColor = UIColor(named: Constants.BrandColors.purple)
        } else {
            cell.otherProfilePictureImageView.isHidden = false
            cell.profilePictureImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.purple)
            cell.messageLabel.textColor = UIColor(named: Constants.BrandColors.lightPurple)
        }
        
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
