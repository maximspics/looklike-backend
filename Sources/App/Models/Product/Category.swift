//
//  File.swift
//  
//
//  Created by Maxim Safronov on 05.03.2021.
//

import Foundation
import Vapor
import Fluent
import FluentSQLiteDriver

final class Category: Model, Content {
    static let schema = "categories"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "category_id")
    var categoryId: Int

    @Field(key: "name")
    var name: String
    
    init() { }
    
    init(categoryId: Int, name: String) {
        self.categoryId = categoryId
        self.name = name
    }
}
