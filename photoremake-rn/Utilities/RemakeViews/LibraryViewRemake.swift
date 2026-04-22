import SwiftUI

struct LibraryViewRemake: View {
  
  @Binding var imageArray: [ImageDetail]
  
  @State private var isSelectMode = false
  @State private var selectedPhotos : Set<ImageDetail> = []
  
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
              Button(action: {
                // share action
              }) {
                Image(systemName: "square.and.arrow.up")
              }.disabled(selectedPhotos.isEmpty)
              
              Spacer()
              
              Text(selectedPhotos.isEmpty ? "Select Items" : "\(selectedPhotos.count) Items Selected").font(.subheadline).fontWeight(.semibold)
              
              Spacer()
              
              Button(action: {
                //Delete Action
              }){
                Image(systemName: "trash")
              }.disabled(selectedPhotos.isEmpty)
            }
          }
        }
      }.preferredColorScheme(.dark)
    }
  }
}

#Preview {
  LibraryViewRemake(imageArray: .constant(ImageDetail.gallery))
}
