import SwiftUI

struct CollectionViewRemake: View {
  let columns = [
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible(), spacing: 16)
  ]
  
  @State private var importantCollection = AllAlbums.mockDataImportantAlbums
  
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
            ForEach($importantCollection) {$album in
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
                ControlGroup {
                  Button {
                    // action
                  } label :{
                    Image(systemName: "rectangle.grid.3x1.fill")
                  }
                  Button {
                    // action
                  } label :{
                    Image(systemName: "rectangle.grid.3x3.fill")
                  }
                  Button {
                    // action
                  } label :{
                    Image(systemName: "rectangle.grid.2x2.fill")
                  }
                }
                
                Button("Show All", systemImage: "") {
                  // action
                }
                Button("Collapse All", systemImage: "") {
                  // action
                }
                Divider()
                Button ("Reorder", systemImage: "") {
                  // action
                }
              } label: {
                Image(systemName: "ellipsis")
              }
            }
            ToolbarSpacer(placement: .topBarTrailing)
            ToolbarItem(placement: .primaryAction){
              Button(action: {
                //action
              }) {
                Image(systemName: "plus")
              }
            }
          }
      }.padding()
    }.preferredColorScheme(.dark)
  }
}

#Preview {
  CollectionViewRemake()
}
