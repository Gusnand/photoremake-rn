import Foundation

//// model for ALBUMS
//struct ImportantAlbum: Identifiable {
//  let id = UUID()
//  let order: Int
//  var title: String
//  
//  var photos: [ImageDetail]
//  
//  var count: Int {
//    return photos.count
//  }
//  var coverPhoto: ImageDetail? {
//    return photos.first
//  }
//  
//#if DEBUG
//  static let mockData: [ImportantAlbum] = [
//    // "Favorites" gets just the first 15 photos
//    ImportantAlbum(order: 1, title: "Favorites", photos: Array(ImageDetail.gallery.prefix(15))),
//    
//    // "Selfies" gets the last 8 photos
//    ImportantAlbum(order: 2, title: "Camera", photos: Array(ImageDetail.gallery.suffix(8))),
//    
//    // "Live Photos" skips the first 10, then grabs the next 20
//    ImportantAlbum(order: 3, title: "Videos", photos: Array(ImageDetail.gallery.dropFirst(10).prefix(20))),
//    
//    // "Portrait" gets the first 5 photos
//    ImportantAlbum(order: 4, title: "Airdrop", photos: Array(ImageDetail.gallery.prefix(5))),
//    
//    // "Panoramas" gets just the last 2 photos
//    ImportantAlbum(order: 5, title: "Lightroom", photos: Array(ImageDetail.gallery.suffix(2)))
//  ]
//#endif
//}

struct AllAlbums: Identifiable {
  let id = UUID()
  let order: Int
  var title: String
  
  var photos: [ImageDetail]
  
  var count: Int {
    return photos.count
  }
  var coverPhoto: ImageDetail? {
    return photos.first
  }
  
#if DEBUG
  static let mockDataAllAlbums: [AllAlbums] = [
    // "Favorites" gets just the first 15 photos
    AllAlbums(order: 1, title: "Favorites", photos: Array(ImageDetail.gallery.prefix(15))),
    
    // "Selfies" gets the last 8 photos
    AllAlbums(order: 2, title: "Camera", photos: Array(ImageDetail.gallery.suffix(8))),
    
    // "Live Photos" skips the first 10, then grabs the next 20
    AllAlbums(order: 3, title: "Videos", photos: Array(ImageDetail.gallery.dropFirst(10).prefix(20))),
    
    // "Portrait" gets the first 5 photos
    AllAlbums(order: 4, title: "Airdrop", photos: Array(ImageDetail.gallery.prefix(5))),
    
    // "Panoramas" gets just the last 2 photos
    AllAlbums(order: 5, title: "Lightroom", photos: Array(ImageDetail.gallery.suffix(2))),
    
    AllAlbums(order: 6, title: "Screenshots", photos: Array(ImageDetail.gallery.prefix(35))),
    
    AllAlbums(order: 7, title: "Downloads", photos: Array(ImageDetail.gallery.suffix(15))),
    
    AllAlbums(order: 8, title: "Screen Recording", photos: Array(ImageDetail.gallery.suffix(35))),
    
    AllAlbums(order: 9, title: "Whatsapp", photos: Array(ImageDetail.gallery.suffix(50))),
  ]
  
  static let mockDataImportantAlbums: [AllAlbums] = [
    AllAlbums(order: 1, title: "Favorites", photos: Array(ImageDetail.gallery.prefix(15))),
    AllAlbums(order: 2, title: "Camera", photos: Array(ImageDetail.gallery.suffix(15))),
    AllAlbums(order: 3, title: "Airdrop", photos: Array(ImageDetail.gallery.prefix(5))),
    AllAlbums(order: 4, title: "Lightroom", photos: Array(ImageDetail.gallery.suffix(9))),
    AllAlbums(order: 5, title: "Screenshots", photos: Array(ImageDetail.gallery.suffix(50))),
  ]
#endif
}

