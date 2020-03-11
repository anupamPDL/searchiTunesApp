//
//  MyCustomCellForFavVC.swift
//  ios_2_final_anupam
//
//  Created by Anupam Poudel on 2020-02-17.
//  Copyright © 2020 Anupam Poudel. All rights reserved.
//

import UIKit

class MyCustomCellForFavVC: UITableViewCell {
    
    
    @IBOutlet weak var favImageView: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    func update(with oneD: SearchResults){
        imageSizePreview()
        
        let imageURL = URL(string: oneD.artworkUrl100)
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageURL!) {
                DispatchQueue.main.async {
                    self.favImageView.image = UIImage(data: imageData)
                }
            }
        }
        secondLabel.text = "\(oneD.trackName ?? "") \(String(oneD.collectionPrice ?? 0.0))"
        firstLabel.text = "\(oneD.collectionName ?? "") \(oneD.primaryGenreName ?? "")"
    }
    
    func imageSizePreview(){
        self.favImageView.layer.cornerRadius = 5
        self.favImageView.clipsToBounds = true
    }
}
