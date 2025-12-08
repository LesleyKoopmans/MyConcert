//
//  StickyHeader.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 08/12/2025.
//

import SwiftUI

struct StickyHeader: View {
    let month: String
    var isTopHeader: Bool = true

    var body: some View {
        GeometryReader { geo in
                        
            Text(month.capitalized)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 18)
                .padding(.top, geo.frame(in: .named("scroll")).minY > 0 ? 0 : 40)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.ultraThinMaterial)
                .offset(y: max(0, -geo.frame(in: .named("scroll")).minY))
                .animation(.smooth(duration: 0.2), value: geo.frame(in: .named("scroll")).minY < 0)
        }
    }

}

#Preview {
    StickyHeader(month: "December")
}
