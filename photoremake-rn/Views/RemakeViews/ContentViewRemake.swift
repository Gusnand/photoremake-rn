import SwiftUI

struct ContentViewRemake: View {
  @State var imageArray: [ImageDetail] = ImageDetail.gallery
  
  var body: some View {
    TabView {
      LibraryViewRemake(imageArray: $imageArray).tabItem{
        Label ("Library", systemImage: "photo.fill.on.rectangle.fill")
      }
      
      CollectionViewRemake(imageArray: $imageArray).tabItem {
        Label("Albums", systemImage: "photo.stack")
      }
    }
  }
}

#Preview {
  ContentViewRemake()
}
