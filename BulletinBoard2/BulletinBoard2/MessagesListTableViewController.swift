//
//  MessagesListTableViewController.swift
//  BulletinBoard2
//
//  Created by Bradley GIlmore on 6/12/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import UIKit

class MessagesListTableViewController: UITableViewController {
    
    //MARK: - DateFormatter
    
    var dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageController.messages.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)

        let message = MessageController.messages[indexPath.row]
        cell.textLabel?.text = message.text
        
        let formattedDate = dateFormatter.string(from: message.timestamp)
        cell.detailTextLabel?.text = formattedDate

        return cell
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var messageTextField: UITextField!
    
    //MARK: - IBActions
    
    @IBAction func submitMessageButtonTapped(_ sender: Any) {
        
        guard let text = messageTextField.text else { return }
        
        MessageController.addMessageWith(text: text)
    }
    
}

