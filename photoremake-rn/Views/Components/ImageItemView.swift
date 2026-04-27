import SwiftUI

struct ImageItemView: View {
  @Binding var photos: [ImageDetail]
  private let displayedPhotoIDs: [ImageDetail.ID]?

  @State private var selectedPhotoID: ImageDetail.ID
  @State private var isShowingInfo = false

  init(
    photos: Binding<[ImageDetail]>,
    initialPhotoID: ImageDetail.ID,
    displayedPhotoIDs: [ImageDetail.ID]? = nil
  ) {
    _photos = photos
    self.displayedPhotoIDs = displayedPhotoIDs
    _selectedPhotoID = State(initialValue: initialPhotoID)
  }

  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      VStack(spacing: 0) {
        TabView(selection: $selectedPhotoID) {
          ForEach(displayedPhotos) { photo in
            Image(photo.filename)
              .resizable()
              .scaledToFit()
              .tag(photo.id)
          }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        scrubberView
      }
    }
    .toolbar {
      ToolbarItemGroup(placement: .bottomBar) {
        Button(action: { /* Share Action */ }) {
          Image(systemName: "square.and.arrow.up")
        }
        Spacer()
        Button(action: {
          withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            toggleFavorite()
          }
        }) {
          Image(systemName: selectedPhoto?.isFavorite == true ? "heart.fill" : "heart")
            .foregroundColor(.white)
        }
        .disabled(selectedPhotoBinding == nil)
        Spacer()
        Button(action: {
          isShowingInfo = true
        }) {
          Image(systemName: "info.circle")
        }
        .disabled(selectedPhotoBinding == nil)
        Spacer()
        
        Spacer()
        Button(action: { /* Delete Action */ }) {
          Image(systemName: "trash")
        }
      }
    }
    .sheet(isPresented: $isShowingInfo) {
      if let selectedPhotoBinding {
        ImageInfoSheet(image: selectedPhotoBinding)
      }
    }
    .preferredColorScheme(.dark)
    .toolbar(.hidden, for: .tabBar)
  }

  private var displayedPhotos: [ImageDetail] {
    guard let displayedPhotoIDs else {
      return photos
    }

    let displayedIDSet = Set(displayedPhotoIDs)
    return photos.filter { displayedIDSet.contains($0.id) }
  }

  private var selectedPhotoIndex: Int? {
    photos.firstIndex { $0.id == selectedPhotoID }
  }

  private var selectedPhoto: ImageDetail? {
    guard let selectedPhotoIndex else {
      return nil
    }

    return photos[selectedPhotoIndex]
  }

  private var selectedPhotoBinding: Binding<ImageDetail>? {
    guard let selectedPhotoIndex else {
      return nil
    }

    return $photos[selectedPhotoIndex]
  }

  private func toggleFavorite() {
    guard let selectedPhotoBinding else {
      return
    }

    selectedPhotoBinding.wrappedValue.isFavorite.toggle()
  }

  private var scrubberView: some View {
    ScrollViewReader { proxy in
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 2) {
          ForEach(displayedPhotos) { photo in
            Image(photo.filename)
              .resizable()
              .scaledToFill()
              .frame(width: 30, height: 40)
              .clipped()
              .opacity(photo.id == selectedPhotoID ? 1.0 : 0.5)
              .overlay {
                if photo.id == selectedPhotoID {
                  Rectangle().stroke(Color.white, lineWidth: 2)
                }
              }
              .id(photo.id)
              .onTapGesture {
                withAnimation {
                  selectedPhotoID = photo.id
                }
              }
          }
        }
        .padding(.vertical, 8)
      }
      .frame(height: 50)
      .background(Color.black)
      .onChange(of: selectedPhotoID) { _, newValue in
        withAnimation {
          proxy.scrollTo(newValue, anchor: .center)
        }
      }
      .onAppear {
        proxy.scrollTo(selectedPhotoID, anchor: .center)
      }
    }
  }
}

#Preview {
  PreviewImageItemView()
}

private struct PreviewImageItemView: View {
  @State private var photos = Array(ImageDetail.gallery.prefix(6))

  var body: some View {
    NavigationStack {
      if let initialPhotoID = photos.first?.id {
        ImageItemView(photos: $photos, initialPhotoID: initialPhotoID)
      }
    }
  }
}
