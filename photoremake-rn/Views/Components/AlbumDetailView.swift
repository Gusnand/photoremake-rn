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
  @State private var isShowingDialog = false
  
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
            NavigationLink (destination: {
              ImageItemView(
                photos: $album.photos,
                initialPhotoID: photo.id,
                displayedPhotoIDs: album.photos.map(\.id)
              )
            }, label : {
              Image(photo.filename).resizable().scaledToFill().frame(height: 120).clipped()
            })
          }
        }
      }
    }
    .navigationTitle(album.title)
    .navigationBarTitleDisplayMode(.inline)
    .toolbar(isSelectShowing ? .hidden : .automatic, for: .tabBar)
    .preferredColorScheme(.dark)
    .toolbar {
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
          ShareLink(
            items: selectedPhotos.map {$0.caption},
            subject: Text("Your Photos"),
            message: Text("Check out these photos!"),
          ){
            Image(systemName: "square.and.arrow.up")
          }.disabled(selectedPhotos.isEmpty)
          
          Spacer()
          
          Button(action: {
            isShowingDialog = true
          }){
            Image(systemName: "trash")
          }.disabled(selectedPhotos.isEmpty)
            .confirmationDialog(
              "Are you sure?", isPresented: $isShowingDialog
            ){
              Button("Delete \(selectedPhotos.count) Photos", role: .destructive) {
                album.photos.removeAll (where: {photo in selectedPhotos.contains(photo)})
              }
            }message: {
              Text("These photos will be deleted from iCloud Photos on all your devices. They will be in Recently Deleted for 30 days.")
            }
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
