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

final class Product: Model, Content {
    static let schema = "products"
        
    @ID(key: .id)
    var id: UUID?

    @Field(key: "id_product")
    var productId: Int
    
    @Field(key: "id_category")
    var categoryId: Int

    @Field(key: "name")
    var title: String
    
    @Field(key: "image_link")
    var imageLink: String
    
    init() { }
    
    init(id: Int? = nil, categoryId: Int, title: String, imageLink: String) {
        self.productId = id ?? -1
        self.categoryId = categoryId
        self.title = title
        self.imageLink = imageLink
    }
}

