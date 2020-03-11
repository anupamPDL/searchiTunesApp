//
//  DetailsVC.swift
//  ios_2_final_anupam
//
//  Created by Anupam Poudel on 2020-02-14.
//  Copyright © 2020 Anupam Poudel. All rights reserved.
//

import UIKit

class DetailsVC: UITableViewController {
    
    var mySearchResultItemDetails: SearchResults?
    var saveMyFavArr = [SearchResults]()
    
    var idFromOneData = 0
    var idFromDb = 0
    var trackIdFromOneData = 0
    var trackIdFromDb = 0
    
    var btnTapped = false
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var favIndicatorLbl: UILabel!
    
    @IBOutlet weak var kindLbl: UILabel!
    @IBOutlet weak var collectionTypeLbl: UILabel!
    @IBOutlet weak var collectionIdLbl: UILabel!
    @IBOutlet weak var trackNameLbl: UILabel!
    @IBOutlet weak var collectioNameLbl: UILabel!
    @IBOutlet weak var trackCensoredNameLbl: UILabel!
    @IBOutlet weak var collectionPriceLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var primaryGenreNameLbl: UILabel!
    @IBOutlet weak var contentAdvisoryRatingLbl: UILabel!
    @IBOutlet weak var averageUserRatingLbl: UILabel!
    @IBOutlet weak var versionLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFromDBToFav()
        loadFromUrlToDisplay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func loadFromUrlToDisplay(){
        if let oneData = mySearchResultItemDetails {
            
            let imageURL = URL(string: oneData.artworkUrl100)
            
            DispatchQueue.global().async {
                if let imageDATA = try? Data(contentsOf: imageURL!){
                    DispatchQueue.main.async {
                        self.itemImage.image = UIImage(data: imageDATA)
                    }
                }
            }
            self.trackIdFromOneData = oneData.trackId ?? 0
            self.idFromOneData = oneData.collectionId ?? 0
            self.saveMyFavArr.append(oneData)
            
            kindLbl.text = "Kind: \(oneData.kind?.capitalized ?? "n/a")"
            collectionTypeLbl.text = "Type: \(oneData.collectionType ?? "n/a")"
            collectionIdLbl.text = "Id: \(oneData.collectionId ?? 0)"
            trackNameLbl.text = "Name: \(oneData.trackName ?? "n/a")"
            collectioNameLbl.text = "Collection Name: \(oneData.collectionName ?? "n/a")"
            trackCensoredNameLbl.text = "Censored Name: \(oneData.trackCensoredName ?? "n/a")"
            collectionPriceLbl.text = "Collection Price: \(oneData.collectionPrice ?? 0.0)"
            priceLbl.text = "Price: \(oneData.price ?? 0.0)"
            releaseDateLbl.text = "Release Date: \(oneData.releaseDate ?? "n/a")"
            primaryGenreNameLbl.text = "Genre: \(oneData.primaryGenreName ?? "n/a")"
            contentAdvisoryRatingLbl.text = "Rated: \(oneData.contentAdvisoryRating ?? "n/a")"
            averageUserRatingLbl.text = "User Rating: \(oneData.averageUserRating ?? 0.0)"
            versionLbl.text = "Version: \(oneData.version ?? "n/a")"
            countryLbl.text = "Country: \(oneData.country ?? "n/a")"
            descriptionLbl.text = "Description: \(oneData.shortDescription ?? "") \(oneData.description ?? "")"
            
            self.tableView.reloadData()
        }
    }
    
    func loadFromDBToFav(){
        if let savedFavItems = SearchResults.loadFavs() {
            saveMyFavArr = savedFavItems
            
            for id in savedFavItems {
                idFromDb = id.collectionId ?? 0
                trackIdFromDb = id.trackId ?? 0
            }
            
        }
    }
    
    @IBAction func favBtnPressed(_ sender: UIButton){
        
        if favBtn.isTouchInside {
            if btnTapped {
                favIndicatorLbl.text = "Not Liked"
                favIndicatorLbl.textColor = UIColor.gray
                btnTapped = false
                
            } else {
                favIndicatorLbl.text = "Liked!"
                favIndicatorLbl.textColor = UIColor.red
                btnTapped = true
                
                if idFromOneData != idFromDb || trackIdFromOneData != trackIdFromDb {
                    SearchResults.saveFav(saveMyFavArr)
                }else{
                    alertUser()
                    favIndicatorLbl.text = "Already Liked"
                    favIndicatorLbl.textColor = UIColor.gray
                }
            }
        }
    }
    
    func alertUser(){
        let alertController = UIAlertController(title: "Already liked!", message: "You have already aded this item to your favourite list.", preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(okayAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
