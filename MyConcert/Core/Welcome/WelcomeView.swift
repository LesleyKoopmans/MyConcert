//
//  WelcomeView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 07/12/2025.
//

import SwiftUI

struct WelcomeView: View {
    
    @Environment(AppState.self) private var root
    @Environment(AuthManager.self) private var authManager
    
    @State private var isSigninIn: Bool = false
    @State var imageName: String = Constants.randomImage
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                ImageLoaderView(urlString: imageName)
                    .ignoresSafeArea()
                
                titleSection
                    .padding(.top, 24)
                
                ctaButtons
                    .padding(16)
                
                policyLinks
            }
        }
    }
    
    private var titleSection: some View {
        VStack(spacing: 8) {
            Text("myConcerts")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.accentColorLightGreen)
            Text("Keep track of all of your concerts!")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
    
    private var ctaButtons: some View {
        VStack(spacing: 8) {
            TextField("email", text: $email)
                .customTextFieldAccentColor()
            TextField("password", text: $password)
                .customTextFieldAccentColor()
            
            AsyncCallToActionButton(isLoading: isSigninIn, title: "Sign In", action: {
                onSignInEmailPressed()
            })
            
            Text("or sign in with")
            HStack {
                ZStack {
                    Rectangle()
                    Image(systemName: "apple.logo")
                        .font(.title)
                        .foregroundStyle(.white)
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(width: 60, height: 60)
                .asButton(.press) {
                    onSignInApplePressed()
                }
                ZStack {
                            Circle()
                                .fill(Color.white)
                                .shadow(radius: 2)

                            Text("G")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [
                                            Color.red,
                                            Color.yellow,
                                            Color.green,
                                            Color.blue
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        }
                        .frame(width: 60, height: 60)

                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(width: 60, height: 60)
                ZStack {
                            Color(red: 59/255, green: 89/255, blue: 152/255) // Facebook-blauw
                            Text("F")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .disabled(isSigninIn)
            
            NavigationLink {
                OnboardingSignUpView()
            } label: {
                Text("Don't have an account yet? Sign Up!")
                    .underline()
                    .font(.body)
                    .foregroundStyle(.black)
                    .padding(8)
                    .tappableBackground()
            }
        }
    }
    
    private var policyLinks: some View {
        HStack(spacing: 8) {
            Link(destination: URL(string: Constants.termsOfServiceUrl)!) {
                Text("Terms of Service")
            }
            Circle()
                .fill(.accent)
                .frame(width: 4, height: 4)
            Link(destination: URL(string: Constants.privacyPolicyUrl)!) {
                Text("Privacy Policy")
            }
        }
    }
    
    func onSignInEmailPressed() {
        // other logic
        isSigninIn = true
        
        Task {
            try await Task.sleep(for: .seconds(3))
            isSigninIn = false
            root.updateViewState(showTabBarView: true)
        }
    }
    
    func onSignInApplePressed() {
        Task {
            do {
                let result = try await authManager.signInApple()
                root.updateViewState(showTabBarView: true)
                print("Did sign in with Apple")
            } catch {
                print("Error sigining in with Apple")
            }
        }
    }
}

#Preview {
    WelcomeView()
        .environment(AppState())
}
