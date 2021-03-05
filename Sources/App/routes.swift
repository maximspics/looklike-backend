import Fluent
import FluentSQLiteDriver
import Vapor

func routes(_ app: Application) throws {
    
    let result = Results()
    
    app.get { req in
        return result.returnError("Forbidden")
    }
    
    let userController = UserController()
    app.post("user", "registration", use: userController.register)
    app.post("user", "auth", use: userController.login)
}
