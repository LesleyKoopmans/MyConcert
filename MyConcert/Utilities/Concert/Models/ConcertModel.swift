//
//  ConcertModel.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 08/12/2025.
//
import Foundation

struct ConcertModel: Hashable {
    let id: String
    let artist: String
    let description: String?
    let rating: Double?
    let concertGenre: ConcertGenre?
    let venue: String?
    let room: String?
    private(set) var concertHeaderImageUrl: String
    private(set) var concertMedia: [String]?
    let authorId: String?
    let concertDate: Date
    let dateCreated: Date?
    
    init(
        id: String,
        artist: String,
        description: String? = nil,
        rating: Double? = nil,
        concertGenre: ConcertGenre? = nil,
        venue: String? = nil,
        room: String? = nil,
        concertHeaderImageUrl: String,
        concertMedia: [String]? = nil,
        authorId: String? = nil,
        concertDate: Date,
        dateCreated: Date? = nil
    ) {
        self.id = id
        self.artist = artist
        self.description = description
        self.rating = rating
        self.concertGenre = concertGenre
        self.venue = venue
        self.room = room
        self.concertHeaderImageUrl = concertHeaderImageUrl
        self.concertMedia = concertMedia
        self.authorId = authorId
        self.concertDate = concertDate
        self.dateCreated = dateCreated
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        [
            ConcertModel(id: UUID().uuidString, artist: "Atmosphere", description: "Na ze in totaal 6x te hebben gezien vallen ze nog steeds niet tegen. Elke keer weten ze weer te verassen met nieuwe versies van de bekende nummers. Alle oude klasiekers kwamen zoals gebruikelijk langs.", rating: 2, concertGenre: .hiphop, venue: "Melkweg", room: "Kleine zaal", concertHeaderImageUrl: Constants.randomImage, concertMedia: [Constants.randomImage, "https://picsum.photos/600/500", "https://picsum.photos/500/600", "https://picsum.photos/500/500", "https://picsum.photos/600/650"], authorId: "mock_user_1", concertDate: .now, dateCreated: .now),
            ConcertModel(id: UUID().uuidString, artist: "Robert Jon & The Wreck", description: "Test", rating: 4, concertGenre: .rock, venue: "Burgerweeshuis", concertHeaderImageUrl: Constants.randomImage, authorId: "user_1", concertDate: .now, dateCreated: .now),
            ConcertModel(id: UUID().uuidString, artist: "The Roots", description: "Een van de weinige acts die nog op de verlanglijst stond. Twee uur lang speelden ze aaneengesloten, ze hadden amper geduld om applaus te incaseren. De band bestond uit 7 leden waarbij iedereen aan goed tot z'n recht kwam.", rating: 4.5, concertGenre: .hiphop, venue: "Paradiso", room: "Grote zaal", concertHeaderImageUrl: Constants.randomImage, concertMedia: [Constants.randomImage, "https://picsum.photos/600/500", "https://picsum.photos/500/600", "https://picsum.photos/500/500", "https://picsum.photos/600/650"], authorId: "user_1", concertDate: .now, dateCreated: .now),
            ConcertModel(id: UUID().uuidString, artist: "Dawn Brothers", rating: 10, concertGenre: .soul, venue: "Metropool", room: "Bud zaal", concertHeaderImageUrl: Constants.randomImage, concertMedia: [Constants.randomImage, "https://picsum.photos/600/500", "https://picsum.photos/500/600", "https://picsum.photos/500/500", "https://picsum.photos/600/650"], authorId: "user_2", concertDate: .now, dateCreated: .now)
        ]
    }
    
}

enum ConcertGenre: String {
    case soul, hiphop, blues, rock, jazz, country, pop, metal
}
