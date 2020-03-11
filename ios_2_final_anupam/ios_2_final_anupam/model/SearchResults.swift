//
//  MovieInfo.swift
//  ios_2_final_anupam
//
//  Created by Anupam Poudel on 2020-02-16.
//  Copyright © 2020 Anupam Poudel. All rights reserved.
//

import Foundation

struct SearchResults: Codable {
    
    var kind: String?
    var collectionType: String?
    var collectionId: Int?
    var trackId: Int?
    var trackName: String?
    var collectionName: String?
    let trackCensoredName: String?
    var artworkUrl100: String
    var collectionPrice: Double?
    var price: Double?
    var releaseDate: String?
    var primaryGenreName: String?
    let contentAdvisoryRating: String?
    var shortDescription: String?
    var description: String?
    var averageUserRating: Double?
    var country: String?
    var version: String?
    
    //saving data to disk
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("favItems")
        .appendingPathExtension("plist")
    
    static func saveFav(_ favs: [SearchResults]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedFavs = try? propertyListEncoder.encode(favs)
        try? codedFavs?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
    //decoding saved data
    static func loadFavs() -> [SearchResults]? {
        guard let codedData = try? Data(contentsOf: ArchiveURL) else {return nil}
        
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<SearchResults>.self, from: codedData)
    }
}
