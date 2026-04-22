import SwiftUI

struct AlbumDetailView: View {
  @Binding var album: ImportantAlbum
  
  var body: some View {
    ScrollView {
      Text("Welcome to the \(album.title) album").padding()
      Text("There are \(album.count) photos here").foregroundColor(.gray)
    }.navigationTitle(album.title)
      .navigationBarTitleDisplayMode(.inline)
  }
}

//#Preview {
//  AlbumDetailView()
//}
