import SwiftUI

struct AlbumDetailView: View {
  let columns = [
    GridItem(.flexible(), spacing: 1),
    GridItem(.flexible(), spacing: 1),
    GridItem(.flexible(), spacing: 1),
  ]
  
  @Binding var album: AllAlbums
  @State private var isSelectShowing = false
  @State private var selectedPhotos: Set<ImageDetail> = []
  
  var body: some View {
    ScrollView {
      HStack {
        Text("\(album.count) Photos")
          .font(.subheadline)
          .foregroundColor(.gray)
        Spacer()
      }
      .padding(.horizontal)
      .padding(.bottom, 8)
      
      LazyVGrid (columns: columns, spacing: 1) {
        ForEach($album.photos) { $photo in
          if isSelectShowing {
            Image(photo.filename).resizable().scaledToFill().frame(height: 120).clipped()
              .overlay(alignment: .bottomTrailing) {
                Image(systemName: selectedPhotos.contains(photo) ? "checkmark.circle.fill" : "circle")
                  .font(.title3)
                  .foregroundStyle(selectedPhotos.contains(photo) ? .blue : .white.opacity(0.8))
                  .padding(1)
              }.onTapGesture {
                if isSelectShowing {
                  if selectedPhotos.contains(photo) {
                    selectedPhotos.remove(photo)
                  }else{
                    selectedPhotos.insert(photo)
                  }
                }
              }
          }else {
            NavigationLink {
              ImageItemView(image: $photo, caption: "")
            } label : {
              Image(photo.filename).resizable().scaledToFill().frame(height: 120).clipped()
            }
          }
        }
      }
    }
    .navigationTitle(album.title)
    .navigationBarTitleDisplayMode(.inline)
    .toolbar(isSelectShowing ? .hidden : .visible, for: .tabBar)
    .preferredColorScheme(.dark)
    .toolbar {
      // Top Toolbar (Select/Cancel)
      ToolbarItem(placement: .topBarTrailing) {
        if isSelectShowing {
          Button("Cancel") {
            isSelectShowing = false
            selectedPhotos.removeAll()
          }
        } else {
          Button("Select") {
            isSelectShowing = true
          }
        }
      }
      
      // Bottom Toolbar (Actions)
      if isSelectShowing {
        ToolbarItemGroup(placement: .bottomBar) {
          Button(action: { /* Share Action */ }) {
            Image(systemName: "square.and.arrow.up")
          }.disabled(selectedPhotos.isEmpty)
          
          Spacer()
          
          Button(action: { /* Delete Action */ }) {
            Image(systemName: "trash")
          }.disabled(selectedPhotos.isEmpty)
        }
        
        ToolbarItem(placement: .status) {
          Text(selectedPhotos.isEmpty ? "Select Items" : "\(selectedPhotos.count) Selected")
            .font(.subheadline).fontWeight(.semibold).fixedSize()
        }.sharedBackgroundVisibility(.hidden)
      }
    }
  }
}

#Preview {
  NavigationStack {
    AlbumDetailView(album: .constant(AllAlbums.mockDataImportantAlbums[0]))
  }
}
