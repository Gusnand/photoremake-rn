import SwiftUI

struct ImageItemView: View {
  let allPhotos: [ImageDetail]
  
  @Binding var image: ImageDetail
  @State private var isShowingInfo = false
  
  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      
      VStack(spacing: 0) {
        // 3. THE BIG PAGING VIEW
        TabView(selection: $image) {
          ForEach(allPhotos) { photo in
            Image(photo.filename)
              .resizable()
              .scaledToFit()
            // The tag is CRITICAL. It tells the TabView which photo is which
              .tag(photo)
          }
        }
        .tabViewStyle(.page(indexDisplayMode: .never)) // Native swipe gesture!
        
        // 4. THE SCRUBBER (See below)
        scrubberView
      }
    }
    // Native bottom toolbar setup
    .toolbar {
      ToolbarItemGroup(placement: .bottomBar) {
        Button(action: { /* Share Action */ }) {
          Image(systemName: "square.and.arrow.up")
        }
        Spacer()
        Button(action: {
          withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            image.isFavorite.toggle()
          }
        }) {
          Image(systemName: image.isFavorite ? "heart.fill" : "heart")
            .foregroundColor(image.isFavorite ? .white : .white)
        }
        Spacer()
        Button(action: {
          isShowingInfo = true
        }) {
          Image(systemName: "info.circle")
        }
        Spacer()
        
        Spacer()
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
  
  private var scrubberView: some View {
    ScrollViewReader { proxy in
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 2) {
          ForEach(allPhotos) { photo in
            Image(photo.filename)
              .resizable()
              .scaledToFill()
              .frame(width: 30, height: 40)
              .clipped()
            // Make non-selected photos slightly faded
              .opacity(photo == image ? 1.0 : 0.5)
            // Add the white border to the selected photo
              .overlay {
                if photo == image {
                  Rectangle().stroke(Color.white, lineWidth: 2)
                }
              }
            // Give it an ID so the proxy can find it
              .id(photo.id)
              .onTapGesture {
                // If they tap a thumbnail, jump to it!
                withAnimation {
                  image = photo
                }
              }
          }
        }
        .padding(.vertical, 8)
      }
      .frame(height: 50)
      .background(Color.black)
      
      // 5. THE SYNCHRONIZATION MAGIC
      // When the user swipes the big image, scroll the bottom bar to match
      .onChange(of: image) { oldValue, newValue in
        withAnimation {
          // Use the 'newValue' to scroll to the correct ID
          proxy.scrollTo(newValue.id, anchor: .center)
        }
      }
      // When the page first loads, immediately center the scrubber
      .onAppear {
        proxy.scrollTo(image.id, anchor: .center)
      }
    }
  }
}
