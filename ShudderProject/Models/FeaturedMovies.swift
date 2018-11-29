//
//  FeaturedMovies.swift
//  ShudderProject
//
//  Created by Duy Pham on 11/29/18.
//  Copyright © 2018 Duy Khac. All rights reserved.
//

import Foundation

class FeaturedMovies: Decodable {
    let bannerCategory: MovieCategory?
    var moviesCategories: [MovieCategory]?
    
    private enum CodingKeys : String, CodingKey {
        case moviesCategories = "categories"
        case bannerCategory
    }
}
