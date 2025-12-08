//
//  StickyHeader.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 08/12/2025.
//

import SwiftUI

struct StickyHeader: View {
    let month: String

    var body: some View {
        GeometryReader { geo in
            Text(month.capitalized)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.ultraThinMaterial)
                // De magic: houd bovenaan sticky
                .offset(y: max(0, -geo.frame(in: .named("scroll")).minY))
        }
        .frame(height: 60)
    }
}

#Preview {
    StickyHeader(month: "December")
}
