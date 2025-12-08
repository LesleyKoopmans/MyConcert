//
//  ProfileView.swift
//  MyConcert
//
//  Created by Lesley Koopmans on 07/12/2025.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var showSettingsView: Bool = false
    @State private var currentUser: UserModel? = .mock
    @State private var showCreateConcertView: Bool = false
    @State private var myConcerts: [ConcertModel] = []
    @State private var isLoading: Bool = true
    
    var body: some View {
        NavigationStack {
            List {
                profileImageSection
                myConcertsSection

            }
                .navigationTitle("Profile")
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
        .task {
            await loadData()
        }
    }
    
    private func loadData() async {
        try? await Task.sleep(for: .seconds(5))
        isLoading = false
        myConcerts = ConcertModel.mocks
    }
    
    private var profileImageSection: some View {
        Section {
            ZStack {
                Circle()
                    .fill(.accent)
            }
            .frame(width: 150, height: 150)
            .frame(maxWidth: .infinity)
            .removeListRowFormatting()
        }
    }
    
    private var myConcertsSection: some View {
        Section {
            if myConcerts.isEmpty {
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
                ForEach(myConcerts, id: \.self) { concert in
                    CustomListCellView(imageName: concert.concertHeaderImageUrl, title: concert.artist)
                        .anyButton {
                            
                        }
                        .removeListRowFormatting()
                }
                .onDelete { indexSet in
                    onDeleteConcert(indexSet: indexSet)
                }
            }
            
            
        } header: {
            HStack(spacing: 0) {
                Text("My Concerts")
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
        
        myConcerts.remove(at: index)
    }
}

#Preview {
    ProfileView()
        .environment(AppState())
}
