//
//  File.swift
//  
//
//  Created by Maxim Safronov on 05.03.2021.
//

import Vapor

class Results {
    
    func returnError(_ message: String) -> String {
        return "{\"result\": 0, \"message\": \"\(message)\"}"
    }
    
    func error(message: String, _ req: Request) -> EventLoopFuture<String> {
        return req.eventLoop.makeSucceededFuture(returnError(message))
    }
    
    func returnResults(_ res: [Dictionary<String,Any>]? = nil, _ req: Request) -> EventLoopFuture<String> {
        if let res = res {
            if let jsonData = try? JSONSerialization.data(withJSONObject: res, options: [.withoutEscapingSlashes, .prettyPrinted]),
               let jsonString = String(data: jsonData, encoding: .utf8)
            {
                print(jsonString)
                return req.eventLoop.makeSucceededFuture(jsonString)
            } else {
                return req.eventLoop.makeSucceededFuture(returnError("Неизвестная ошибка"))
            }
        } else {
            return req.eventLoop.makeSucceededFuture("{\"result\": 1}")
        }
    }
    
    func returnResult(_ res: Dictionary<String,Any>? = nil, _ req: Request) -> EventLoopFuture<String> {
        if var res = res {
            if res["result"] == nil {
                res["result"] = 1
            }
            if let jsonData = try? JSONSerialization.data(withJSONObject: res, options: [.withoutEscapingSlashes, .prettyPrinted]),
               let jsonString = String(data: jsonData, encoding: .utf8)
            {
                print(jsonString)
                return req.eventLoop.makeSucceededFuture(jsonString)
            } else {
                return req.eventLoop.makeSucceededFuture(returnError("Неизвестная ошибка"))
            }
        } else {
            return req.eventLoop.makeSucceededFuture("{\"result\": 1}")
        }
    }
}
