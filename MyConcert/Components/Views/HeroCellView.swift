//
//  HeroCellView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 07/12/2025.
//

import SwiftUI

struct HeroCellView: View {
    
    var title: String? = "This is some title"
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
        }
        .overlay(alignment: .bottomLeading) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    if let title {
                        Text(title)
                            .font(.headline)
                    }
                    if let subtitle {
                        Text(subtitle)
                            .font(.subheadline)
                    }
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
            .addingGradientBackgroundForText()
        }
    }
}

#Preview {
    VStack {
        HeroCellView()
        HeroCellView(imageName: nil)
        HeroCellView(subtitle: nil)
        HeroCellView(trailingIcon: "star.fill", trailingText: 3.2)
        HeroCellView()
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
