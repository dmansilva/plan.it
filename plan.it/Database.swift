//
//  Database.swift
//  plan.it
//
//  Created by Daniel Silva on 4/6/17.
//  Copyright © 2017 D Silvv Apps. All rights reserved.
//

import Foundation
import Firebase


class DB {
    
    // reference to the Firebase data store
    private var dbRef : FIRDatabaseReference!
    
    // where the Users will be stored
    private var usersDB : FIRDatabaseReference
    
    init() {
        
        self.dbRef = FIRDatabase.database().reference()
        // sets the reference to the Users part of the database
        self.usersDB = self.dbRef.child("users")
        
        
    }
    
    func insertNewUser(email: String, description: String, events: String, favorites: String, followers: String, following: String, image: String, interests: String, firstName: String, lastName: String, notifications: String, sustainabilityScore: Int, type: Int) {
        
        // gets the randomized key for the user
        let key = self.usersDB.childByAutoId().key
        
        let user : NSDictionary = ["email" : email, "description" : description, "events" : events, "favorites" : favorites, "followers" : followers, "following" : following, "image" : image, "interests" : interests, "firstName" : firstName, "lastName" : lastName, "notifications" : notifications, "sustainabilityScore" : sustainabilityScore, "type" : type]
        
        self.usersDB.updateChildValues(["/\(key)" : user])
        
    }
    
    
}
