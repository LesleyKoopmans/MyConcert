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
                    ForEach(concerts.groupedByMonth(), id: \.key) { (month, concertsInMonth) in
                        ZStack(alignment: .topLeading) {
                            VStack(spacing: 0) {
                                ForEach(concertsInMonth) { concert in
                                    ExploreHeroCellView(
                                        title: concert.artist,
                                        subtitle: concert.concertDate.formatted(date: .abbreviated, time: .omitted),
                                        imageName: concert.concertHeaderImageUrl,
                                        trailingIcon: "star.fill",
                                        trailingIconColor: .yellow,
                                        trailingText: concert.rating
                                    )
                                    .frame(height: 260)
                                }
                            }
                            // Header overlay bovenop content
                            StickyHeader(month: month)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ExploreView()
}
