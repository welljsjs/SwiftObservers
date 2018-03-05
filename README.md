# SwiftObservers
Observe Singleton array values in Swift without KVO etc. 

This is a simple project written in Swift that allows to observe value changes made to an array via delegates (called observers here, they're protocols).

The advantage is that this method is very swifty and can be used (as shown here) for a Singleton (shared instance).

### Example usage: 

```Swift
//
//  ViewController.swift
//
//  Created by Julius Schmidt on 27.02.18.
//  Copyright © 2018 Julius Schmidt. All rights reserved.
//

import UIKit

class ChatsController: UIViewController, SingletonObserver {
    
    // MARK: Variables and Outlets
    private final var messages: [Message] = Singleton.shared.messages
    private final var contacts: [Contact] = Singleton.shared.contacts
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Singleton.shared.addObserver(target: self)
    }
    
    deinit {
        Singleton.shared.removeObserver(target: self)
    }
}

// MARK: - Singleton Delegate
extension ChatsController {
    func didSetContacts(contacts: [Contact]) {
        self.contacts = contacts
        // Reload a UITableView or do anything you want
    }
    func didSetMessages(messages: [Message]) {
        self.messages = messages
        // Reload a UITableView or do anything you want
    }
}

```
