//
//  File.swift
//  
//
//  Created by Maxim Safronov on 05.03.2021.
//

import Vapor
import FluentSQLiteDriver

final class User: Model, Content {
    // Name of the table or collection.
    static let schema = "users"
    
    // Unique identifier for this User.
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "user_id")
    var userId: Int?
    
    @Field(key: "email")
    var email: String?
    
    @Field(key: "password")
    var password: String?
    
    @Field(key: "first_name")
    var firstName: String?
    
    @OptionalField(key: "last_name")
    var lastName: String?
    
    // Creates a new, empty User.
    init() { }
    
    // Creates a new User with all properties set.
    init(id: UUID? = nil, userId: Int? = nil, email: String, password: String, firstName: String, lastName: String) {
        self.id = id
        self.userId = userId
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
    }
}

struct CreateUser: Migration {
    // Prepares the database for storing User models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        let result = database.schema("users")
            .id()
            .field("userId", .int, .required)
            .field("email", .string, .required)
            .field("password", .string, .required)
            .field("first_name", .string, .required)
            .field("last_name", .string)
            .create()
        
        let _ = User(userId: 1, email: "1", password: "1", firstName: "Админ", lastName: "Админович").save(on: database)
        
        return result
    }

    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users").delete()
    }
}
