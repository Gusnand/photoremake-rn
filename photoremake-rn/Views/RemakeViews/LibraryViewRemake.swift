import SwiftUI
import UniformTypeIdentifiers

struct ZippedPhotos: Transferable {
    var photos: [ImageDetail]
    
    static var transferRepresentation: some TransferRepresentation {
        // FileRepresentation tells the Share Sheet we are exporting a physical file
        FileRepresentation(exportedContentType: .zip) { zippedItem in
            
            // 1. Convert the selected ImageDetails into 'FileToZip.data'
            let filesToZip = zippedItem.photos.compactMap { photo -> FileToZip? in
                // Assuming images are in your Asset Catalog, we grab them as UIImages to get their Data
                guard let uiImage = UIImage(named: photo.filename),
                      let imageData = uiImage.jpegData(compressionQuality: 0.9) else {
                    return nil
                }
                
                // Append .jpg so the unzipped files have the correct extension
                return .data(imageData, filename: "\(photo.filename).jpg")
            }
            
            // 2. Use your existing createZipAtTmp function
            let zipURL = try createZipAtTmp(
                zipFilename: "Organized_Photos_\(Int(Date().timeIntervalSince1970))",
                filesToZip: filesToZip
            )
            
            // 3. Return the generated file URL
            return SentTransferredFile(zipURL)
        }
    }
}

struct LibraryViewRemake: View {
  
  @Binding var imageArray: [ImageDetail]
  
  @State private var isSelectMode = false
  @State private var selectedPhotos : Set<ImageDetail> = []
  @State private var isShowingDialog = false
    
  
  let columns = [
    GridItem(.flexible(), spacing: 1),
    GridItem(.flexible(), spacing: 1),
    GridItem(.flexible(), spacing: 1)]
  
  var body: some View {
    NavigationStack{
      ScrollView{
        LazyVGrid(columns: columns, spacing: 1) {
          ForEach($imageArray) {$image in
            if isSelectMode {
              Image(image.filename).resizable().scaledToFill().frame(height: 120).clipped().clipShape(RoundedRectangle(cornerRadius: 4))
                .overlay(alignment: .bottomTrailing) {
                  if isSelectMode {
                    Image(systemName: selectedPhotos.contains(image) ? "checkmark.circle.fill" : "circle").font(.title3).foregroundStyle(selectedPhotos.contains(image) ? .blue : .white.opacity(0.8)).padding(4)
                  }
                }
                .onTapGesture {
                  if isSelectMode {
                    if selectedPhotos.contains(image) {
                      selectedPhotos.remove(image)
                    }else{
                      selectedPhotos.insert(image)
                    }
                  }
                }
            } else {
              NavigationLink {
                ImageItemView(image: $image, caption: "")
              } label: {
                Image(image.filename).resizable().scaledToFill().frame(height: 120).clipped().clipShape(RoundedRectangle(cornerRadius: 4))
              }
            }
          }
        }
        
        .navigationTitle("Library")
        .navigationSubtitle(Date().formatted())
        .toolbarTitleDisplayMode(.inlineLarge)
        .toolbar(isSelectMode ? .hidden : .visible, for: .tabBar)
        .toolbar{
          ToolbarItem(){
            Image(systemName: "ellipsis")
          }
          ToolbarSpacer(placement: .topBarTrailing)
          ToolbarItem(placement: .topBarTrailing){
            if isSelectMode {
              Button("Cancel", systemImage: "xmark"){
                isSelectMode = false
                selectedPhotos.removeAll()
              }
            }else {
              Button("Select"){
                isSelectMode = true
              }
            }
          }
          if isSelectMode {
            ToolbarItemGroup(placement: .bottomBar){
                Menu {
                    // Option 1: Share as Individual Images
                    ShareLink(
                        items: Array(selectedPhotos),
                        subject: Text("Your Photos"),
                        message: Text("Check out these photos!"),
                        preview: { photo in
                            SharePreview(photo.caption, image: Image(photo.filename))
                        }
                    ) {
                        Label("Share as Images", systemImage: "photo.on.rectangle")
                    }
                    
                    // Option 2: Share as a ZIP Archive
                    ShareLink(
                        item: ZippedPhotos(photos: Array(selectedPhotos)),
                        preview: SharePreview(
                            "\(selectedPhotos.count) Photos (ZIP)",
                            image: Image(systemName: "doc.zipper")
                        )
                    ) {
                        Label("Share as ZIP", systemImage: "doc.zipper")
                    }
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
                .disabled(selectedPhotos.isEmpty)
                
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
                    imageArray.removeAll (where: {photo in selectedPhotos.contains(photo)})
                  }
                }message: {
                  Text("These photos will be deleted from iCloud Photos on all your devices. They will be in Recently Deleted for 30 days.")
                }
            }
            ToolbarItem(placement: .status){
              Text(selectedPhotos.isEmpty ? "Select Items" : "\(selectedPhotos.count) Items Selected").font(.subheadline).fontWeight(.semibold).fixedSize()
            }.sharedBackgroundVisibility(.hidden)
          }
        }
      }.preferredColorScheme(.dark)
    }
  }
}

#Preview {
  LibraryViewRemake(imageArray: .constant(ImageDetail.gallery))
}
