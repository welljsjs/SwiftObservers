//
//  Singleton.swift
//
//  Created by Julius Schmidt on 28.02.18.
//  Copyright © 2018 Julius Schmidt. All rights reserved.
//

import UIKit

internal final class Singleton: NSObject {
    private override init() { }
    
    /// The shared instance.
    static let shared = Singleton()
    
    /** The list of observers/delegates, that implement the *SingletonObserver* protocol.
     Everytime a value changes (messages or contacts), the delegate (observer) is informed via one of
     its methods/functions.
    */
    private var observers: [SingletonObserver]?
    
    
    // MARK: - Properties (Just some example properties)
    internal var messages = [Message]() {
        didSet {
            informDelegates { (delegate) in
                delegate.didSetMessages?(messages: messages)
            }
        }
    }
    internal var contacts = [Contact]() {
        didSet {
            informDelegates { (delegate) in
                delegate.didSetContacts?(contacts: contacts)
            }
        }
    }
    
    
    // MARK: - Custom Functions
    /**
     Adds an observer to the list of observers. The observer must implement the protocol *SingletonObserver*
     Observers can be used to observe value changes. They are basically simple delegates whose functions are triggered
     on property observers like *didSet* (implemented by Swift, Apple)
     - Parameters:
        - target: The target of type *SingletonObserver* that shall be added to the list of observers. It
        can be removed by using *removeObserver(_:)* function.
    */
    internal final func addObserver(target: SingletonObserver) {
        if let observers = observers {
            if !observers.contains(where: { (observer) -> Bool in
                return observer === target
            }) {
                self.observers?.append(target)
            }
        } else {
            observers = [target]
        }
    }
    
    /**
     Removes an observer from the list of observers. In consequence, the observer does no longer exist and therefore is no
     longer informed about any further value changes that may happen later.
     - Parameters:
        - target: The target of type *SingletonObserver* that shall be removed from the list of observers.
    */
    internal final func removeObserver(target: SingletonObserver) {
        if let observers = observers {
            if let indexToRemove = observers.index(where: { (observer) -> Bool in
                return observer === target
            }) {
                self.observers?.remove(at: indexToRemove)
            }
        }
    }
    
    
    /// Executes the same code (passed as argument *execution*) for all observers that are in the list of observers.
    private final func informDelegates(execution: ((SingletonObserver) -> Void)) {
        if let delegates = observers {
            for delegate in delegates {
                execution(delegate)
            }
        }
    }
}

// MARK: - SingletonObserver Protocol
/** A protocol that contains functions that are triggered when a specific value changes or was set.
 Have a closer look onto the *Singleton* class if you want to gain more information about when these functions
 are triggered.
 */
@objc protocol SingletonObserver {
    /// Triggered whenever the contacts have been set (or an edit was performed). Does not trigger on initialization.
    @objc optional func didSetContacts(contacts: [Contact])
    /// Triggered whenever the messages have been set (or an edit was performed). Does not trigger on initialization.
    @objc optional func didSetMessages(messages: [Message])
}
