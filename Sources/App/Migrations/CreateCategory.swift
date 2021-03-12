//
//  File.swift
//  
//
//  Created by Maxim Safronov on 11.03.2021.
//

import Foundation
import Fluent
import FluentSQLiteDriver
import FluentPostgresDriver

struct CreateCategory: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        let result = database.schema("categories")
            .id()
            .field("category_id", .int, .required)
            .field("name", .string)
            .create()
        
        let _ = Category(categoryId: 1, name: "Куртки")
            .save(on: database)
        let _ = Category(categoryId: 2, name: "Джинсы")
            .save(on: database)
        let _ = Category(categoryId: 3, name: "Брюки")
            .save(on: database)
        let _ = Category(categoryId: 4, name: "Юбки")
            .save(on: database)
        let _ = Category(categoryId: 5, name: "Сумки")
            .save(on: database)
        
        return result
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("categories").delete()
    }
}
