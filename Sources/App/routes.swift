import Fluent
import FluentSQLiteDriver
import Vapor

func routes(_ app: Application) throws {
    
    app.get("test") { req in
        return "Тест"
    }
    
    let result = Results()
    
    app.get { req in
        return result.returnError("Forbidden")
    }
    
    let userController = UserController()
    app.post("user", "registration", use: userController.register)
    app.post("user", "auth", use: userController.login)
    
    let productController = ProductController()
    app.post("category", "all", use: productController.categories)
    app.post("products", "all", use: productController.list)
    app.post("products", "product", use: productController.product)
}
