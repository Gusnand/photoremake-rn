import SwiftUI
import Photos

@Observable

class LibraryViewModel {
  var Photos: [PHAsset] = []
  
  func deleteSelectedPhotos (_ selectedPhotos: [PHAsset]) {
    PhotoLibraryManager.shared.deleteAssets(selectedPhotos) { success, error in
      if success {
        self.Photos.removeAll(where: {selectedPhotos.contains($0) })
      } else {
        print ("Failed to delete: \(error?.localizedDescription ?? "")")
      }
    }
  }
}
