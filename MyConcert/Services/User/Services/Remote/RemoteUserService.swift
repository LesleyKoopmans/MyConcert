//
//  RemoteUserService.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 10/12/2025.
//


protocol RemoteUserService: Sendable {
    func saveUser(user: UserModel) async throws
    func markOnboardingCompleted(userId: String, profileImageUrl: String?, firstName: String?, lastName: String?, username: String?) async throws
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
}