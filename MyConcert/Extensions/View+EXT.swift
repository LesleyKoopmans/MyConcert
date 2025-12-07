//
//  View+EXT.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 07/12/2025.
//

import SwiftUI

extension View {
    func callToActionButton() -> some View {
        self
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.accent)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    func tappableBackground() -> some View {
        background(Color.black.opacity(0.001))
    }
}
