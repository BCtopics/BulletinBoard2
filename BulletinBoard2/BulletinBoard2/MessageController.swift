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
    
    static var messages: [Message] = [] {
        didSet {
            NotificationCenter.default.post(name: messagesWereUpdatedNotification, object: self)
        }
    }
    
    //MARK: - Fetch/Post
    
    static func addMessageWith(text: String) {
        
        let message = Message(text: text)
        
        CKContainer.default().publicCloudDatabase.save(message.cloudKitRecord) { (record, error) in
            
            if let error = error { NSLog("error saving to CloudKit\(error.localizedDescription)") } else {
                self.messages.append(message)
            }
            
        }
        
    }
    
    static func fetchMessages() {
        
        // Doesn't filter the messages. We just want all of the messages fetched.
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: Message.typeKey, predicate: predicate)
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            
            if let error = error {
                NSLog("Error fetching messages: \(error.localizedDescription)")
            }
            
            guard let records = records else { return }
            
            let messages = records.flatMap { Message(cloudKitRecord: $0) }
            
            self.messages = messages
        }
        
    }
    
    //MARK: - CKSubscriptions
    
    static func subscribeToCreationOfMessages() {
        
        // Create predicate to filter/sort by
        let predicate = NSPredicate(value: true)
        
        // Create the subscription
        let subscription = CKQuerySubscription(recordType: Message.typeKey, predicate: predicate, options: .firesOnRecordCreation)
        
        // Set up notification info
        let notificationInfo = CKNotificationInfo()
        
        notificationInfo.alertBody = "There is a new message in the bulletin board"
        notificationInfo.soundName = "default"
        notificationInfo.shouldSendContentAvailable = true
        
        // Attach the notification to the subscription
        subscription.notificationInfo = notificationInfo
        
        // Send the subscription to CloudKit
        CKContainer.default().publicCloudDatabase.save(subscription) { (_, error) in
            if let error = error {
                NSLog("Error saving created subscription to CloudKit \(error.localizedDescription)")
            }
        }
        
    }
    
    
}






