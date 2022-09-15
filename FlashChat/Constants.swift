//
//  Constants.swift
//  FlashChat
//
//  Created by Muhammad Ziddan Hidayatullah on 15/09/22.
//

struct Constants {
    
    static let applicationName = "⚡️FlashChat"
    
    struct TableView {
        static let cellIdentifier = "ReusableCell"
        static let cellNibName = "MessageCell"
    }
    
    struct Segue {
        static let registerToChat = "RegisterToChatVC"
        static let loginToChat = "LoginToChatVC"
    }
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lightBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
