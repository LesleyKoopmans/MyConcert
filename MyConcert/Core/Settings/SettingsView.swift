//
//  SettingsView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 07/12/2025.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.authService) private var authService
    @Environment(AppState.self) private var appState
    
    @State private var showAlert: AnyAppAlert?
    
    var body: some View {
        NavigationStack {
            List {
                
                accountSection
                
                applicationSection
            }
            .navigationTitle("Settings")
        }
        .showCustomAlert(alert: $showAlert)

    }
    
    private var accountSection: some View {
        Section {
            Text("Sign out")
                .rowFormatting()
                .anyButton(.highlight) {
                    onSignoutPressed()
                }
                .removeListRowFormatting()
            Text("Delete account")
                .foregroundStyle(.red)
                .rowFormatting()
                .anyButton(.highlight) {
                    onDeleteAccountPressed()
                }
                .removeListRowFormatting()
        } header: {
            Text("Account")
        }
    }
    
    private var applicationSection: some View {
        Section {
            HStack(spacing: 8) {
                Text("Version")
                Spacer(minLength: 0)
                Text(Utilities.appVersion ?? "")
            }
            
            HStack(spacing: 8) {
                Text("Build Number")
                Spacer(minLength: 0)
                Text(Utilities.buildNumber ?? "")
            }
            
            Text("Contact Us")
                .foregroundStyle(.accent)
                .rowFormatting()
                .anyButton(.highlight) {
                    
                }
                .removeListRowFormatting()
        } header: {
            Text("Application")
        } footer: {
            Text("Created by Lesley Koopmans.")
        }
    }
    
    func onSignoutPressed() {
        Task {
            do {
                try await authService.signOut()
                await dismissScreen()
            } catch {
                showAlert = AnyAppAlert(error: error)
            }
            
        }
    }
    
    func onDeleteAccountPressed() {
        showAlert = AnyAppAlert(title: "Delete Account?", subtitle: "Are you sure you want to delete your account?", buttons: {
            AnyView(
                Button("Delete", role: .destructive) {
                    onDeleteAccountConfirmedPressed()
                }
            )
        })
    }
    
    func onDeleteAccountConfirmedPressed() {
        Task {
            do {
                try await authService.deleteAccount()
                await dismissScreen()
            } catch {
                showAlert = AnyAppAlert(error: error)
            }
        }
    }
    
    private func dismissScreen() async {
        dismiss()
        try? await Task.sleep(for: .seconds(1))
        appState.updateViewState(showTabBarView: false)
    }
}

fileprivate extension View {
    func rowFormatting() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color(uiColor: .systemBackground))
    }
}

#Preview("No auth") {
    SettingsView()
        .environment(\.authService, MockAuthService(user: nil))
        .environment(AppState())
}

#Preview("Anonymous") {
    SettingsView()
        .environment(\.authService, MockAuthService(user: UserAuthInfo.mock(isAnonymous: true)))
        .environment(AppState())
}

#Preview("Not Anonymous") {
    SettingsView()
        .environment(\.authService, MockAuthService(user: UserAuthInfo.mock(isAnonymous: false)))
        .environment(AppState())
}
