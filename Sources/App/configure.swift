import Vapor
import Fluent
import FluentSQLiteDriver
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) throws {
    /*
    if let databaseURL = Environment.get("DATABASE_URL") {
        app.databases.use(try .postgres(
            url: databaseURL
        ), as: .psql)
    } else {
        // ...
    }
    */
    app.databases.use(.sqlite(.file("looklike_bd_2.sqlite")), as: .sqlite)

    app.migrations.add(CreateUser())
    app.migrations.add(CreateProduct())
    app.migrations.add(CreateCategory())
    
    try app.autoMigrate().wait()
    
    try routes(app)
}
