import SwiftUI

struct AllAlbumView: View {
  let columns = [
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible(), spacing: 16)
  ]
  
  @State private var AllAlbum = AllAlbums.mockDataAllAlbums
  
  var body: some View {
    NavigationStack{
      VStack (alignment: .leading, spacing: 14){
        ScrollView{
          LazyVGrid(columns: columns, spacing: 18) {
            ForEach($AllAlbum) {$album in
              NavigationLink (destination:{
                AlbumDetailView(album: $album)
              }, label : {
                VStack(alignment: .leading, spacing: 4) {
                  Group {
                    if let cover = album.coverPhoto {
                      // If the album has photos, show the first one!
                      Image(cover.filename)
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(1, contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    } else {
                      // If the album is empty, show the empty gray folder look
                      RoundedRectangle(cornerRadius: 16)
                        .fill(Color(UIColor.systemGray5))
                        .aspectRatio(1, contentMode: .fit)
                        .overlay {
                          Image(systemName: "photo.on.rectangle.angled")
                            .foregroundColor(.gray)
                            .font(.largeTitle)
                        }
                    }
                  }
                  
                  Text(album.title)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .lineLimit(1)
                  Text("\(album.count)")
                    .font(.caption)
                    .foregroundColor(.gray)
                }
              })
              .buttonStyle(.plain)
            }
          }
        }.scrollIndicators(.hidden)
          .navigationTitle("Albums")
          .navigationBarTitleDisplayMode(.inline)
          .toolbarTitleDisplayMode(.inlineLarge)
      }.padding()
    }.preferredColorScheme(.dark)
  }
}

#Preview {
  AllAlbumView()
}
