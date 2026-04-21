import Photos

class PhotoLibraryManager {
  static let shared = PhotoLibraryManager()
  
  func deleteAssets (_ assets: [PHAsset], completion: @escaping (Bool, Error?) -> Void) {
    PHPhotoLibrary.shared().performChanges ({
      PHAssetChangeRequest.deleteAssets(assets as NSArray)
    }) { success, error in
      DispatchQueue.main.async {
        completion(success, error)
      }
    }
  }
}


