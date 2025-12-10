//
//  OnboardingSignUpView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 10/12/2025.
//

import SwiftUI

struct OnboardingSignUpView: View {
    
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
                
                AsyncCallToActionButton(isLoading: isSigninUp, title: "Sign Up", action: {
                    onSignUpPressed()
                })
                
                .disabled(isSigninUp)
                
            }
            .removeListRowFormatting()
        }
    }
    
    private var signUpWithSocialSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 8) {
                Button("Facebook") {
                    
                }
                Button("Google") {
                    
                }
                Button("Apple") {
                    
                }
            }
            .removeListRowFormatting()
        }
    }
    
    func onSignUpPressed() {
        
    }
}

#Preview {
    OnboardingSignUpView()
}
