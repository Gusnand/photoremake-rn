import SwiftUI

struct ImageInfoSheet: View {
  @Binding var image: ImageDetail
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        // 1. For Caption Field
        VStack {
          TextField("Add a caption", text: $image.caption)
            .padding().background(Color(UIColor.secondarySystemBackground)).cornerRadius(12)
        }.padding(.horizontal)
        
        // 2. For Date File Details
        VStack(alignment: .leading, spacing: 4) {
          Text(image.dateTimePictureTaken.formatted(date: .complete, time: .shortened))
            .font(.headline).fontWeight(.semibold)
          
          HStack {
            Image(systemName: "cloud")
            Text(image.filename)
          }.font(.subheadline).foregroundColor(.secondary)
        }.padding(.horizontal)
        
        VStack (alignment: .leading, spacing: 8) {
          HStack {
            Image(systemName: "iphone")
            Text(image.device).fontWeight(.semibold)
            Spacer()
            Text(image.fileType.uppercased()).font(.caption).fontWeight(.bold).padding(.horizontal, 6).padding(.vertical, 2).background(Color.gray.opacity(0.3)).cornerRadius(4)
          }
          Text("\(String(format: "%.0f", image.resolution.width)) x \(String(format: "%.0f", image.resolution.height)) • \(String(format: "%.1f", image.sizeInMegabytes)) MB")
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .padding(.horizontal)
      }
      .padding(.top, 24)
    }
    // iOS 16+ Native Sheet Modifiers
    .presentationDetents([.medium, .large])
    .presentationDragIndicator(.visible)
    .presentationBackground(.thickMaterial) // Gives it that native blurred glass look!
  }
}
