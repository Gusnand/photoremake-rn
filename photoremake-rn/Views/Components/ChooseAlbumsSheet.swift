import SwiftUI

struct ChooseAlbumsSheet: View {
  @Environment(\.dismiss) var dismiss
  
  // Using your new AllAlbums model
  let allAlbums: [AllAlbums]
  @Binding var importantAlbums: [AllAlbums]
  
  // The temporary bucket to hold selections
  @State private var selectedAlbumIDs: Set<UUID> = []
  
  var body: some View {
    NavigationStack {
      List(allAlbums) { album in
        HStack(spacing: 12) {
          
          // Optional: Show a tiny thumbnail in the list!
          if let cover = album.coverPhoto {
            Image(cover.filename)
              .resizable()
              .scaledToFill()
              .frame(width: 40, height: 40)
              .clipShape(RoundedRectangle(cornerRadius: 6))
          } else {
            RoundedRectangle(cornerRadius: 6)
              .fill(Color(UIColor.systemGray5))
              .frame(width: 40, height: 40)
          }
          
          Text(album.title)
            .font(.body)
          
          Spacer()
          
          // Checkmark Logic
          if selectedAlbumIDs.contains(album.id) {
            Image(systemName: "checkmark.circle.fill")
              .foregroundColor(.blue)
              .font(.title3)
          } else {
            Image(systemName: "circle")
              .foregroundColor(.gray.opacity(0.3))
              .font(.title3)
          }
        }
        .contentShape(Rectangle()) // Makes the whole row tappable
        .onTapGesture {
          if selectedAlbumIDs.contains(album.id) {
            selectedAlbumIDs.remove(album.id)
          } else {
            selectedAlbumIDs.insert(album.id)
          }
        }
      }
      .listStyle(.plain)
      .navigationTitle("Choose Albums")
      .navigationBarTitleDisplayMode(.inline)
      
      // MAP EXISTING SELECTIONS ON OPEN
      .onAppear {
        let existingIDs = importantAlbums.map { $0.id }
        selectedAlbumIDs = Set(existingIDs)
      }
      
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") { dismiss() }
        }
        
        ToolbarItem(placement: .confirmationAction) {
          Button("Done") {
            // Filter the main list to only keep the checked items
            importantAlbums = allAlbums.filter { selectedAlbumIDs.contains($0.id) }
            dismiss()
          }
        }
      }
    }
  }
}
