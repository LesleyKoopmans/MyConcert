//
//  MockAuthService.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 10/12/2025.
//
import Foundation

struct MockAuthService: AuthService {
    
    let currentUser: UserAuthInfo?
    
    init(user: UserAuthInfo? = nil) {
        self.currentUser = user
    }
    
    func getAuthtenticatedUser() throws -> UserAuthInfo? {
        currentUser
    }
    
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo.mock(isAnonymous: true)
        return (user, true)
    }
    
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo.mock(isAnonymous: false)
        return (user, false)
    }
    
    func signOut() async throws {
        
    }
    
    func deleteAccount() async throws {
        
    }
}
