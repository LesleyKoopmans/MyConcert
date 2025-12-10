//
//  AppView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 07/12/2025.
//

import SwiftUI

struct AppView: View {
    
    @Environment(\.authService) private var authService
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
            await chechUserStatus()
        }
        .onChange(of: appState.showTabBar) { _, newValue in
            if !newValue {
                Task {
                    await chechUserStatus()
                }
            }
        }
    }
    
    private func chechUserStatus() async {
        if let user = try? authService.getAuthtenticatedUser() {
            print("User already authenticated \(user.uid)")
        } else {
            do {
                let result = try await authService.signInAnonymously()
                
                // login to app
                print("Sign in anonymous success: \(result.user.uid)")
            } catch {
                print(error)
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
