//
//  MockUserPersistence.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 10/12/2025.
//

struct MockUserPersistence: LocalUserPersistence {
    
    let currentUser: UserModel?
    
    init(user: UserModel? = nil) {
        self.currentUser = user
    }
    
    func getCurrentUser() -> UserModel? {
        currentUser
    }
    
    func saveCurrentUser(user: UserModel?) throws {
        
    }
}
