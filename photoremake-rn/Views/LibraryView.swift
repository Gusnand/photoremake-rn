import SwiftUI

struct LibraryView: View {
  let columns = [GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1)]
  let images = (10...20).map {"photo_\($0)"}
  
  @Binding var imageArray: [ImageDetail]
  
  var body: some View {
    NavigationStack{
      
      ScrollView{
        LazyVGrid(columns: columns, spacing: 1) {
          ForEach($imageArray) {image in
            NavigationLink {
              ImageItemView(image: image, caption: "")
            } label: {
              Image(image.filename
                .wrappedValue).resizable().scaledToFill().frame(height: 120).clipped().clipShape(RoundedRectangle(cornerRadius: 4))
            }
          }
        }
      }
      
      .navigationTitle("Home")
      .navigationSubtitle("15 April 2026")
      .toolbarTitleDisplayMode(.inlineLarge)
      .toolbar{
        ToolbarItem(){
          Image(systemName: "line.3.horizontal.decrease")
        }
        ToolbarSpacer(placement: .topBarTrailing)
        ToolbarItem(placement: .topBarTrailing){
          Menu {
            Button("Select", systemImage: "") {
              // action
            }
          } label : {
            Text("Select").padding()
          }
        }
      }
    }.preferredColorScheme(.dark)
  }
}

#Preview {
  LibraryView(imageArray: .constant(ImageDetail.gallery))
}
