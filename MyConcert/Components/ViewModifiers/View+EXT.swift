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
    
    func stickyBottomButton() -> some View {
        self
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 70)
            .background(.accent)
    }
    
    func navigationBarButton(alignmentPadding: Edge.Set, alignmentFrame: Alignment, showBackground: Bool) -> some View {
        self
            .font(.title3)
            .padding(10)
            .background(showBackground ? Color.black.opacity(0.001) : .accent.opacity(0.7))
            .clipShape(Circle())
            .padding(alignmentPadding, 16)
            .frame(maxWidth: .infinity, alignment: alignmentFrame)
    }
    
    func tappableBackground() -> some View {
        background(Color.black.opacity(0.001))
    }
    
    func removeListRowFormatting() -> some View {
        self
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowBackground(Color.clear)
    }
    
    func addingGradientBackgroundForText() -> some View {
        background(
            LinearGradient(colors: [
                Color.black.opacity(0),
                Color.black.opacity(0.5),
                Color.black.opacity(0.7)
            ], startPoint: .top, endPoint: .bottom)
        )
    }
    
    func customTextFieldAccentColor() -> some View {
        self
            .padding(8)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(uiColor: .systemBackground))
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.accentColorLightGreen, lineWidth: 1)
                }
            )
            .foregroundStyle(.accent)
    }
}
