//
//  FavouriteVC.swift
//  ios_2_final_anupam
//
//  Created by Anupam on 2020-02-17.
//  Copyright © 2020 Anupam. All rights reserved.
//

import UIKit

class FavouriteVC: UIViewController {
    
    var myFavArray = [SearchResults]()
    var myFavMovies = [SearchResults]()
    var myFavMusic = [SearchResults]()
    var myFavApps = [SearchResults]()
    var myFavBooks = [SearchResults]()
    
    @IBOutlet weak var segmentedControlFav: UISegmentedControl!
    @IBOutlet weak var favTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.delegate = self
        favTableView.dataSource = self
        
        favTableView.rowHeight = UITableView.automaticDimension
        favTableView.estimatedRowHeight = 44
        
        navigationItem.leftBarButtonItem = editButtonItem
        loadFromDB()
        loadMovies()
        favTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFromDB()
        favTableView.reloadData()
    }
    
    func loadFromDB(){
        if let savedItems = SearchResults.loadFavs() {
            myFavArray = savedItems
        }
        favTableView.reloadData()
    }
    
    func loadMovies(){
        for movies in myFavArray {
            let kind = movies.kind
            
            if kind?.contains("feature-movie") ?? false{
                myFavMovies.append(movies)
            }
        }
    }
    
    func loadMusic() {
        for musics in myFavArray {
            let type = musics.collectionType
            
            if type?.contains("Album") ?? false {
                myFavMusic.append(musics)
            }
        }
    }
    
    func loadApps() {
        for apps in myFavArray {
            let kind = apps.kind
            
            if kind?.contains("software") ?? false {
                myFavApps.append(apps)
            }
        }
    }
    
    func loadBooks(){
        for books in myFavArray {
            let kind = books.kind
            
            if kind?.contains("ebook") ?? false {
                myFavBooks.append(books)
            }
        }
    }
    
    @IBAction func segmentPressed(_ sender: UISegmentedControl){
        switch segmentedControlFav.selectedSegmentIndex {
        case 0:
            loadMovies()
            myFavMusic.removeAll()
            myFavBooks.removeAll()
            myFavApps.removeAll()
            favTableView.reloadData()
        case 1:
            loadMusic()
            myFavMovies.removeAll()
            myFavApps.removeAll()
            myFavBooks.removeAll()
            favTableView.reloadData()
        case 2:
            loadApps()
            myFavMovies.removeAll()
            myFavMusic.removeAll()
            myFavBooks.removeAll()
            favTableView.reloadData()
        case 3:
            loadBooks()
            myFavMovies.removeAll()
            myFavMusic.removeAll()
            myFavApps.removeAll()
            favTableView.reloadData()
        default:
            print("Error")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MyFavDetailsVC" {
           
            switch segmentedControlFav.selectedSegmentIndex {
            case 0:
                let indexPath = favTableView.indexPathForSelectedRow!
                let selectedFav = myFavMovies[indexPath.row]
                let navController = segue.destination as! UINavigationController
                let targetVC = navController.topViewController as! FavDetailsVC
                
                targetVC.myObj = selectedFav
                
            case 1:
                let indexPath = favTableView.indexPathForSelectedRow!
                let selectedFav = myFavMusic[indexPath.row]
                let navController = segue.destination as! UINavigationController
                let targetVC = navController.topViewController as! FavDetailsVC
                
                targetVC.myObj = selectedFav
                
            case 2:
                let indexPath = favTableView.indexPathForSelectedRow!
                let selectedFav = myFavApps[indexPath.row]
                let navController = segue.destination as! UINavigationController
                let targetVC = navController.topViewController as! FavDetailsVC
                
                targetVC.myObj = selectedFav
                
            case 3:
                let indexPath = favTableView.indexPathForSelectedRow!
                let selectedFav = myFavBooks[indexPath.row]
                let navController = segue.destination as! UINavigationController
                let targetVC = navController.topViewController as! FavDetailsVC
                
                targetVC.myObj = selectedFav
                
            default:
                    print("error")
            }
        }
    }
}

//Table View starts:-------------------------------------------------------
extension FavouriteVC:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            switch segmentedControlFav.selectedSegmentIndex {
            case 0:
                return myFavMovies.count
            case 1:
                return myFavMusic.count
            case 2:
                return myFavApps.count
            case 3:
                return myFavBooks.count
            default:
                print("error in segmented control")
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFavItemCell", for: indexPath) as! MyCustomCellForFavVC
        
        switch segmentedControlFav.selectedSegmentIndex {
        case 0:
            let oneData = myFavMovies[indexPath.row]
            cell.update(with: oneData)
        case 1:
            let oneAlbum = myFavMusic[indexPath.row]
            cell.update(with: oneAlbum)
        case 2:
            let oneApp = myFavApps[indexPath.row]
            cell.update(with: oneApp)
        case 3:
            let oneBook = myFavBooks[indexPath.row]
            cell.update(with: oneBook)
        default:
            print("error in prototype cell")
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) ->
     UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            switch segmentedControlFav.selectedSegmentIndex {
            case 0:
                myFavMovies.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                myFavArray.remove(at: indexPath.row)
                SearchResults.saveFav(myFavArray)
            case 1:
                myFavMusic.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                myFavArray.remove(at: indexPath.row)
                SearchResults.saveFav(myFavArray)
            case 2:
                myFavApps.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                 myFavArray.remove(at: indexPath.row)
                SearchResults.saveFav(myFavArray)
            case 3:
                myFavBooks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                 myFavArray.remove(at: indexPath.row)
                SearchResults.saveFav(myFavArray)
            default:
                print("error switching and deleting")
            }
        }
    }
}
