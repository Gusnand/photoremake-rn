import SwiftUI

struct CollectionViewRemake: View {
  let columns = [
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible(), spacing: 16)
  ]
  
  // 1. NEW: Accept the master list of photos from ContentView
  @Binding var imageArray: [ImageDetail]
  
  @State private var allAlbums = AllAlbums.mockDataAllAlbums
  @State private var importantAlbums: [AllAlbums] = []
  @State private var isShowingAlbumPicker = false
  
  // 2. NEW: The Smart Album that automatically updates when you heart a photo!
  var favoritesAlbum: AllAlbums {
    let favoritedPhotos = imageArray.filter { $0.isFavorite }
    return AllAlbums(order: 0, title: "Favorites", photos: favoritedPhotos)
  }
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .leading, spacing: 14) {
        HStack {
          Text("Important Albums").font(.title3).fontWeight(.light)
          Spacer()
          NavigationLink("See All") {
            AllAlbumView(photos: $imageArray)
          }
        }.scenePadding(.bottom)
        
        ScrollView {
          LazyVGrid(columns: columns, spacing: 18) {
            
            // 3. NEW: Pin the Smart Favorites Album to the top of the grid!
            NavigationLink {
              FavoritesAlbumDetailView(photos: $imageArray)
            } label: {
              albumThumbnail(for: favoritesAlbum)
            }
            .buttonStyle(.plain)
            
            // 4. Your existing loop for the rest of the important albums
            ForEach(importantAlbums) { album in
              NavigationLink {
                AlbumDetailView(
                  albumTitle: album.title,
                  displayedPhotoIDs: album.photos.map(\.id),
                  photos: $imageArray
                )
              } label: {
                albumThumbnail(for: album) // Using the helper below to keep code clean!
              }
              .buttonStyle(.plain)
            }
          }
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Albums")
        .toolbarTitleDisplayMode(.inlineLarge)
        .toolbar {
          ToolbarItem(placement: .topBarTrailing) {
            Button("Choose Important Albums", systemImage: "photo.badge.checkmark") {
              isShowingAlbumPicker = true
            }
          }
        }
        .onAppear {
          if importantAlbums.isEmpty {
            // Grab the first 5 (Make sure you delete the static "Favorites" from your mock data!)
            importantAlbums = Array(allAlbums.prefix(5))
          }
        }
        .sheet(isPresented: $isShowingAlbumPicker) {
          ChooseAlbumsSheet(
            allAlbums: allAlbums,
            importantAlbums: $importantAlbums
          )
        }
      }.padding()
    }.preferredColorScheme(.dark)
  }
  
  // --- HELPER VIEW ---
  // Extracted your UI into a helper so you don't have to write the image/rectangle code twice!
  @ViewBuilder
  private func albumThumbnail(for album: AllAlbums) -> some View {
    VStack(alignment: .leading, spacing: 4) {
      Group {
        if let cover = album.coverPhoto {
          Image(cover.filename)
            .resizable()
            .scaledToFill()
            .aspectRatio(1, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        } else {
          RoundedRectangle(cornerRadius: 16)
            .fill(Color(UIColor.systemGray5))
            .aspectRatio(1, contentMode: .fit)
            .overlay {
              Image(systemName: "photo.on.rectangle.angled")
                .foregroundColor(.gray)
                .font(.largeTitle)
            }
        }
      }
      
      Text(album.title)
        .font(.subheadline)
        .foregroundColor(.white)
        .lineLimit(1)
      Text("\(album.count)")
        .font(.caption)
        .foregroundColor(.gray)
    }
  }
}

// 5. NEW: Update the preview to pass the required binding
#Preview {
  CollectionViewRemake(imageArray: .constant(ImageDetail.gallery))
}

private struct FavoritesAlbumDetailView: View {
  @Binding var photos: [ImageDetail]

  private let columns = [
    GridItem(.flexible(), spacing: 1),
    GridItem(.flexible(), spacing: 1),
    GridItem(.flexible(), spacing: 1)
  ]

  private var favoritePhotos: [ImageDetail] {
    photos.filter(\.isFavorite)
  }

  var body: some View {
    ScrollView {
      HStack {
        Text("\(favoritePhotos.count) Photos")
          .font(.subheadline)
          .foregroundColor(.gray)
        Spacer()
      }
      .padding(.horizontal)
      .padding(.bottom, 8)

      if favoritePhotos.isEmpty {
        ContentUnavailableView(
          "No Favorites Yet",
          systemImage: "heart.slash",
          description: Text("Favorite photos from the library and they will appear here.")
        )
        .padding(.top, 48)
      } else {
        LazyVGrid(columns: columns, spacing: 1) {
          ForEach(favoritePhotos) { photo in
            NavigationLink {
              ImageItemView(
                photos: $photos,
                initialPhotoID: photo.id,
                displayedPhotoIDs: favoritePhotos.map(\.id)
              )
            } label: {
              Image(photo.filename)
                .resizable()
                .scaledToFill()
                .frame(height: 120)
                .clipped()
            }
          }
        }
      }
    }
    .navigationTitle("Favorites")
    .navigationBarTitleDisplayMode(.inline)
    .preferredColorScheme(.dark)
  }
}
