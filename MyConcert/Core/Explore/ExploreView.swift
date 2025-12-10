//
//  ExploreView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 07/12/2025.
//
import SwiftUI

struct ExploreView: View {
    
    let concerts: [ConcertModel] = ConcertModel.mocks
    
    @State private var path: [NavigationPathOption] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            
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
                                    .anyButton(.plain) {
                                        onConcertPressed(concert: concert)
                                    }
                                    
                                }
                            }
                            // Header overlay bovenop content
                            StickyHeader(month: month)
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .navigationDestinationForCoreModule(path: $path)
        }
        
    }
    
    private func onConcertPressed(concert: ConcertModel) {
        path.append(.concert(concert: concert, concertId: concert.id))
    }
}

#Preview {
    ExploreView()
}
