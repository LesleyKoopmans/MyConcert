//
//  AuthService.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 10/12/2025.
//
import SwiftUI
extension EnvironmentValues {
    @Entry var authService: AuthService = MockAuthService()
}

protocol AuthService: Sendable {
    func getAuthtenticatedUser() throws -> UserAuthInfo?
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func signOut() async throws
    func deleteAccount() async throws
}
