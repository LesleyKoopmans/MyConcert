//
//  UserAuthInfo+Firebase.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 10/12/2025.
//
import FirebaseAuth

extension UserAuthInfo {
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.isAnonymous = user.isAnonymous
        self.creationDate = user.metadata.creationDate
        self.lastSignInDate = user.metadata.lastSignInDate
    }
}
