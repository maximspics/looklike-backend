//
//  File.swift
//  
//
//  Created by Maxim Safronov on 05.03.2021.
//

import Foundation
import Fluent
import FluentPostgresDriver

final class User: Model {
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
