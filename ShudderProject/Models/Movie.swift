//
//  Movie.swift
//  ShudderProject
//
//  Created by Duy Pham on 11/29/18.
//  Copyright © 2018 Duy Khac. All rights reserved.
//

import Foundation

class Movie: Decodable {
    var id: Int?
    var title: String?
    var imageUrl: String?
    var overview: String?
    
    private enum CodingKeys : String, CodingKey {
        case id = "id"
        case title = "title"
        case imageUrl = "poster_path"
        case overview = "overview"
    }
}
