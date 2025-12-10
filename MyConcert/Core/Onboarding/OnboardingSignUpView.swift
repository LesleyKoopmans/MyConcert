//
//  OnboardingSignUpView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 10/12/2025.
//

import SwiftUI

struct OnboardingSignUpView: View {
    
    @Environment(AuthManager.self) private var authManager
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSigninUp: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                signUpWithEmailSection
                Divider()
                    .removeListRowFormatting()
                
                signUpWithSocialSection
            }
        }
    }
    
    private var signUpWithEmailSection: some View {
        Section {
            VStack(spacing: 8) {
                TextField("email", text: $email)
                    .customTextFieldAccentColor()
                TextField("password", text: $password)
                    .customTextFieldAccentColor()
                
                onSignUpEmailPressed()
//                AsyncCallToActionButton(isLoading: isSigninUp, title: "Sign Up", action: {
//                    onSignUpPressed()
//                })
                
                .disabled(isSigninUp)
                
            }
            .removeListRowFormatting()
        }
    }
    
    private var signUpWithSocialSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 8) {
                SignInWithAppleButtonView(type: .signUp, style: .black, cornerRadius: 16)
                    .frame(height: 55)
                    .anyButton(.press) {
                        onSignInApplePressed()
                    }
            }
            .removeListRowFormatting()
        }
    }
    
    private func onSignUpEmailPressed() -> some View {
        NavigationLink {
            OnboardingInfoView()
        } label: {
            Text("Sign Up")
                .callToActionButton()
        }
    }
    
    func onSignInApplePressed() {
        Task {
            do {
                let result = try await authManager.signInApple()
                
                NavigationLink {
                    OnboardingInfoView()
                } label: {
                    Text("Sign Up")
                        .callToActionButton()
                }
                
                print("Did sign in with Apple")
            } catch {
                print("Error sigining in with Apple")
            }
        }
    }
}

#Preview {
    OnboardingSignUpView()
}
