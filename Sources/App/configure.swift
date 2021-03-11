import Vapor
import Fluent
import FluentSQLiteDriver
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) throws {
    
    // Ниже данные БД из Хероку
   
    /*
     let postgresConfiguration = PostgresConfiguration(hostname: "ec2-54-161-239-198.compute-1.amazonaws.com", port: 5432, username: "uicadcxwlhhbsb", password: "72d6eeb5d966d4e11f9ef1cb45d15f4cb2a80a1813b5ed24718c7134c9df428d", database: "d4n2n1rpodbp31", tlsConfiguration: .clientDefault)
     
     app.databases.use(DatabaseConfigurationFactory.postgres(configuration: postgresConfiguration), as: .psql)
     */
    
    app.databases.use(.postgres(hostname: "ec2-54-161-239-198.compute-1.amazonaws.com", username: "uicadcxwlhhbsb", password: "72d6eeb5d966d4e11f9ef1cb45d15f4cb2a80a1813b5ed24718c7134c9df428d", database: "d4n2n1rpodbp31"), as: .psql)
    
    app.migrations.add(CreateUser())
    
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
  //  app.databases.use(.sqlite(.file("looklike_bd_2.sqlite")), as: .sqlite)
 //   app.migrations.add(CreateUser())
 //   app.migrations.add(CreateProduct())
 //   app.migrations.add(CreateCategory())

    try app.autoMigrate().wait()
    // register routes
    try routes(app)
}