//struct Album: Identifiable {
//  let id = UUID()
//  var title: String
//  var count: Int
//  
//#if DEBUG
//  static let mockData: [Album] = [
//    Album(title: "Bali Vacation 2023", count: 450),
//    Album(title: "Family", count: 1205),
//    Album(title: "Pets", count: 834),
//    Album(title: "Memes", count: 152),
//    Album(title: "Food & Recipes", count: 89),
//    Album(title: "Travel Ideas", count: 24),
//    Album(title: "Work Receipts", count: 67),
//    Album(title: "Christmas 2022", count: 120),
//    Album(title: "Halloween Outfits", count: 35),
//    Album(title: "Concerts", count: 210),
//    Album(title: "Cross Country Road Trip", count: 642),
//    Album(title: "Sarah's Wedding", count: 315),
//    Album(title: "New York Trip", count: 288),
//    Album(title: "Tokyo Adventures", count: 531),
//    Album(title: "Summer 2021", count: 412),
//    Album(title: "Ski Trip", count: 145),
//    Album(title: "Nature & Landscapes", count: 390),
//    Album(title: "Art References", count: 76),
//    Album(title: "Apartment Hunting", count: 43),
//    Album(title: "Fitness Progress", count: 28),
//    Album(title: "Funny Screenshots", count: 504),
//    Album(title: "Birthdays", count: 198),
//    Album(title: "Camping in Yosemite", count: 260),
//    Album(title: "Car Project", count: 112),
//    Album(title: "College Memories", count: 875),
//    Album(title: "Random / Misc", count: 45)
//  ]
//#endif
//}

// end of model for ALBUMS


// model for each images

struct GeoLocation: Hashable, Equatable {
  var longitude: Double
  var latitude: Double
}

struct Resolution: Hashable, Equatable {
  var width: Double
  var height: Double
}

