import SwiftUI

struct ImageItemView: View {
  @Binding var image: ImageDetail
  
//  @State var caption: String
  @State private var isShowingInfo = false
  
  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      
      Image(image.filename)
        .resizable()
        .scaledToFit()
    }
    // Native bottom toolbar setup
    .toolbar {
      ToolbarItemGroup(placement: .bottomBar) {
        // 1. Share
        Button(action: { /* Share Action */ }) {
          Image(systemName: "square.and.arrow.up")
        }
        Spacer()
        
        // 2. Favorite (We will build this function next!)
        Button(action: { /* Favorite Action */ }) {
          Image(systemName: "heart")
        }
        Spacer()
        
        // 3. INFO BUTTON (Triggers the Sheet)
        Button(action: {
          isShowingInfo = true
        }) {
          Image(systemName: "info.circle")
        }
        Spacer()
        
        // 4. Adjust/Sliders
        Button(action: { /* Adjust Action */ }) {
          Image(systemName: "slider.horizontal.3")
        }
        Spacer()
        
        // 5. Trash
        Button(action: { /* Delete Action */ }) {
          Image(systemName: "trash")
        }
      }
    }
    // Apply the sheet modifier to the ZStack
    .sheet(isPresented: $isShowingInfo) {
      ImageInfoSheet(image: $image)
    }
    .preferredColorScheme(.dark)
    .toolbar(.hidden, for: .tabBar)
  }
}
