//
//  URLHelper.swift
//  ios_2_final_anupam
//
//  Created by Anupam Poudel on 2020-02-17.
//  Copyright © 2020 Anupam Poudel. All rights reserved.
//

import Foundation

let MOVIE_URL = "https://itunes.apple.com/search?entity=movie&attribute=albumTerm&offset=0&limit=100&term="
let BOOK_URL = "https://itunes.apple.com/search?entity=ebook&attribute=&offset=0&limit=100&term="
let APP_URL = "https://itunes.apple.com/search?entity=software&attribute=&offset=0&limit=100&term="
let ALBUM_URL = "https://itunes.apple.com/search?entity=album&attribute=albumTerm&offset=0&limit=100&term="
//Don't forget to remove YOUR_API_HERE and add your own api key.
let TOP_MOVIES = "https://api.themoviedb.org/3/movie/top_rated?api_key=YOUR_API_HERE&language=en-US&page=1"

class URLHelper {
    
    static let instance = URLHelper()
    
    //this function gets the movies
    func getMovies (searchRequest: String, complition: @escaping (SearchiTunes?)-> Void) {
        
        let searchString = searchRequest.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "\(MOVIE_URL)\(searchString)")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data,
                let moviesDecoded = try? decoder.decode(SearchiTunes.self, from: data){
                complition(moviesDecoded)
            }
            else {
                print("No data retrieved")
                complition(nil)
                return
            }
        }
        task.resume()
    }
    
    //this function gets the album
    func getAlbums (searchRequest: String, complition: @escaping (SearchiTunes?)-> Void) {
        let searchString = searchRequest.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "\(ALBUM_URL)\(searchString)")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data,
                let albumsDecoded = try? decoder.decode(SearchiTunes.self, from: data){
                complition(albumsDecoded)
            }
            else {
                print("No data retrieved")
                complition(nil)
                return
            }
        }
        task.resume()
    }
    
    //this function gets the apps
    func getApps (searchRequest: String, complition: @escaping (SearchiTunes?)-> Void) {
      let searchString = searchRequest.replacingOccurrences(of: " ", with: "+")
             let url = URL(string: "\(APP_URL)\(searchString)")
             let session = URLSession.shared
             let task = session.dataTask(with: url!) { (data, response, error) in
                 let decoder = JSONDecoder()
                 if let data = data,
                     let appsDecoded = try? decoder.decode(SearchiTunes.self, from: data){
                     complition(appsDecoded)
                 }
                 else {
                     print("No data retrieved for apps")
                     complition(nil)
                     return
                 }
             }
             task.resume()
    }
    
    //this function gets the ebooks
    func getEbooks (searchRequest: String, complition: @escaping (SearchiTunes?) -> Void) {
     let searchString = searchRequest.replacingOccurrences(of: " ", with: "+")
                 let url = URL(string: "\(BOOK_URL)\(searchString)")
                 let session = URLSession.shared
                 let task = session.dataTask(with: url!) { (data, response, error) in
                     let decoder = JSONDecoder()
                     if let data = data,
                         let booksDecoded = try? decoder.decode(SearchiTunes.self, from: data){
                         complition(booksDecoded)
                     }
                     else {
                         print("No data retrieved for apps")
                         complition(nil)
                         return
                     }
                 }
                 task.resume()
    }
    
    //this function gets the top movies at the beginning: ADDITIONAL FEATURE
    func getTopMovies(completion: @escaping (TopMovies?) -> Void) {
        
        let url = URL(string: TOP_MOVIES)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) {(data, response, error) in
            let decoder = JSONDecoder()
            if let data = data,
                let topMoviesDecoded = try? decoder.decode(TopMovies.self, from: data) {
                completion(topMoviesDecoded)
            }
            else{
                print("no data retrived")
                completion(nil)
            }
        }
    task.resume()
    }
}
