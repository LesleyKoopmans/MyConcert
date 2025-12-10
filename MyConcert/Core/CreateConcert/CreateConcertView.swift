//
//  CreateConcertView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 07/12/2025.
//

import SwiftUI

struct CreateConcertView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var isUploadingPost: Bool = false
    @State private var artist: String = ""
    @State private var venue: String = ""
    @State private var room: String = ""
    @State private var description: String = ""
    @State private var concertDate: Date = .now
    @State private var selectedGenre: ConcertGenre = .blues
    @State private var rating: Double = 0
    @State private var imagePickerPresented = false
    
    @StateObject var viewModel = CreateConcertViewModel()
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    imageSection
                    inputSection
                }
            }
            headerSection
            buttonSection
        }
        .ignoresSafeArea()
        .onAppear {
            imagePickerPresented.toggle()
        }
        .toolbar(.hidden, for: .navigationBar)
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
    }
    
    private var imageSection: some View {
        ZStack {
            if let loadedImage = viewModel.image {
                loadedImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .clipped()
                    .ignoresSafeArea()
            } else {
                ProgressView()
                    .tint(.accent)
            }
        }
        .frame(height: 300)
        .frame(maxWidth: .infinity)
        .background(.accent.opacity(0.2))
        .anyButton {
            imagePickerPresented = true
        }
    }
    
    private var inputSection: some View {
        VStack(spacing: 8) {
            TextField("Artist*", text: $artist)
                .customTextFieldAccentColor()
            
            HStack {
                TextField("Venue*", text: $venue)
                    .customTextFieldAccentColor()
                TextField("Room", text: $room)
                    .customTextFieldAccentColor()
            }
            
            TextField("Description*", text: $description, axis: .vertical)
                .customTextFieldAccentColor()
            
            HStack {
                Text("Date")
                    .foregroundStyle(.accent)
                DatePicker("", selection: $concertDate, displayedComponents: .date)
            }
            
            HStack {
                Text("Genre")
                    .foregroundStyle(.accent)
                Spacer()
                Picker("Genre", selection: $selectedGenre) {
                    ForEach(ConcertGenre.allCases, id: \.self) { genre in
                        Text(genre.rawValue.capitalized)
                            .tag(genre)
                    }
                }
            }
            
            HStack {
                Text("Rating")
                    .foregroundStyle(.accent)
                Slider(value: $rating, in: 0...5, step: 0.1)
                
                HStack(spacing: 0) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text("\(rating, specifier: "%.1f")")
                        .frame(width: 30)
                }
            }
        }
        .padding(.horizontal)
    }
    
    private var headerSection: some View {
        ZStack {
            Image(systemName: "xmark")
                .navigationBarButton(alignmentPadding: .leading, alignmentFrame: .leading, showBackground: false)
                .foregroundStyle(.white)
                .anyButton {
                    onCancelButtonPressed()
                }
        }
        .frame(height: 150)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    private var buttonSection: some View {
        AsyncCallToActionButton(
            isLoading: isUploadingPost,
            title: "Upload",
            action: {
                onUploadPostPressed()
            }
        )
        .stickyBottomButton()
        .frame(maxHeight: .infinity, alignment: .bottom)
        .disabled(viewModel.image == nil || artist.isEmpty || venue.isEmpty || description.isEmpty)
    }
    
    private func onCancelButtonPressed() {
        dismiss()
    }
    
    private func onUploadPostPressed() {
        guard let headerImage = viewModel.uiImage else { return }
        
        Task {
            isUploadingPost = true
            try await Task.sleep(for: .seconds(3))
            isUploadingPost = false
            dismiss()
        }
    }
}

#Preview {
    CreateConcertView()
}
