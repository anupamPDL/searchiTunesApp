//
//  SearchiTunes.swift
//  ios_2_final_anupam
//
//  Created by Anupam Poudel on 2020-02-20.
//  Copyright © 2020 Mobile Apps. All rights reserved.
//

import Foundation
struct SearchiTunes: Codable {
    var resultCount: Int?
    var results: [SearchResults]
}
