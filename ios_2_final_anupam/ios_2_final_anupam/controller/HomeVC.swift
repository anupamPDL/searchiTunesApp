//
//  HomeVC.swift
//  ios_2_final_anupam
//
//  Created by Anupam Poudel on 2020-02-22.
//  Copyright © 2020 Mobile Apps. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    var collectionArr = [Results]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellSize()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getTopMovies()
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionArr.shuffle()
    }
    
    func getTopMovies(){
        URLHelper.instance.getTopMovies {(topMovies) in
            if let topMovies = topMovies {
                DispatchQueue.main.async {
                    
                    for oneAlbum in topMovies.results! {
                        self.collectionArr.append(oneAlbum)
                        self.collectionView.reloadData()
                    }
                }
            }else{
                print("could not load data from main queue")
            }
        }
    }
    
    func cellSize(){
        let width = (view.frame.height - 20) / 5
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: width)
    }
}

//Collection View Delegate and Datasource-------------------------------
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collectionArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath) as! CollectionViewCell
        
        let oneResult = collectionArr[indexPath.row]
        cell.updateCustomCollectionCell(with: oneResult)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 300)
    }
}


