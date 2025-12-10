//
//  ProfileView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 07/12/2025.
//
import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    @Environment(UserManager.self) private var userManager
    
    @State private var showSettingsView: Bool = false
    @State private var currentUser: UserModel? = .mock
    @State private var showCreateConcertView: Bool = false
    @State private var myTopConcerts: [ConcertModel] = []
    @State private var myRecentConcerts: [ConcertModel] = []
    @State private var myGenres: [ConcertGenre] = []
    @State private var isLoading: Bool = true
    @State private var imagePickerPresented = false
    
    @State private var path: [NavigationPathOption] = []
    
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                userInfoSection
                myTopConcertsSection
                myRecentConcertsSection
                myGenreSection

            }
            .navigationTitle("Profile")
            .navigationDestinationForCoreModule(path: $path)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    settingsButton
                }
            }
        }
        .sheet(isPresented: $showSettingsView) {
            SettingsView()
        }
        .fullScreenCover(isPresented: $showCreateConcertView, onDismiss: {
            Task {
//                await loadData()
            }
        }, content: {
            CreateConcertView()
        })
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
        .task {
            await loadData()
        }
    }
    
    private func loadData() async {
        self.currentUser = userManager.currentUser
//        try? await Task.sleep(for: .seconds(3))
        isLoading = false
        myTopConcerts = ConcertModel.mocks
        myRecentConcerts = ConcertModel.mocks
        myGenres = ConcertGenre.allCases
    }
    
    private var userInfoSection: some View {
        Section {
            VStack {
                ZStack {
                    if let loadedImage = viewModel.image {
                        loadedImage
                            .resizable()
                            .scaledToFill()
                    } else {
                        ProfileImageView(imageName: currentUser?.profileImageUrl) {
                            onImagePickerButtonPressed()
                        }
                    }
                }
                .clipShape(Circle())
                .frame(width: 150, height: 150)
                .frame(maxWidth: .infinity)
                .anyButton {
                    onImagePickerButtonPressed()
                }
                
                VStack(alignment: .center, spacing: 4) {
                    if let firstName = currentUser?.firstName {
                        Text("\(firstName)")
                            .foregroundStyle(.accent)
                    }
                    if let username = currentUser?.username {
                        Text("@\(username)")
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(maxWidth: .infinity)
                .removeListRowFormatting()
            }
            
            .removeListRowFormatting()
        }
    }
    
    private var myTopConcertsSection: some View {
        Section {
            if myTopConcerts.isEmpty {
                Group {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Click + to upload a Concert")
                    }
                }
                .padding(50)
                .frame(maxWidth: .infinity)
                .font(.body)
                .foregroundStyle(.secondary)
                .removeListRowFormatting()
            } else {
                ForEach(myTopConcerts, id: \.self) { concert in
                    CustomListCellView(imageName: concert.concertHeaderImageUrl, title: concert.artist)
                        .anyButton {
                            onConcertPressed(concert: concert)
                        }
                        .removeListRowFormatting()
                }
                .onDelete { indexSet in
                    onDeleteConcert(indexSet: indexSet)
                }
            }
        } header: {
            HStack(spacing: 0) {
                Text("My Top Concerts")
                Spacer()
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundStyle(.accent)
                    .anyButton {
                        onCreateConcertButtonPressed()
                    }
            }
        }
    }
    
    private var myRecentConcertsSection: some View {
        Section {
            if myRecentConcerts.isEmpty {
                Group {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Click + to upload a Concert")
                    }
                }
                .padding(50)
                .frame(maxWidth: .infinity)
                .font(.body)
                .foregroundStyle(.secondary)
                .removeListRowFormatting()
            } else {
                ForEach(myRecentConcerts, id: \.self) { concert in
                    CustomListCellView(imageName: concert.concertHeaderImageUrl, title: concert.artist)
                        .anyButton {
                            onConcertPressed(concert: concert)
                        }
                        .removeListRowFormatting()
                }
                .onDelete { indexSet in
                    onDeleteConcert(indexSet: indexSet)
                }
            }
        } header: {
            HStack(spacing: 0) {
                Text("My Recent Concerts")
                Spacer()
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundStyle(.accent)
                    .anyButton {
                        onCreateConcertButtonPressed()
                    }
            }
        }
    }
    
    private var myGenreSection: some View {
        Section {
            ZStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        ForEach(myGenres, id: \.self) { genre in
                            GenreCellView(
                                title: genre.rawValue.capitalized,
                                imageName: genre.headerImage
                            )
                            .anyButton(.plain) {
                                onGenrePressed(genre: genre, imageName: genre.headerImage)
                            }
                        }
                    }
                }
                .frame(height: 140)
                .scrollIndicators(.hidden)
                .scrollTargetLayout()
                .scrollTargetBehavior(.viewAligned)
            }
            .removeListRowFormatting()
        } header: {
            Text("Genres")
        }
    }
    
    private var settingsButton: some View {
        Image(systemName: "gear")
            .font(.headline)
            .foregroundStyle(.accent)
            .anyButton {
                onSettingsButtonPressed()
            }
    }
    
    private func onSettingsButtonPressed() {
        showSettingsView = true
    }
    
    private func onCreateConcertButtonPressed() {
        showCreateConcertView = true
    }
    
    private func onDeleteConcert(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        
        myTopConcerts.remove(at: index)
    }
    
    private func onImagePickerButtonPressed() {
        imagePickerPresented = true
    }
    
    private func onConcertPressed(concert: ConcertModel) {
        path.append(.concert(concert: concert, concertId: concert.id))
    }
    
    private func onGenrePressed(genre: ConcertGenre, imageName: String) {
        path.append(.genre(genre: genre, imageName: imageName))
    }
}

#Preview {
    ProfileView()
        .environment(AppState())
        .environment(UserManager(services: MockUserServices(user: .mock)))
}
