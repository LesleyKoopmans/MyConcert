//
//  CarouselView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 08/12/2025.
//

import SwiftUI

struct CarouselView<Content: View, T: Hashable>: View {
    
    var items: [T]
    @ViewBuilder var content: (T) -> Content
    @State private var selection: T?
    
    var body: some View {
        VStack(spacing: 12) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(items, id: \.self) { item in
                        content(item)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .scrollTransition(.interactive.threshold(.visible(0.95)), transition: { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1 : 0.9)
                            })
                            .containerRelativeFrame(.horizontal, alignment: .center)
                            .id(item)
                    }
                }
            }
            .frame(height: 200)
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $selection)
            .onChange(of: items.count, { _, _ in
                updateSelectionIfNeeded()
            })
            .onAppear {
                updateSelectionIfNeeded()
            }
            
            HStack(spacing: 8) {
                ForEach(items, id: \.self) { item in
                    Circle()
                        .fill(item == selection ? .accent : .secondary.opacity(0.5))
                        .frame(width: 8, height: 8)
                }
            }
            .animation(.linear, value: selection)
        }
    }
    
    private func updateSelectionIfNeeded() {
        if selection == nil || selection == items.last {
            selection = items.first
        }
    }
}

#Preview {
    VStack {
        CarouselView(items: ConcertModel.mocks) { item in
            HeroCellView(
                title: item.artist,
                subtitle: item.venue,
                imageName: item.concertHeaderImageUrl,
                trailingIcon: "star.fill",
                trailingIconColor: .yellow,
                trailingText: item.rating
            )
        }
        
        CarouselView(items: ConcertModel.mocks) { item in
            HeroCellView(
                title: "",
                subtitle: "",
                imageName: item.concertHeaderImageUrl,
                trailingIcon: nil,
                trailingIconColor: .yellow,
                trailingText: nil
            )
        }
    }
    .padding()
}
