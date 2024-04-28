import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    app.get("test") { req async throws in
        let band = Band(name: "Retro Rewind", slug: "retro-rewind")
        try await band.create(on: req.db)

        let artist = Artist(name: "Poison", bandID: try band.requireID())
        try await artist.create(on: req.db)

        let song = Song(
            title: "Every Rose Has Its Thorn",
            artistID: try artist.requireID(),
            bandID: try band.requireID()
        )
        try await song.create(on: req.db)

        return song
    }
}
