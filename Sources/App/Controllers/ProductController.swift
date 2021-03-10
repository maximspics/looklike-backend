//
//  File.swift
//  
//
//  Created by Maxim Safronov on 05.03.2021.
//

import Vapor
import FluentSQLiteDriver

class ProductController {
    
    var results = Results()
    
    func categories(_ req: Request) -> EventLoopFuture<String> {
        return Category.query(on: req.db)
            .all()
            .map { category -> [[String: Any]] in
                return category.map { category -> [String: Any] in
                    if let categoryId = category.$categoryId.value,
                       let name = category.$name.value {
                        return [
                            "categoryId": categoryId,
                            "name": name,
                            "result": 1
                        ]
                    } else {
                        return [
                            "result": 0
                        ]
                    }
                }
        }.flatMap { result -> EventLoopFuture<String> in
            return self.results.returnResults(result, req)
        }
    }
    
    func list(_ req: Request) -> EventLoopFuture<String> {
        return Product.query(on: req.db)
            .all()
            .map { product -> [[String: Any]] in
                return product.map { product -> [String: Any] in
                    if let productId = product.$productId.value,
                       let categoryId = product.$categoryId.value,
                       let title = product.$title.value,
                       let imageLink = product.$imageLink.value {
                        return [
                            "productId": productId,
                            "categoryId": categoryId,
                            "title": title,
                            "imageLink": imageLink,
                            "result": 1
                        ]
                    } else {
                        return [
                            "result": 0
                        ]
                    }
                }
        }.flatMap { result -> EventLoopFuture<String> in
            return self.results.returnResults(result, req)
        }
    }
    
    func product(_ req: Request) throws -> EventLoopFuture<String> {
        guard let product = try? req.content.decode(ProductRequest.self),
            let productId = product.id else { throw Abort(.badRequest) }
        
        return Product.query(on: req.db)
            .filter(\.$productId, .equal, productId)
            .limit(1)
            .first()
            .flatMap { product -> EventLoopFuture<String> in
            if let product = product {
                let result: Dictionary<String, Any> =
                    [
                        "id": product.productId,
                        "categoryId": product.categoryId,
                        "title": product.title,
                        "imageLink": product.imageLink 
                    ]
                return self.results.returnResult(result, req)
            } else {
                return self.results.error(message: "Товар не найден!", req)
            }
        }
    }
}
