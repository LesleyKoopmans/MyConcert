//
//  GenreListView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 10/12/2025.
//

import SwiftUI

struct GenreListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var path: [NavigationPathOption]
    var genre: ConcertGenre = .blues
    var imageName: String = Constants.randomImage
    
    @State private var concerts: [ConcertModel] = ConcertModel.mocks
    @State private var showAlert: AnyAppAlert?
    @State private var isLoading: Bool = false
    @State private var showHeader: Bool = true
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    stretchyHeaderSection
                    
                    if isLoading {
                        ProgressView()
                            .padding(40)
                            .frame(maxWidth: .infinity)
                            .listRowSeparator(.hidden)
                            .removeListRowFormatting()
                    } else if concerts.isEmpty {
                        Text("No concerts found for this genre")
                            .padding(40)
                            .frame(maxWidth: .infinity)
                            .listRowSeparator(.hidden)
                            .foregroundStyle(.secondary)
                            .removeListRowFormatting()
                    } else {
                        ForEach(concerts) { concert in
                            CustomListCellView(imageName: concert.concertHeaderImageUrl, title: concert.artist)
                                .anyButton {
                                    onConcertPressed(concert: concert)
                                }
                        }
                        .removeListRowFormatting()
                    }
                }
            }
            headerSection
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var stretchyHeaderSection: some View {
        StretchyHeaderView(title: genre.rawValue.capitalized, imageUrl: genre.headerImage, trailingIcon: nil, trailingText: nil, height: 300)
            .readingFrame { frame in
                showHeader = frame.maxY < 130
            }
    }
    
    private var headerSection: some View {
        ZStack {
            Text(showHeader ? genre.rawValue.capitalized : "")
                .font(.headline)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(.regularMaterial)
                .offset(y: showHeader ? 0 : -20)
                .opacity(showHeader ? 1 : 0)
            
            Image(systemName: "chevron.left")
                .navigationBarButton(alignmentPadding: .leading, alignmentFrame: .leading, showBackground: showHeader)
                .anyButton {
                    onDismissButtonPressed()
                }
        }
        .foregroundStyle(showHeader ? .accent : .white)
        .animation(.smooth(duration: 0.2), value: showHeader)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    private func onConcertPressed(concert: ConcertModel) {
        path.append(.concert(concert: concert, concertId: concert.id))
    }
    
    private func onDismissButtonPressed() {
        dismiss()
    }
}

#Preview {
    GenreListView(path: .constant([]))
}
