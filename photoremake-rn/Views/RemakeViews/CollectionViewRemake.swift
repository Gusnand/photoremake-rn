import SwiftUI

struct CollectionViewRemake: View {
  let columns = [
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible(), spacing: 16)
  ]
  
  @State private var allAlbums = AllAlbums.mockDataAllAlbums
  @State private var importantAlbums: [AllAlbums] = []
  @State private var isShowingAlbumPicker = false
  
  var body: some View {
    NavigationStack{
      VStack (alignment: .leading, spacing: 14){
        HStack{
          Text("Important Albums").font(.title3).fontWeight(.light)
          Spacer()
          NavigationLink("See All"){
            AllAlbumView()
          }
        }.scenePadding(.bottom)
        ScrollView{
          LazyVGrid(columns: columns, spacing: 18) {
            ForEach($importantAlbums) {$album in
              NavigationLink {
                AlbumDetailView(album: $album)
              } label : {
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
              }
              .buttonStyle(.plain)
            }
          }
        }.scrollIndicators(.hidden)
          .navigationTitle("Albums")
          .toolbarTitleDisplayMode(.inlineLarge)
          .toolbar{
            ToolbarItem(placement: .topBarTrailing){
              Menu {
                Button("Choose Important Albums", systemImage: "") {
                  isShowingAlbumPicker = true // Opens the sheet!
                }
                Divider()
                Button ("Select", systemImage: "") {
                  // action
                }
              } label: {
                Image(systemName: "ellipsis")
              }
            }
          }
          .onAppear {
            // Initialize the important albums safely on the first load
            if importantAlbums.isEmpty {
              // For example: grab the first 5 albums to be "important" by default
              importantAlbums = Array(allAlbums.prefix(5))
            }
          }
          .sheet(isPresented: $isShowingAlbumPicker) {
            ChooseAlbumsSheet(
              allAlbums: allAlbums,
              importantAlbums: $importantAlbums // Pass the binding!
            )
          }
      }.padding()
    }.preferredColorScheme(.dark)
  }
}

#Preview {
  CollectionViewRemake()
}
