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
    
    //MARK: - Internal Properties
    
    let text: String
    let timestamp: Date
    
    //MARK: - Initializers
    
    init(text: String, timestamp: Date) {
        self.text = text
        self.timestamp = timestamp
    }
    
    
}
