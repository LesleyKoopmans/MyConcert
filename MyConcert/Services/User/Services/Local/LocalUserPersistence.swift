//
//  LocalUserPersistence.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 10/12/2025.
//
protocol LocalUserPersistence {
    func getCurrentUser() -> UserModel?
    func saveCurrentUser(user: UserModel?) throws
}
