//
//  ProfileImageView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 10/12/2025.
//
import SwiftUI

struct ProfileImageView: View {
    
    var imageName: String?
    var onProfileImagePressed: (() -> Void)?
    
    var body: some View {
        ZStack {
            if let imageName = imageName {
                ImageLoaderView(urlString: imageName)
                    
            } else {
                ZStack {
                    Circle()
                        .fill(.accent.opacity(0.8))
                    Image(systemName: "person.fill")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
        }
        .anyButton {
            onProfileImagePressed?()
        }
    }
}

#Preview {
    ProfileImageView()
        .clipShape(Circle())
        .frame(width: 140)
}
