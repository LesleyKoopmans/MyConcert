//
//  UserModel.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 08/12/2025.
//
import Foundation

struct UserModel: Codable {
    
    let id: String
    let email: String?
    let firstName: String?
    let lastName: String?
    let username: String?
    let isAnonymous: Bool?
    let creationDate: Date?
    let creationVersion: String?
    let lastSignInDate: Date?
    let didCompleteOnboarding: Bool?
    private(set) var profileImageUrl: String?
    
    init(
        id: String,
        email: String? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        username: String? = nil,
        isAnonymous: Bool? = nil,
        creationDate: Date? = nil,
        creationVersion: String? = nil,
        lastSignInDate: Date? = nil,
        didCompleteOnboarding: Bool? = nil,
        profileImageUrl: String? = nil
    ) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.isAnonymous = isAnonymous
        self.creationDate = creationDate
        self.creationVersion = creationVersion
        self.lastSignInDate = lastSignInDate
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileImageUrl = profileImageUrl
    }
    
    init(auth: UserAuthInfo, creationVersion: String?) {
        self.init(
            id: auth.uid,
            email: auth.email,
            isAnonymous: auth.isAnonymous,
            creationDate: auth.creationDate,
            creationVersion: creationVersion,
            lastSignInDate: auth.lastSignInDate,
        )
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case firstName = "first_name"
        case lastName = "last_name"
        case username = "username"
        case isAnonymous = "is_anonymous"
        case creationDate = "creation_date"
        case creationVersion = "creation_version"
        case lastSignInDate = "last_sign_in_date"
        case didCompleteOnboarding = "did_complete_onboarding"
        case profileImageUrl = "profile_image_url"
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        return [
            UserModel(id: "mock_user_1", firstName: "Lesley", lastName: "Koopmans", username: "wessellk", creationDate: .now, didCompleteOnboarding: true, profileImageUrl: "https://picsum.photos/600/600"),
            UserModel(id: UUID().uuidString, firstName: "Tim", lastName: "Kroese", username: "timmie", creationDate: .now, didCompleteOnboarding: false, profileImageUrl: "https://picsum.photos/600/500"),
            UserModel(id: UUID().uuidString, creationDate: .now, didCompleteOnboarding: true, profileImageUrl: nil),
            UserModel(id: UUID().uuidString, creationDate: .now, didCompleteOnboarding: true, profileImageUrl: "https://picsum.photos/500/500")
        ]
    }
}
