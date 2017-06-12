//
//  MessageController.swift
//  BulletinBoard2
//
//  Created by Bradley GIlmore on 6/12/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation
import CloudKit

class MessageController {
    
    //MARK: - NotificationCenter
    
    static let messagesWereUpdatedNotification = Notification.Name("messagesWereUpdated")
    
    //MARK: - Properties
    
    static var messages: [Message] = []
    
    //MARK: - Fetch/Post
    
    static func addMessageWith(text: String) {
        
        let message = Message(text: text)
        
        CKContainer.default().publicCloudDatabase.save(message.cloudKitRecord) { (record, error) in
            
            if let error = error { NSLog("error saving to CloudKit\(error.localizedDescription)") } else {
                self.messages.append(message)
            }
            
        }
        
    }
    
}