struct ImageDetail: Identifiable, Hashable, Equatable {
  let id = UUID()
  var filename: String
  var caption: String
  let dateTimePictureTaken: Date
  var sizeInMegabytes: Float
  let device: String
  let geolocation: GeoLocation
  var resolution: Resolution
  var fileType: String
  var fileLocation: String
  
#if DEBUG
  static let gallery: [ImageDetail] = [
    ImageDetail(filename: "photo_1", caption: "Golden hour at the coast", dateTimePictureTaken: Date(timeIntervalSince1970: 1713715200), sizeInMegabytes: 6.7, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: 5.438473, latitude: -6.748393), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/coast"),
    ImageDetail(filename: "photo_2", caption: "Mist over the redwoods", dateTimePictureTaken: Date(timeIntervalSince1970: 1713801600), sizeInMegabytes: 5.2, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -124.0046, latitude: 41.2132), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/nature"),
    ImageDetail(filename: "photo_3", caption: "Tokyo neon nights", dateTimePictureTaken: Date(timeIntervalSince1970: 1713888000), sizeInMegabytes: 8.1, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: 139.6503, latitude: 35.6762), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/urban"),
    ImageDetail(filename: "photo_4", caption: "Morning coffee in Rome", dateTimePictureTaken: Date(timeIntervalSince1970: 1713974400), sizeInMegabytes: 4.9, device: "iPhone 14 Pro", geolocation: GeoLocation(longitude: 12.4964, latitude: 41.9028), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/travel"),
    ImageDetail(filename: "photo_5", caption: "Deep blue crater lake", dateTimePictureTaken: Date(timeIntervalSince1970: 1714060800), sizeInMegabytes: 7.3, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -122.1090, latitude: 42.9446), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/nature"),
    ImageDetail(filename: "photo_6", caption: "Alps from the cabin", dateTimePictureTaken: Date(timeIntervalSince1970: 1714147200), sizeInMegabytes: 6.4, device: "iPhone 13 mini", geolocation: GeoLocation(longitude: 10.4515, latitude: 46.5581), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/nature"),
    ImageDetail(filename: "photo_7", caption: "Cyberpunk street vibes", dateTimePictureTaken: Date(timeIntervalSince1970: 1714233600), sizeInMegabytes: 9.2, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: 126.9780, latitude: 37.5665), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/urban"),
    ImageDetail(filename: "photo_8", caption: "Static at the beach", dateTimePictureTaken: Date(timeIntervalSince1970: 1714320000), sizeInMegabytes: 5.8, device: "iPhone 14 Pro", geolocation: GeoLocation(longitude: 144.9631, latitude: -37.8136), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/coast"),
    ImageDetail(filename: "photo_9", caption: "Market colors in Morocco", dateTimePictureTaken: Date(timeIntervalSince1970: 1714406400), sizeInMegabytes: 7.5, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -7.9811, latitude: 31.6295), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/travel"),
    ImageDetail(filename: "photo_10", caption: "Snowy peak sunrise", dateTimePictureTaken: Date(timeIntervalSince1970: 1714492800), sizeInMegabytes: 6.1, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -110.5885, latitude: 43.7410), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/nature"),
    ImageDetail(filename: "photo_11", caption: "The long road home", dateTimePictureTaken: Date(timeIntervalSince1970: 1714579200), sizeInMegabytes: 4.4, device: "iPhone 12", geolocation: GeoLocation(longitude: -117.1611, latitude: 32.7157), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/urban"),
    ImageDetail(filename: "photo_12", caption: "Waterfall long exposure", dateTimePictureTaken: Date(timeIntervalSince1970: 1714665600), sizeInMegabytes: 11.2, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -19.0670, latitude: 63.5320), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/nature"),
    ImageDetail(filename: "photo_13", caption: "Desert dunes at night", dateTimePictureTaken: Date(timeIntervalSince1970: 1714752000), sizeInMegabytes: 5.9, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: 54.3667, latitude: 24.4667), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/nature"),
    ImageDetail(filename: "photo_14", caption: "Rainy window pane", dateTimePictureTaken: Date(timeIntervalSince1970: 1714838400), sizeInMegabytes: 3.8, device: "iPhone 13 Pro", geolocation: GeoLocation(longitude: -0.1278, latitude: 51.5074), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/urban"),
    ImageDetail(filename: "photo_15", caption: "Old town cobblestones", dateTimePictureTaken: Date(timeIntervalSince1970: 1714924800), sizeInMegabytes: 6.9, device: "iPhone 14 Pro", geolocation: GeoLocation(longitude: 2.3522, latitude: 48.8566), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/urban"),
    ImageDetail(filename: "photo_16", caption: "Palm trees and breeze", dateTimePictureTaken: Date(timeIntervalSince1970: 1715011200), sizeInMegabytes: 5.5, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -157.8583, latitude: 21.3069), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/coast"),
    ImageDetail(filename: "photo_17", caption: "Macro forest floor", dateTimePictureTaken: Date(timeIntervalSince1970: 1715097600), sizeInMegabytes: 7.8, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -123.1207, latitude: 49.2827), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/nature"),
    ImageDetail(filename: "photo_18", caption: "Brooklyn Bridge dusk", dateTimePictureTaken: Date(timeIntervalSince1970: 1715184000), sizeInMegabytes: 8.4, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -73.9967, latitude: 40.7061), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/urban"),
    ImageDetail(filename: "photo_19", caption: "Green tea fields", dateTimePictureTaken: Date(timeIntervalSince1970: 1715270400), sizeInMegabytes: 6.2, device: "iPhone 14 Pro", geolocation: GeoLocation(longitude: 138.7278, latitude: 35.3606), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/nature"),
    ImageDetail(filename: "photo_20", caption: "Grand Canal gondola", dateTimePictureTaken: Date(timeIntervalSince1970: 1715356800), sizeInMegabytes: 7.1, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: 12.3327, latitude: 45.4371), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/travel"),
    ImageDetail(filename: "photo_21", caption: "Modern architecture line", dateTimePictureTaken: Date(timeIntervalSince1970: 1715443200), sizeInMegabytes: 4.7, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -3.7038, latitude: 40.4168), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/urban"),
    ImageDetail(filename: "photo_22", caption: "Salt flats reflection", dateTimePictureTaken: Date(timeIntervalSince1970: 1715529600), sizeInMegabytes: 5.3, device: "iPhone 13 Pro", geolocation: GeoLocation(longitude: -67.4891, latitude: -20.1338), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/travel"),
    ImageDetail(filename: "photo_23", caption: "Cozy coffee shop nook", dateTimePictureTaken: Date(timeIntervalSince1970: 1715616000), sizeInMegabytes: 4.1, device: "iPhone 14 Pro", geolocation: GeoLocation(longitude: 18.0686, latitude: 59.3293), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/urban"),
    ImageDetail(filename: "photo_24", caption: "Foggy harbor morning", dateTimePictureTaken: Date(timeIntervalSince1970: 1715702400), sizeInMegabytes: 6.6, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -63.5724, latitude: 44.6488), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/coast"),
    ImageDetail(filename: "photo_25", caption: "Highlands sheep", dateTimePictureTaken: Date(timeIntervalSince1970: 1715788800), sizeInMegabytes: 5.7, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -4.2247, latitude: 57.4778), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/nature"),
    ImageDetail(filename: "photo_26", caption: "Santorini blue dome", dateTimePictureTaken: Date(timeIntervalSince1970: 1715875200), sizeInMegabytes: 7.9, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: 25.3788, latitude: 36.4618), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/travel"),
    ImageDetail(filename: "photo_27", caption: "Red canyon layers", dateTimePictureTaken: Date(timeIntervalSince1970: 1715961600), sizeInMegabytes: 8.8, device: "iPhone 14 Pro", geolocation: GeoLocation(longitude: -112.1130, latitude: 36.0544), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/nature"),
    ImageDetail(filename: "photo_28", caption: "Subway motion blur", dateTimePictureTaken: Date(timeIntervalSince1970: 1716048000), sizeInMegabytes: 6.3, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -74.0060, latitude: 40.7128), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/urban"),
    ImageDetail(filename: "photo_29", caption: "Cliffs of Moher", dateTimePictureTaken: Date(timeIntervalSince1970: 1716134400), sizeInMegabytes: 7.4, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -9.4289, latitude: 52.9719), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/coast"),
    ImageDetail(filename: "photo_30", caption: "Cherry blossoms in Kyoto", dateTimePictureTaken: Date(timeIntervalSince1970: 1716220800), sizeInMegabytes: 6.8, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: 135.7681, latitude: 35.0116), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/travel"),
    ImageDetail(filename: "photo_31", caption: "Icelandic black sand", dateTimePictureTaken: Date(timeIntervalSince1970: 1716307200), sizeInMegabytes: 7.2, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -19.0124, latitude: 63.4186), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/coast"),
    ImageDetail(filename: "photo_32", caption: "City park picnic", dateTimePictureTaken: Date(timeIntervalSince1970: 1716393600), sizeInMegabytes: 5.1, device: "iPhone 14 Pro", geolocation: GeoLocation(longitude: 13.4050, latitude: 52.5200), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/urban"),
    ImageDetail(filename: "photo_33", caption: "Golden Gate from afar", dateTimePictureTaken: Date(timeIntervalSince1970: 1716480000), sizeInMegabytes: 6.5, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -122.4783, latitude: 37.8199), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/coast"),
    ImageDetail(filename: "photo_34", caption: "Boreal forest drone", dateTimePictureTaken: Date(timeIntervalSince1970: 1716566400), sizeInMegabytes: 9.7, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: 24.9384, latitude: 60.1699), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/nature"),
    ImageDetail(filename: "photo_35", caption: "Lisbon yellow tram", dateTimePictureTaken: Date(timeIntervalSince1970: 1716652800), sizeInMegabytes: 5.6, device: "iPhone 13 mini", geolocation: GeoLocation(longitude: -9.1393, latitude: 38.7223), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/travel"),
    ImageDetail(filename: "photo_36", caption: "Starry desert sky", dateTimePictureTaken: Date(timeIntervalSince1970: 1716739200), sizeInMegabytes: 12.4, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -116.4849, latitude: 33.6493), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/nature"),
    ImageDetail(filename: "photo_37", caption: "Graffiti alley way", dateTimePictureTaken: Date(timeIntervalSince1970: 1716825600), sizeInMegabytes: 4.8, device: "iPhone 14 Pro", geolocation: GeoLocation(longitude: 144.9631, latitude: -37.8136), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/urban"),
    ImageDetail(filename: "photo_38", caption: "Emerald lake kayak", dateTimePictureTaken: Date(timeIntervalSince1970: 1716912000), sizeInMegabytes: 7.0, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -116.5365, latitude: 51.4172), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/nature"),
    ImageDetail(filename: "photo_39", caption: "Sydney Opera house sun", dateTimePictureTaken: Date(timeIntervalSince1970: 1716998400), sizeInMegabytes: 6.9, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: 151.2153, latitude: -33.8568), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/coast"),
    ImageDetail(filename: "photo_40", caption: "Midnight in Paris", dateTimePictureTaken: Date(timeIntervalSince1970: 1717084800), sizeInMegabytes: 8.3, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: 2.3522, latitude: 48.8566), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/urban"),
    ImageDetail(filename: "photo_41", caption: "Northern lights flash", dateTimePictureTaken: Date(timeIntervalSince1970: 1717171200), sizeInMegabytes: 10.1, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: 18.0649, latitude: 69.6492), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/nature"),
    ImageDetail(filename: "photo_42", caption: "Street cat of Istanbul", dateTimePictureTaken: Date(timeIntervalSince1970: 1717257600), sizeInMegabytes: 5.4, device: "iPhone 13 Pro", geolocation: GeoLocation(longitude: 28.9784, latitude: 41.0082), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/travel"),
    ImageDetail(filename: "photo_43", caption: "Vibrant coral reef", dateTimePictureTaken: Date(timeIntervalSince1970: 1717344000), sizeInMegabytes: 7.7, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: 142.5896, latitude: -18.2871), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/coast"),
    ImageDetail(filename: "photo_44", caption: "Rainforest canopy", dateTimePictureTaken: Date(timeIntervalSince1970: 1717430400), sizeInMegabytes: 8.6, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -60.0217, latitude: -3.1190), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/nature"),
    ImageDetail(filename: "photo_45", caption: "Glass skyscrapers", dateTimePictureTaken: Date(timeIntervalSince1970: 1717516800), sizeInMegabytes: 6.2, device: "iPhone 14 Pro", geolocation: GeoLocation(longitude: -122.3321, latitude: 47.6062), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/urban"),
    ImageDetail(filename: "photo_46", caption: "Stonehenge at dusk", dateTimePictureTaken: Date(timeIntervalSince1970: 1717603200), sizeInMegabytes: 7.3, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -1.8262, latitude: 51.1789), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/travel"),
    ImageDetail(filename: "photo_47", caption: "Surfer at dawn", dateTimePictureTaken: Date(timeIntervalSince1970: 1717689600), sizeInMegabytes: 5.9, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -117.2713, latitude: 32.8328), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/coast"),
    ImageDetail(filename: "photo_48", caption: "Tulip fields endless", dateTimePictureTaken: Date(timeIntervalSince1970: 1717776000), sizeInMegabytes: 9.0, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: 4.5463, latitude: 52.2701), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/nature"),
    ImageDetail(filename: "photo_49", caption: "Mountain road curves", dateTimePictureTaken: Date(timeIntervalSince1970: 1717862400), sizeInMegabytes: 6.4, device: "iPhone 14 Pro", geolocation: GeoLocation(longitude: 103.8198, latitude: 1.3521), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/travel"),
    ImageDetail(filename: "photo_50", caption: "London Eye bright", dateTimePictureTaken: Date(timeIntervalSince1970: 1717948800), sizeInMegabytes: 5.7, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -0.1195, latitude: 51.5033), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/urban"),
    ImageDetail(filename: "photo_51", caption: "Sahara camel trek", dateTimePictureTaken: Date(timeIntervalSince1970: 1718035200), sizeInMegabytes: 7.5, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: 9.3885, latitude: 33.5011), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/travel"),
    ImageDetail(filename: "photo_52", caption: "Pier at midnight", dateTimePictureTaken: Date(timeIntervalSince1970: 1718121600), sizeInMegabytes: 8.1, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -118.4960, latitude: 34.0101), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/coast"),
    ImageDetail(filename: "photo_53", caption: "Autumn leaves path", dateTimePictureTaken: Date(timeIntervalSince1970: 1718208000), sizeInMegabytes: 9.3, device: "iPhone 13 Pro", geolocation: GeoLocation(longitude: -71.3085, latitude: 44.2701), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/nature"),
    ImageDetail(filename: "photo_54", caption: "New York yellow cab", dateTimePictureTaken: Date(timeIntervalSince1970: 1718294400), sizeInMegabytes: 5.5, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -73.9857, latitude: 40.7484), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/urban"),
    ImageDetail(filename: "photo_55", caption: "Lighthouse beam", dateTimePictureTaken: Date(timeIntervalSince1970: 1718380800), sizeInMegabytes: 6.8, device: "iPhone 14 Pro", geolocation: GeoLocation(longitude: -6.2603, latitude: 53.3498), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/coast"),
    ImageDetail(filename: "photo_56", caption: "Zen garden stones", dateTimePictureTaken: Date(timeIntervalSince1970: 1718467200), sizeInMegabytes: 4.3, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: 135.7727, latitude: 35.0033), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/travel"),
    ImageDetail(filename: "photo_57", caption: "Lavender fields haze", dateTimePictureTaken: Date(timeIntervalSince1970: 1718553600), sizeInMegabytes: 8.7, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: 5.3669, latitude: 43.9336), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/nature"),
    ImageDetail(filename: "photo_58", caption: "Cinque Terre vista", dateTimePictureTaken: Date(timeIntervalSince1970: 1718640000), sizeInMegabytes: 7.6, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: 9.7328, latitude: 44.1025), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/travel"),
    ImageDetail(filename: "photo_59", caption: "Golden gate fog", dateTimePictureTaken: Date(timeIntervalSince1970: 1718726400), sizeInMegabytes: 6.0, device: "iPhone 15 Pro Max", geolocation: GeoLocation(longitude: -122.4783, latitude: 37.8199), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/coast"),
    ImageDetail(filename: "photo_60", caption: "Library stacks silence", dateTimePictureTaken: Date(timeIntervalSince1970: 1718812800), sizeInMegabytes: 4.5, device: "iPhone 12 Pro", geolocation: GeoLocation(longitude: -0.1276, latitude: 51.5072), resolution: Resolution(width: 4032, height: 3024), fileType: "heic", fileLocation: "hackintosh/hd/lib/photos/urban")
  ]
#endif
}

// end of model for each images
