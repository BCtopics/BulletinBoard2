//
//  Message.swift
//  BulletinBoard2
//
//  Created by Bradley GIlmore on 6/12/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation
import CloudKit

class Message {
    
    //MARK: - Keys
    
    // Static
    static let typeKey = "Message"
    
    // Private
    private let textKey = "text"
    private let timestampKey = "timestamp"
    
    //MARK: - Internal Properties
    
    let text: String
    let timestamp: Date
    
    //MARK: - Initializers
    
    init(text: String, timestamp: Date) {
        self.text = text
        self.timestamp = timestamp
    }
    
    init?(cloudKitRecord: CKRecord) {
        guard let text = cloudKitRecord.value(forKey: textKey) as? String,
            let timestamp = cloudKitRecord.value(forKey: timestampKey) as? Date else {
                NSLog("Error Creating Model from CKRecord")
                return nil
        }
        
        self.text = text
        self.timestamp = timestamp
        
    }
    
    // What we send to Cloudkit
    var cloudKitRecord: CKRecord {
        
        let record = CKRecord(recordType: Message.typeKey)
        
        record.setValue(text, forKey: textKey)
        record.setValue(timestamp, forKey: timestampKey)
        
        return record
    }
    
    
}
