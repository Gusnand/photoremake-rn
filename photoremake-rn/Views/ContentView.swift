import SwiftUI

struct ContentView: View {
  @State var imageArray: [ImageDetail] = ImageDetail.gallery
  
  var body: some View {
    TabView{
      Tab("Library", systemImage: "photo.fill.on.rectangle.fill"){
        LibraryView(imageArray: $imageArray)
      }
      
      Tab("Collection", systemImage: "photo.stack"){
        CollectionView()
      }
      Tab(role: .search){
        Text("Search Page")
      }
    }
  }
}

#Preview {
  ContentView()
}
