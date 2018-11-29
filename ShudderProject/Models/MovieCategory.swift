//
//  MovieCategory.swift
//  ShudderProject
//
//  Created by Duy Pham on 11/29/18.
//  Copyright © 2018 Duy Khac. All rights reserved.
//

import Foundation

struct MovieCategory: Decodable {
    let name: String
    var movies: [Movie]?
    var type: String
    
    static func fetchFeaturedMovies(_ completionHandler: @escaping (FeaturedMovies) -> ()) {
        guard let jsonPath = Bundle.main.path(forResource: "movies", ofType: "json") else { return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: jsonPath))
            let featuredMovies = try JSONDecoder().decode(FeaturedMovies.self, from: data)
            DispatchQueue.main.async {
                completionHandler(featuredMovies)
            }
        } catch let error {
            print(error)
        }
//            let apiKey = "509a8e665b1617b163b06d6c281400fb"
//            if let id = movie?.id {
//                let urlString = "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=en-US"
//                URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) -> Void in
//
//                    if error != nil {
//                        print(error ?? "")
//                        return
//                    }
//
//                    do {
//                        guard let data = data else { return }
//                        let movieDetail = try JSONDecoder().decode(Movie.self, from: data)
//                        self.movie = movieDetail
//
//                        DispatchQueue.main.async(execute: { () -> Void in
//                            self.collectionView?.reloadData()
//                        })
//
//                    } catch let err {
//                        print(err)
//                    }
//                }).resume()
//            }
    }
}
