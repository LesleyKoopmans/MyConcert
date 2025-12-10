//
//  AppView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 07/12/2025.
//

import SwiftUI

struct AppView: View {
    
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    @State var appState: AppState = AppState()
    
    var body: some View {
        AppViewBuilder(
            showTabBar: appState.showTabBar,
            tabbarView: {
                TabBarView()
            },
            onboardingView: {
                WelcomeView()
            }
        )
        .environment(appState)
        .task {
            await checkUserStatus()
        }
        .onChange(of: appState.showTabBar) { _, newValue in
            if !newValue {
                Task {
                    await checkUserStatus()
                }
            }
        }
    }
    
    private func checkUserStatus() async {
        if let user = authManager.auth {
            print("User already authenticated \(user.uid)")
            
            do {
                try await userManager.logIn(auth: user, isNewUser: false)
            } catch {
                print("Failed to log in to auth for existing user: \(error)")
                try? await Task.sleep(for: .seconds(5))
                await checkUserStatus()
            }
            
        } else {
            do {
                let result = try await authManager.signInAnonymously()
                
                // login to app
                print("Sign in anonymous success: \(result.user.uid)")
                try await userManager.logIn(auth: result.user, isNewUser: result.isNewUser)
            } catch {
                print("Failed to sign in anonymously and log in: \(error)")
                try? await Task.sleep(for: .seconds(5))
                await checkUserStatus()
            }
        }
    }
}

#Preview("Appview - Tabbar") {
    AppView(appState: AppState(showTabBar: true))
}

#Preview("Appview - Onboarding") {
    AppView(appState: AppState(showTabBar: false))
}
