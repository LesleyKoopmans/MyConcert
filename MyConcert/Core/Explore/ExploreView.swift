//
//  ExploreView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 07/12/2025.
//

import SwiftUI

struct ExploreView: View {
    
    let concerts: [ConcertModel] = ConcertModel.mocks
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ExploreHeroCellView(imageName: "https://picsum.photos/600/500")
                        .frame(height: 240)
                    ExploreHeroCellView(imageName: "https://picsum.photos/400/600")
                        .frame(height: 240)
                    ExploreHeroCellView(imageName: "https://picsum.photos/600/650")
                        .frame(height: 240)
                    ExploreHeroCellView(imageName: "https://picsum.photos/500/600")
                        .frame(height: 240)
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ExploreView()
}
