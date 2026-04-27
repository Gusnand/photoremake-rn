import SwiftUI

struct ContentViewRemake: View {
  @State var imageArray: [ImageDetail] = ImageDetail.gallery
  
  var body: some View {
    TabView {
//      Tab("Library", systemImage: "photo.fill.on.rectangle.fill") {
//        LibraryViewRemake(imageArray: $imageArray)
//      }
//      Tab("Collection", systemImage: "photo.stack") {
//        CollectionViewRemake()
//      }
      LibraryViewRemake(imageArray: $imageArray).tabItem{
        Label ("Library", systemImage: "photo.fill.on.rectangle.fill")
      }
      
      CollectionViewRemake().tabItem {
        Label("Albums", systemImage: "photo.stack")
      }
      
    }
  }
}

#Preview {
  ContentViewRemake()
}
