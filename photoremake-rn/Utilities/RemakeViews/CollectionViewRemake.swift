import SwiftUI

struct CollectionViewRemake: View {
  let columns = [
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible(), spacing: 16)
  ]
  @State private var importantAlbums = ImportantAlbum.mockData
  
  
  var body: some View {
    NavigationStack{
      VStack (alignment: .leading, spacing: 14){
        
        HStack{
          Text("Important Albums").font(.title2).bold()
          Spacer()
          Text("See All").font(.headline).foregroundColor(.blue)
        }
        ScrollView{
          
          LazyVGrid(columns: columns, spacing: 6) {
            ForEach(importantAlbums) {album in
              VStack(alignment: .leading, spacing: 4) {
                // 1. The Thumbnail
                RoundedRectangle(cornerRadius: 16)
                  .fill(Color(UIColor.systemGray5))
                  .aspectRatio(1, contentMode: .fit) // Keeps it a perfect square
                
                // 2. The Title
                Text(album.title)
                  .font(.subheadline)
                  .foregroundColor(.white)
                  .lineLimit(1)
                
                // 3. The Count
                Text("\(album.count)")
                  .font(.caption)
                  .foregroundColor(.gray)
              }
            }
          }
          
          
          //              HStack(spacing: 6){
          //                            ForEach(images, id: \..self) {image in
          //                              Image(image)
          //                                .resizable()
          //                                .scaledToFill()
          //                                .frame(height:130)
          //                                .overlay(){
          //                                  LinearGradient(
          //                                    colors: [.clear, .black.opacity(0.6)],
          //                                    startPoint: .center,
          //                                    endPoint: .bottom,
          //                                  )
          //                                }
          //                                .overlay(alignment: .bottomLeading){
          //                                  Text("WhatsApp").font(.subheadline).fontWeight(.semibold).foregroundStyle(.white).padding(12)
          //                                }
          //                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
          //                            }
          //                          }
          
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
