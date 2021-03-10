import Vapor
import FluentSQLiteDriver

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.databases.use(.sqlite(.file("looklike_bd_2.sqlite")), as: .sqlite)
    app.migrations.add(CreateUser())
    app.migrations.add(CreateProduct())
    app.migrations.add(CreateCategory())
    try app.autoMigrate().wait()
    // register routes
    try routes(app)
}
