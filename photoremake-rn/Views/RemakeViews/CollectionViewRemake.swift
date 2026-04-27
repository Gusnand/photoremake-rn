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
            // Assuming AllAlbumView exists in your project
            // AllAlbumView()
          }
        }.scenePadding(.bottom)
        
        ScrollView {
          LazyVGrid(columns: columns, spacing: 18) {
            
            // 3. NEW: Pin the Smart Favorites Album to the top of the grid!
            NavigationLink {
              // We use .constant because the master list controls this data
              AlbumDetailView(album: .constant(favoritesAlbum))
            } label: {
              albumThumbnail(for: favoritesAlbum)
            }
            .buttonStyle(.plain)
            
            // 4. Your existing loop for the rest of the important albums
            ForEach($importantAlbums) { $album in
              NavigationLink {
                AlbumDetailView(album: $album)
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
            Menu {
              Button("Choose Important Albums", systemImage: "") {
                isShowingAlbumPicker = true
              }
              Divider()
              Button("Select", systemImage: "") {
                // action
              }
            } label: {
              Image(systemName: "ellipsis")
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
