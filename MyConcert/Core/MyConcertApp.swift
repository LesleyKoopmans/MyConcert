//
//  MyConcertApp.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 07/12/2025.
//

import SwiftUI
import Firebase

@main
struct MyConcertApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(delegate.userManager)
                .environment(delegate.authManager)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var authManager: AuthManager!
    var userManager: UserManager!
    
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        self.authManager = AuthManager(service: FirebaseAuthService())
        self.userManager = UserManager(services: ProductionUserServices())
        return true
    }
}
