//
//  File.swift
//  
//
//  Created by Maxim Safronov on 05.03.2021.
//

import Vapor

struct ProductRequest: Content {
    var id: Int?
    var categoryId: Int?
}
