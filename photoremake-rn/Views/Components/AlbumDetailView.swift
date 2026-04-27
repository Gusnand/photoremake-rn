import SwiftUI

struct AlbumDetailView: View {
  let columns = [
    GridItem(.flexible(), spacing: 1),
    GridItem(.flexible(), spacing: 1),
    GridItem(.flexible(), spacing: 1),
  ]

  let albumTitle: String
  let displayedPhotoIDs: [ImageDetail.ID]
  @Binding var photos: [ImageDetail]

  @State private var isSelectShowing = false
  @State private var selectedPhotoIDs: Set<ImageDetail.ID> = []
  @State private var isShowingDialog = false

  var body: some View {
    ScrollView {
      HStack {
        Text("\(displayedPhotos.count) Photos")
          .font(.subheadline)
          .foregroundColor(.gray)
        Spacer()
      }
      .padding(.horizontal)
      .padding(.bottom, 8)

      LazyVGrid (columns: columns, spacing: 1) {
        ForEach(displayedPhotos) { photo in
          if isSelectShowing {
            Image(photo.filename).resizable().scaledToFill().frame(height: 120).clipped()
              .overlay(alignment: .bottomTrailing) {
                Image(systemName: selectedPhotoIDs.contains(photo.id) ? "checkmark.circle.fill" : "circle")
                  .font(.title3)
                  .foregroundStyle(selectedPhotoIDs.contains(photo.id) ? .blue : .white.opacity(0.8))
                  .padding(1)
              }.onTapGesture {
                if isSelectShowing {
                  if selectedPhotoIDs.contains(photo.id) {
                    selectedPhotoIDs.remove(photo.id)
                  }else{
                    selectedPhotoIDs.insert(photo.id)
                  }
                }
              }
          }else {
            NavigationLink (destination: {
              ImageItemView(
                photos: $photos,
                initialPhotoID: photo.id,
                displayedPhotoIDs: displayedPhotoIDs
              )
            }, label : {
              Image(photo.filename).resizable().scaledToFill().frame(height: 120).clipped()
            })
          }
        }
      }
    }
    .navigationTitle(albumTitle)
    .navigationBarTitleDisplayMode(.inline)
    .toolbar(isSelectShowing ? .hidden : .automatic, for: .tabBar)
    .preferredColorScheme(.dark)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        if isSelectShowing {
          Button("Cancel") {
            isSelectShowing = false
            selectedPhotoIDs.removeAll()
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
            items: selectedPhotos.map(\.caption),
            subject: Text("Your Photos"),
            message: Text("Check out these photos!"),
          ){
            Image(systemName: "square.and.arrow.up")
          }.disabled(selectedPhotoIDs.isEmpty)
          
          Spacer()
          
          Button(action: {
            isShowingDialog = true
          }){
            Image(systemName: "trash")
          }.disabled(selectedPhotoIDs.isEmpty)
            .confirmationDialog(
              "Are you sure?", isPresented: $isShowingDialog
            ){
              Button("Delete \(selectedPhotoIDs.count) Photos", role: .destructive) {
                photos.removeAll { photo in
                  selectedPhotoIDs.contains(photo.id)
                }
                selectedPhotoIDs.removeAll()
                isSelectShowing = false
              }
            }message: {
              Text("These photos will be deleted from iCloud Photos on all your devices. They will be in Recently Deleted for 30 days.")
            }
        }
        
        ToolbarItem(placement: .status) {
          Text(selectedPhotoIDs.isEmpty ? "Select Items" : "\(selectedPhotoIDs.count) Selected")
            .font(.subheadline).fontWeight(.semibold).fixedSize()
        }.sharedBackgroundVisibility(.hidden)
      }
    }
  }

  private var displayedPhotos: [ImageDetail] {
    let displayedIDSet = Set(displayedPhotoIDs)
    return photos.filter { displayedIDSet.contains($0.id) }
  }

  private var selectedPhotos: [ImageDetail] {
    displayedPhotos.filter { selectedPhotoIDs.contains($0.id) }
  }
}

#Preview {
  NavigationStack {
    AlbumDetailPreview()
  }
}

private struct AlbumDetailPreview: View {
  @State private var photos = ImageDetail.gallery

  var body: some View {
    let album = AllAlbums.mockDataImportantAlbums[1]

    AlbumDetailView(
      albumTitle: album.title,
      displayedPhotoIDs: album.photos.map(\.id),
      photos: $photos
    )
  }
}
