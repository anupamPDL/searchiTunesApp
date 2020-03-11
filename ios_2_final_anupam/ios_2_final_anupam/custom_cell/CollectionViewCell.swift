//
//  CollectionViewCell.swift
//  ios_2_final_anupam
//
//  Created by Anupam Poudel on 2020-02-22.
//  Copyright © 2020 Mobile Apps. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let http = "https://image.tmdb.org/t/p/w500/"
    
    @IBOutlet weak var collViewImage: UIImageView!
    @IBOutlet weak var firstlabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    override func awakeFromNib() {
         self.layer.cornerRadius = 5
         self.clipsToBounds = true
     }
     
     func updateCustomCollectionCell(with oneData: Results){
      
        let imageURL = URL(string: "\(http)\(oneData.poster_path ?? "")")
         
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageURL!) {
                DispatchQueue.main.async {
                    self.collViewImage.image = UIImage(data: imageData)
                }
            }
        }
        firstlabel.text = oneData.title ?? ""
        secondLabel.text = String(oneData.vote_average ?? 0.0)
     }
}
