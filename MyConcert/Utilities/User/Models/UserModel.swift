//
//  UserModel.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 08/12/2025.
//
import Foundation

struct UserModel {
    
    let id: String
    let email: String?
    let isAnonymous: Bool?
    let creationDate: Date?
    let creationVersion: String?
    let lastSignInDate: Date?
    let didCompleteOnboarding: Bool?
    private(set) var profileImageUrl: String?
    
    init(
        id: String,
        email: String? = nil,
        isAnonymous: Bool? = nil,
        creationDate: Date? = nil,
        creationVersion: String? = nil,
        lastSignInDate: Date? = nil,
        didCompleteOnboarding: Bool? = nil,
        profileImageUrl: String? = nil
    ) {
        self.id = id
        self.email = email
        self.isAnonymous = isAnonymous
        self.creationDate = creationDate
        self.creationVersion = creationVersion
        self.lastSignInDate = lastSignInDate
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileImageUrl = profileImageUrl
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        return [
            UserModel(id: "mock_user_1", creationDate: .now, didCompleteOnboarding: true, profileImageUrl: "https://picsum.photos/600/600"),
            UserModel(id: UUID().uuidString, creationDate: .now, didCompleteOnboarding: false, profileImageUrl: "https://picsum.photos/600/500"),
            UserModel(id: UUID().uuidString, creationDate: .now, didCompleteOnboarding: true, profileImageUrl: nil),
            UserModel(id: UUID().uuidString, creationDate: .now, didCompleteOnboarding: true, profileImageUrl: "https://picsum.photos/500/500")
        ]
    }
}
