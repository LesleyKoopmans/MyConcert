//
//  FirebaseUserService.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 10/12/2025.
//
import FirebaseFirestore
import SwiftfulFirestore

struct FirebaseUserService: RemoteUserService {
    
    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }
    
    func saveUser(user: UserModel) async throws {
        try collection.document(user.id).setData(from: user, merge: true)
    }
    
    func markOnboardingCompleted(userId: String, profileImageUrl: String?, firstName: String?, lastName: String?, username: String?) async throws {
        try await collection.document(userId).updateData([
            UserModel.CodingKeys.didCompleteOnboarding.rawValue: true,
            UserModel.CodingKeys.profileImageUrl.rawValue : profileImageUrl as Any,
            UserModel.CodingKeys.firstName.rawValue : firstName as Any,
            UserModel.CodingKeys.lastName.rawValue : lastName as Any,
            UserModel.CodingKeys.username.rawValue : username as Any
        ])
    }
    
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error> {
        collection.streamDocument(id: userId)
    }
    
    func deleteUser(userId: String) async throws {
        try await collection.document(userId).delete()
    }
}
