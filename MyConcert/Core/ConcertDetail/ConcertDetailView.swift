//
//  ConcertDetailView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 08/12/2025.
//

import SwiftUI

struct ConcertDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var concert: ConcertModel = .mock
    
    @State private var currentUser: UserModel = UserModel.mock
    @State private var showHeader: Bool = true
    @State private var showImagePicker: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                LazyVStack(alignment: .leading, spacing: 12) {
                    imageSection
                    infoSection
                    descriptionSection
                    mediaSection
                }
            }
            headerSection
        }
    }
    
    private var imageSection: some View {
        StretchyHeaderView(
            title: concert.artist,
            imageUrl: concert.concertHeaderImageUrl,
            trailingIcon: "star.fill",
            trailingIconColor: .yellow,
            trailingText: concert.rating,
            height: 250
        )
        .readingFrame { frame in
            showHeader = frame.maxY < 130
        }
    }
    
    private var infoSection: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundStyle(.accent)
                    Text(concert.concertDate.formatted(date: .abbreviated, time: .omitted))
                }
                Spacer()
                HStack {
                    if let genre = concert.concertGenre {
                        Image(systemName: "music.note")
                            .foregroundStyle(.accent)
                        Text(genre.rawValue.capitalized)
                    }
                }
            }
            HStack(spacing: 0) {
                if let venue = concert.venue {
                    Image(systemName: "mappin.circle")
                        .foregroundStyle(.accent)
                        .padding(.trailing, 8)
                    Text(venue)
                    
                    if let room = concert.room {
                        Text(room == "" ? "" : ", \(room)")
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
    
    private var descriptionSection: some View {
        Section {
            if let description = concert.description {
                VStack(alignment: .leading) {
                    Text(description)
                }
            }
        } header: {
            SectionHeaderView(icon: "text.justify.leading", title: "Description:")
        }
        .padding(.horizontal)

    }
    
    private var mediaSection: some View {
        Section {
            ZStack {
                if let mediaItems = concert.concertMedia {
                    CarouselView(items: mediaItems) { media in
                        HeroCellView(title: nil, subtitle: nil, imageName: media, trailingIcon: nil, trailingText: nil)
                    }
                    .overlay(alignment: .topLeading) {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                            .navigationBarButton(alignmentPadding: .leading, alignmentFrame: .leading, showBackground: false)
                            .padding(.top, 8)
                            .padding(.leading, -8)
                            .anyButton {
                                
                            }
                    }
                } else {
                    VStack {
                        Text("+")
                        Text("Add media")
                    }
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(.accent.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .asButton(.press) {
                        onAddMediaPressed()
                    }
                }
            }
        } header: {
            SectionHeaderView(icon: "photo", title: "Media:")
        }
        .padding(.horizontal)
    }
    
    private var headerSection: some View {
        ZStack {
            Text(showHeader ? concert.artist : "")
                .font(.headline)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .offset(y: showHeader ? 0 : -20)
                .opacity(showHeader ? 1 : 0)
            
            Image(systemName: "chevron.left")
                .navigationBarButton(alignmentPadding: .leading, alignmentFrame: .leading, showBackground: showHeader)
                .anyButton {
                    onDismissButtonPressed()
                }
            
            if concert.authorId == currentUser.id {
                Image(systemName: "pencil")
                    .navigationBarButton(alignmentPadding: .trailing, alignmentFrame: .trailing, showBackground: showHeader)
                    .anyButton {
                        onEditButtonPressed()
                    }
            }
        }
        .foregroundStyle(showHeader ? .accent : .white)
        .animation(.smooth(duration: 0.2), value: showHeader)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    private func onDismissButtonPressed() {
        dismiss()
    }
    
    private func onEditButtonPressed() {
        
    }
    
    private func onAddMediaPressed() {
        showImagePicker = true
    }
}

#Preview {
    ConcertDetailView()
}
