import SwiftUI

struct ContentViewRemake: View {
  @State var imageArray: [ImageDetail] = ImageDetail.gallery
  
  var body: some View {
    TabView {
      Tab("Library", systemImage: "photo.fill.on.rectangle.fill") {
        LibraryView(imageArray: $imageArray)
      }
      Tab("Collection", systemImage: "photo.stack") {
        CollectionViewRemake()
      }
      Tab(role: .search) {
        Text("Search Page")
      }
    }
  }
}

#Preview {
  ContentViewRemake()
}
