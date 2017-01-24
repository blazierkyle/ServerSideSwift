import Vapor
import VaporPostgreSQL


let drop = Droplet()
//    providers: [VaporPostgreSQL.Provider.self]
//)

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

try drop.addProvider(VaporPostgreSQL.Provider.self)

// Route with raw DB connection
drop.get("version") { request in
	if let db = drop.database?.driver as? PostgreSQLDriver {
			let version = try db.raw("SELECT version()")
			return try JSON(node: version)
		}else{
			return "no db connection"
		}

}

// Security square API
drop.get("squareMe") { request in
    guard let intValue = request.data["number"]?.int else {
        
        return try JSON(node: ["Error" : "Oops... You didn't provide a valid integer to be squared! Try using the end of the URL to be something like: 'squareMe?number=2'"])
        
    }
    
    do {
        return try JSON(node: ["Success" : "You provided the number \(intValue), which when squared becomes: \(intValue * intValue)"])
    } catch {
        return try JSON(node: ["Error" : "Oops... the integer you entered was too large, please try a smaller one."])
        
    }
    
}

drop.resource("posts", PostController())

drop.run()
