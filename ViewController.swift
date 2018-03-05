//
//  ViewController.swift
//
//  Created by Julius Schmidt on 27.02.18.
//  Copyright © 2018 Julius Schmidt. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SingletonObserver {
    
    // MARK: Properties
    private final var messages: [Message] = Singleton.shared.messages
    private final var contacts: [Contact] = Singleton.shared.contacts
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Singleton.shared.addObserver(target: self)
    }
    
    
    // Remove observer on deinitialization.
    deinit {
        Singleton.shared.removeObserver(target: self)
    }
}



// MARK: - Singleton Delegate
extension ChatsController {
    // The following functions are all optional.
    
    func didSetContacts(contacts: [Contact]) {
        self.contacts = contacts
    }
    func didSetMessages(messages: [Message]) {
        self.messages = messages
    }
}
