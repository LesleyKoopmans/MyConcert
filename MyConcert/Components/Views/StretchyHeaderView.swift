//
//  StretchyHeaderView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 08/12/2025.
//

import SwiftUI
import SwiftfulUI

struct StretchyHeaderView: View {
    var title: String = "This is some title"
    var imageUrl: String = Constants.randomImage
    var trailingIcon: String? = "star.fill"
    var trailingIconColor: Color = .yellow
    var trailingText: Double? = 4.750001
    var height: CGFloat = 300
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay(
                ImageLoaderView(urlString: imageUrl)
            )
            .overlay(
                alignment: .bottomLeading,
                content: {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(title)
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        Spacer()
                        HStack {
                            if let trailingIcon {
                                Image(systemName: trailingIcon)
                                    .foregroundStyle(trailingIconColor)
                                    .font(.headline)
                            }
                            if let trailingText {
                                Text("\(trailingText, specifier: "%.2f")")
                                    .font(.headline)
                            }
                        }
                    }
                    .foregroundStyle(.white)
                    .padding(8)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .addingGradientBackgroundForText()
                })
            .asStretchyHeader(startingHeight: height)
    }
}

#Preview {
    ZStack {
        ScrollView {
            StretchyHeaderView()
        }
        .ignoresSafeArea()
    }
}
