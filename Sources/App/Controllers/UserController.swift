//
//  File.swift
//  
//
//  Created by Maxim Safronov on 05.03.2021.
//

import Vapor
import FluentSQLiteDriver

class UserController {
    
    var results = Results()
    
    func register(_ req: Request) throws -> EventLoopFuture<String> {
        guard let user = try? req.content.decode(UserRequest.self),
              let email = user.login,
              let password = user.password,
              let firstName = user.firstName,
              let lastName = user.lastName else { throw Abort(.badRequest) }
        
        return User.query(on: req.db)
            .filter(\.$email, .equal, email)
            .limit(1)
            .first()
            .flatMap { user -> EventLoopFuture<String> in
                if let _ = user {
                    return self.results.error(message: "Пользователь с таким email уже существует!", req)
                } else {
                    return User.query(on: req.db).max(\.$userId).flatMapAlways { result -> EventLoopFuture<String> in
                        switch result {
                        case let .success(maxId):
                            if let maxId = maxId {
                                return User(userId: maxId + 1, email: email, password: password, firstName: firstName, lastName: lastName)
                                    .save(on: req.db).flatMapAlways { (result) -> EventLoopFuture<String> in
                                        switch result {
                                        case .success():
                                            let result: Dictionary<String, Any> =
                                                [
                                                    "message": "\(firstName), вы успешно зарегистрированы!"
                                                ]
                                            return self.results.returnResult(result, req)
                                        case .failure(_):
                                            return self.results.error(message: "Ошибка регистрации!", req)
                                        }
                                    }
                            }
                        case .failure(_):
                            return self.results.error(message: "Ошибка регистрации!", req)
                        }
                        return self.results.error(message: "Ошибка регистрации!", req)
                    }
                }
            }
    }
    
    func login(_ req: Request) throws -> EventLoopFuture<String> {
        guard let user = try? req.content.decode(UserRequest.self),
              let email = user.login,
              let password = user.password else { throw Abort(.badRequest) }
        
        return User.query(on: req.db)
            .filter(\.$email, .equal, email)
            .filter(\.$password, .equal, password)
            .limit(1)
            .first()
            .flatMap { user -> EventLoopFuture<String> in
                if let user = user {
                    let result: Dictionary<String, Any> =
                        [
                            "message": "\(user.firstName ?? ""), вы успешно зарегистрированы!",
                            "token": "some_auth_token"
                        ]
                    return self.results.returnResult(result, req)
                } else {
                    return self.results.error(message: "Неправильный логин или пароль!", req)
                }
            }
    }
    
}
