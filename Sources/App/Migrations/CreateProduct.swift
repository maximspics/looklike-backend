//
//  File.swift
//  
//
//  Created by Maxim Safronov on 11.03.2021.
//

import Foundation
import Fluent
import FluentSQLiteDriver

struct CreateProduct: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        let result = database.schema("products")
            .id()
            .field("id_product", .int, .required)
            .field("id_category", .int, .required)
            .field("name", .string)
            .field("image_link", .string, .required)
            .create()
        
        return result
}

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("products").delete()
    }
}
