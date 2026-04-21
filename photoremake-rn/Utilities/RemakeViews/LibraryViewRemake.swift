import SwiftUI

struct LibraryViewRemake: View {
  let columns = [GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1)]
  
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
      
      .navigationTitle("Library")
      .navigationSubtitle(Date().formatted())
      .toolbarTitleDisplayMode(.inlineLarge)
      .toolbar{
        ToolbarItem(){
          Image(systemName: "ellipsis")
        }
        ToolbarSpacer(placement: .topBarTrailing)
        ToolbarItem(placement: .topBarTrailing){
          Button("Select", systemImage: "") {
            // i want to change the view here after user click select. the select button will changed into "X" button, and the tabview below will changed to share icon button on the leading, "Select Items" text in the middle, and trash icon button in the trailing. and if user selecting 1 or more photos, the text in the middle changed into n Photos selected text.
          }
        }
      }
    }.preferredColorScheme(.dark)
  }
}

#Preview {
  LibraryViewRemake(imageArray: .constant(ImageDetail.gallery))
}
