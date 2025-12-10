//
//  UserManager.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 10/12/2025.
//
import SwiftUI

protocol UserService: Sendable {
    func saveUser(user: UserModel) async throws
    func markOnboardingCompleted(userId: String, profileImageUrl: String?, firstName: String?, lastName: String?, username: String?) async throws
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
}

struct MockUserService: UserService {
    
    let currentUser: UserModel?
    init(user: UserModel? = nil) {
        self.currentUser = user
    }

    func saveUser(user: UserModel) async throws {
        
    }
    
    func markOnboardingCompleted(userId: String, profileImageUrl: String?, firstName: String?, lastName: String?, username: String?) async throws {
        
    }
    
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error> {
        AsyncThrowingStream { continuation in
            if let currentUser {
                continuation.yield(currentUser)
            }
        }
    }
    
    func deleteUser(userId: String) async throws {
        
    }
}

import FirebaseFirestore
import SwiftfulFirestore
struct FirebaseUserService: UserService {
    
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

@MainActor
@Observable
class UserManager {
    private let service: UserService
    private(set) var currentUser: UserModel?
    private var currentUserListener: ListenerRegistration?
    
    init(service: UserService, currentUser: UserModel?) {
        self.service = service
        self.currentUser = nil
    }
    
    func logIn(auth: UserAuthInfo, isNewUser: Bool) async throws {
        
        let creationVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creationVersion)
        
        try await service.saveUser(user: user)
        
        addCurrentUserListener(userId: auth.uid)
    }
    
    private func addCurrentUserListener(userId: String) {
        currentUserListener?.remove()
        
        Task {
            do {
                for try await value in service.streamUser(userId: userId) {
                    self.currentUser = value
                    print("Successfully listened to user: \(value.id)")
                }
            } catch {
                print("Error attaching userlistener: \(error)")
            }
        }
    }
    
    func markOnboardingCompletedForCurrentUser(profileImageUrl: String?, firstName: String?, lastName: String?, username: String?) async throws {
        let uid = try  currentUserId()
        try await service.markOnboardingCompleted(userId: uid, profileImageUrl: profileImageUrl, firstName: firstName, lastName: lastName, username: username)
    }
    
    func signOut() {
        currentUserListener?.remove()
        currentUserListener = nil
        currentUser = nil
    }
    
    func deleteCurrentUser() async throws {
        let uid = try  currentUserId()
        try await service.deleteUser(userId: uid)
        signOut()
    }
    
    private func currentUserId() throws -> String {
        guard let uid = currentUser?.id else { throw UserManagerError.noUserId }
        return uid
    }
    
    
    enum UserManagerError: LocalizedError {
        case noUserId
    }
}
