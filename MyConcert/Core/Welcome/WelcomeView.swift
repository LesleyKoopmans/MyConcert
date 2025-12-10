//
//  WelcomeView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 07/12/2025.
//

import SwiftUI

struct WelcomeView: View {
    
    @Environment(AppState.self) private var root
    
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
                onSignInPressed()
            })
            
            .disabled(isSigninIn)
            
            Text("Don't have an account yet? Sign Up!")
                .underline()
                .font(.body)
                .padding(8)
                .tappableBackground()
                .onTapGesture {
                    
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
    
    func onSignInPressed() {
        // other logic
        isSigninIn = true
        
        Task {
            try await Task.sleep(for: .seconds(3))
            isSigninIn = false
            root.updateViewState(showTabBarView: true)
        }
    }
}

#Preview {
    WelcomeView()
        .environment(AppState())
}
