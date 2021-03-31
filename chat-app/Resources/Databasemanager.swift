//
//  Databasemanager.swift
//  chat-app
//
//  Created by Aida Pourshirazi on 3/30/21.
//

import Foundation
import FirebaseDatabase

final class Databasemanager {
    
    static let shared = Databasemanager ()
    
    private let database = Database.database().reference()
    
    public func test () {
        database.child("foo").setValue(["something": true])
    }
    
    
   
    
    
}
