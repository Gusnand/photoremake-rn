import SwiftUI

struct ImageItemView: View {
  @Binding var image: ImageDetail
  @State var caption: String
  
  var body: some View {
    VStack(alignment: .leading) {
      Image(image.filename).resizable().scaledToFit()
      Text(image.caption)
      TextField(image.caption, text: $caption).foregroundStyle(Color.secondary)
      Button{
        image.caption = caption
      }label: {
        Label("Save", systemImage: "chevron.forward")
      }
    }
  }
}

#Preview {
  ImageItemView(image: .constant(ImageDetail.gallery[0]), caption: "")
}
