//
//  TopMovies.swift
//  ios_2_final_anupam
//
//  Created by Anupam Poudel on 2020-02-22.
//  Copyright © 2020 Mobile Apps. All rights reserved.
//

import Foundation

struct TopMovies: Codable{
    var results: [Results]?
}

struct Results: Codable {
    var title: String?
    var poster_path: String?
    var id: Int?
    var vote_average: Double?
    var release_date: String?
}
