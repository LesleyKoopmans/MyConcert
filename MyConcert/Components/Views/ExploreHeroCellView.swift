//
//  ExploreHeroCellView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 07/12/2025.
//

import SwiftUI

struct ExploreHeroCellView: View {
    
    var title: String? = "Atmosphere"
    var subtitle: String? = "24-04-2021"
    var imageName: String? = Constants.randomImage
    var trailingIcon: String? = "star.fill"
    var trailingIconColor: Color? = .yellow
    var trailingText: Double? = 4.5001
    
    var body: some View {
        ZStack {
            
            if let imageName {
                ImageLoaderView(urlString: imageName)
            } else {
                Rectangle()
                    .fill(.accent)
            }
            Color.black.opacity(0.45)
            
            if let title {
                Text(title)
                    .font(.custom("AvenirNext-BoldItalic", size: 40))
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .textCase(.uppercase)
            }
        }
        .overlay(alignment: .bottomLeading) {
            HStack {
                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                }
                
                Spacer()
                
                HStack(spacing: 4) {
                    if let trailingIcon {
                        Image(systemName: trailingIcon)
                            .foregroundStyle(trailingIconColor ?? .yellow)
                            .font(.headline)
                    }
                    if let trailingText {
                        Text("\(trailingText, specifier: "%.2f")")
                            .font(.headline)
                    }
                }
            }
            .foregroundStyle(.white)
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    ExploreHeroCellView()
        .frame(height: 240)
}
