//
//  MockUserService.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 10/12/2025.
//
struct MockUserService: RemoteUserService {
    
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
