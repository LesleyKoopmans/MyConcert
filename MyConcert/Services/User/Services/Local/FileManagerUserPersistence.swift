//
//  FileManagerUserPersistence.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 10/12/2025.
//
import SwiftUI
struct FileManagerUserPersistence: LocalUserPersistence {
    private let userDocumentKey = "current_user"
    
    func getCurrentUser() -> UserModel? {
        try? FileManager.getDocument(key: userDocumentKey)
    }
    
    func saveCurrentUser(user: UserModel?) throws {
        try FileManager.saveDocument(key: userDocumentKey, value: user)
    }
}
