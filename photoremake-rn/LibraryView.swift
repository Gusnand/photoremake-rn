
import SwiftUI

struct LibraryView: View {
  let columns = [GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1)]
  let images = (10...20).map {"photo_\($0)"}
  
  var body: some View {
    NavigationStack{
      
      ScrollView{
        LazyVGrid(columns: columns, spacing: 1) {
          ForEach(images, id: \..self) {image in
            Image(image)
              .resizable()
              .scaledToFill()
              .frame(height:120)
              .clipped()
              .clipShape(RoundedRectangle(cornerRadius: 4))
          }
        }
      }
      
      .navigationTitle("Home")
      .toolbar{
        ToolbarItem(){
          Image(systemName: "line.3.horizontal.decrease")
        }
        ToolbarSpacer(placement: .topBarTrailing)
        ToolbarItem(placement: .topBarTrailing){
          Text("Select").padding()
        }
      }
    }
  }
}
