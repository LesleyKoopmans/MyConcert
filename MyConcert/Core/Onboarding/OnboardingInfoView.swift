//
//  OnboardingInfoView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 10/12/2025.
//

import SwiftUI
import PhotosUI

struct OnboardingInfoView: View {
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var username: String = ""
    @State private var imagePickerPresented: Bool = false
    
    @State private var isSigninUp: Bool = false
    
    @StateObject var viewModel = OnboardingInfoViewModel()
    
    var body: some View {
        List {
            profileImageSection
            profileInfoSection
            buttonSection
                .padding(.top, 24)
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
        
    }
    
    private var profileImageSection: some View {
        Section {
            ZStack {
                if let loadedImage = viewModel.image {
                    loadedImage
                        .resizable()
                        .scaledToFill()
                } else {
                    ProfileImageView() {
                        onProfileImageButtonPressed()
                    }
                }
            }
            .clipShape(Circle())
            .frame(width: 250, height: 250)
            .frame(maxWidth: .infinity)
            .removeListRowFormatting()
        }
    }
    
    private var profileInfoSection: some View {
        VStack(spacing: 8) {
            TextField("First name", text: $firstName)
                .customTextFieldAccentColor()
            
            TextField("Last name", text: $lastName)
                .customTextFieldAccentColor()
            
            TextField("Username", text: $username)
                .customTextFieldAccentColor()
        }
        .removeListRowFormatting()
    }
    
    private var buttonSection: some View {
        VStack {
            AsyncCallToActionButton(isLoading: isSigninUp, title: "Finish", action: {
                onSignUpPressed()
            })
            .disabled(isSigninUp)
        }
        .removeListRowFormatting()
    }
    
    func onSignUpPressed() {
        
    }
    
    func onProfileImageButtonPressed() {
        imagePickerPresented = true
    }
    
}

#Preview {
    OnboardingInfoView()
}
