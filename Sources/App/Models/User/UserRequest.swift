//
//  File.swift
//  
//
//  Created by Maxim Safronov on 05.03.2021.
//

import Vapor

struct UserRequest: Content {
    var userId: Int?
    var login: String?
    var password: String?
    var firstName: String?
    var lastName: String?
}
