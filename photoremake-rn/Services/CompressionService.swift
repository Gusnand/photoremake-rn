//
//  CompressionService.swift
//  photoremake-rn
//
//  Created by Ketut Agus Cahyadi Nanda on 17/04/26.
//

import Foundation

enum CreateZipError: Swift.Error {
    case urlNotADirectory(URL)
    case failedToCreateZIP(Swift.Error)
}

func createZip(
    zipFinalURL: URL,
    fromDirectory directoryURL: URL
) throws -> URL {
    guard directoryURL.isDirectory else {
        throw CreateZipError.urlNotADirectory(directoryURL)
    }
    
    var fileManagerError: Swift.Error?
    var coordinatorError: NSError?
    let coordinator = NSFileCoordinator()
    
    coordinator.coordinate(
        readingItemAt: directoryURL,
        options: .forUploading,
        error: &coordinatorError
    ) { zipCreatedURL in
        do {
            try FileManager.default.moveItem(at: zipCreatedURL, to: zipFinalURL)
        } catch {
            fileManagerError = error
        }
    }
    
    if let error = coordinatorError ?? fileManagerError {
        throw CreateZipError.failedToCreateZIP(error)
    }
    return zipFinalURL
}

extension URL {
    var isDirectory: Bool {
       (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
}

// MARK: Simplifying ZIP directory composition

enum FileToZip {
    case data(Data, filename: String)
    case existingFile(URL)
    case renamedFile(URL, toFilename: String)
}

extension FileToZip {
    func prepareInDirectory(directoryURL: URL) throws {
        switch self {
        case .data(let data, filename: let filename):
            let fileURL = directoryURL.appendingPathComponent(filename)
            try data.write(to: fileURL)
        case .existingFile(let existingFileURL):
            let filename = existingFileURL.lastPathComponent
            let newFileURL = directoryURL.appendingPathComponent(filename)
            try FileManager.default.copyItem(at: existingFileURL, to: newFileURL)
        case .renamedFile(let existingFileURL, toFilename: let filename):
            let newFileURL = directoryURL.appendingPathComponent(filename)
            try FileManager.default.copyItem(at: existingFileURL, to: newFileURL)
        }
    }
}

func createZipAtTmp(
    zipFilename: String,
    zipExtension: String = "zip",
    filesToZip: [FileToZip]
) throws -> URL {
    // Uses a UUID to prevent possible naming collisions
    let directoryToZipURL = FileManager.default.temporaryDirectory
        .appending(path: UUID().uuidString)
        .appending(path: zipFilename)
    
    try FileManager.default.createDirectory(at: directoryToZipURL, withIntermediateDirectories: true, attributes: [:])
    
    for fileToZip in filesToZip {
        try fileToZip.prepareInDirectory(directoryURL: directoryToZipURL)
    }
    
    return try createZip(
        zipFinalURL: FileManager.default.temporaryDirectory.appending(path: "\(zipFilename).\(zipExtension)"),
        fromDirectory: directoryToZipURL
    )
}


