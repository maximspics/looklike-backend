//
//  File.swift
//  
//
//  Created by Maxim Safronov on 11.03.2021.
//

import Foundation
import Fluent
import FluentSQLiteDriver

struct CreateUser: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        let result = database.schema("users")
            .id()
            .field("user_id", .int, .required)
            .field("email", .string, .required)
            .field("password", .string, .required)
            .field("first_name", .string, .required)
            .field("last_name", .string)
            .create()
        
        let _ = User(userId: 1, email: "1", password: "1", firstName: "Админ", lastName: "Админович").save(on: database)
        
        return result
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users").delete()
    }
}
