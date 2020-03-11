//
//  MyCustomCellVC.swift
//  ios_2_final_anupam
//
//  Created by Anupam Poudel on 2020-02-14.
//  Copyright © 2020 Anupam Poudel. All rights reserved.
//

import UIKit

class MyCustomCellVC: UITableViewCell {
    
    @IBOutlet weak var imageForItem: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateAndCountry: UILabel!
    
    func updateCell(with artistInfo : SearchResults){
        
        self.imageForItem.layer.cornerRadius = 5
        imageForItem.clipsToBounds = true
        
        let imageURL = URL(string: artistInfo.artworkUrl100)
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageURL!){
                DispatchQueue.main.async {
                    self.imageForItem.image = UIImage(data: imageData)
                }
            }
        }
        titleLabel.text = artistInfo.collectionName
        nameLabel.text = artistInfo.collectionName
        let releaseDateFormatted = artistInfo.releaseDate!.prefix(4)
        releaseDateAndCountry.text = "Released on: \(releaseDateFormatted) | \(artistInfo.country ?? "n/a")"
        
    }
    
    func updateCellForMovies(with movieInfo : SearchResults){
        
        self.imageForItem.layer.cornerRadius = 5
        imageForItem.clipsToBounds = true
        
        let imageURL = URL(string: movieInfo.artworkUrl100)
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageURL!){
                DispatchQueue.main.async {
                    self.imageForItem.image = UIImage(data: imageData)
                }
            }
        }
        titleLabel.text = movieInfo.trackName
        nameLabel.text = movieInfo.contentAdvisoryRating
        let releaseDateFormatted = movieInfo.releaseDate!.prefix(4)
        releaseDateAndCountry.text = "Released on: \(releaseDateFormatted) | $\(movieInfo.collectionPrice!) "
        
    }
    
    func updateCellForApps(with appInfo : SearchResults){
        
        self.imageForItem.layer.cornerRadius = 5
        imageForItem.clipsToBounds = true
        
        let imageURL = URL(string: appInfo.artworkUrl100)
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageURL!){
                DispatchQueue.main.async {
                    self.imageForItem.image = UIImage(data: imageData)
                }
            }
        }
        titleLabel.text = appInfo.trackName
        nameLabel.text = "Rated: \(appInfo.averageUserRating ?? 0)"
        
        releaseDateAndCountry.text = "Version: \(appInfo.version ?? "na")"
        
    }
    
    func updateCellForEbooks(with bookInfo : SearchResults){
        
        self.imageForItem.layer.cornerRadius = 5
        imageForItem.clipsToBounds = true
        
        let imageURL = URL(string: bookInfo.artworkUrl100)
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageURL!){
                DispatchQueue.main.async {
                    self.imageForItem.image = UIImage(data: imageData)
                }
            }
        }
        titleLabel.text = bookInfo.trackCensoredName
        nameLabel.text = bookInfo.collectionName
        releaseDateAndCountry.text = "Released on: \(bookInfo.releaseDate!.prefix(4))"
        
    }
}
