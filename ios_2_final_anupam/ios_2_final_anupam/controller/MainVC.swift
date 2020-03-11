//
//  MainVC.swift
//  ios_2_final_anupam
//
//  Created by Anupam Poudel on 2020-02-14.
//  Copyright © 2020 Anupam Poudel. All rights reserved.
//

import UIKit

class  MainVC: UIViewController {
    
    var mySingleArrayForResults = [SearchResults]()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
    }
    
    //Segment selection scenario---------------------------
    @IBAction func segmentSelected(_ sender: UISegmentedControl){
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            mySingleArrayForResults.removeAll()
            tableView.reloadData()
            
        case 1:
            mySingleArrayForResults.removeAll()
            tableView.reloadData()
            
        case 2:
            mySingleArrayForResults.removeAll()
            tableView.reloadData()
            
        case 3:
            mySingleArrayForResults.removeAll()
            tableView.reloadData()
            
        default:
            print("error")
        }
    }
    
    //prepare method to show details---------------------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MyDetailOfArtist" {
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                let indexPath = tableView.indexPathForSelectedRow!
                let movie = mySingleArrayForResults[indexPath.row]
                let navController = segue.destination as! UINavigationController
                let targetVC = navController.topViewController as! DetailsVC
                
                targetVC.mySearchResultItemDetails = movie
                
            case 1:
                let indexPath = tableView.indexPathForSelectedRow!
                let artist = mySingleArrayForResults[indexPath.row]
                let navController = segue.destination as! UINavigationController
                let targetVC = navController.topViewController as! DetailsVC
                
                targetVC.mySearchResultItemDetails = artist
                
            case 2:
                let indexPath = tableView.indexPathForSelectedRow!
                let app = mySingleArrayForResults[indexPath.row]
                let navController = segue.destination as! UINavigationController
                let targetVC = navController.topViewController as! DetailsVC
                
                targetVC.mySearchResultItemDetails = app
                
            case 3:
                let indexPath = tableView.indexPathForSelectedRow!
                let eBook = mySingleArrayForResults[indexPath.row]
                let navController = segue.destination as! UINavigationController
                let targetVC = navController.topViewController as! DetailsVC
                
                targetVC.mySearchResultItemDetails = eBook
                
            default:
                print("Error")
            }
        }
        searchBar.resignFirstResponder()
    }
    
    //unwind
    @IBAction func unwindToHome(for unwind: UIStoryboardSegue) {
        
    }
}

//Search bar delegate---------------------------------------
extension MainVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            searchMovies()
            
        case 1:
            searchAlbums()
            
        case 2:
            searchApps()
            
        case 3:
            searchBooks()
            
        default:
            print("Error while loading")
        }
    }
    
    func searchAlbums(){
        mySingleArrayForResults.removeAll()
        if searchBar.text != nil || searchBar.text != "" {
            URLHelper.instance.getAlbums(searchRequest: searchBar.text!) {
                (albums) in
                DispatchQueue.main.async {
                    if let albums = albums {
                        for oneAlbum in albums.results {
                            self.mySingleArrayForResults.append(oneAlbum)
                        }
                        self.tableView.reloadData()
                    }else {
                        print("Could not dequeue data for albums.")
                    }
                }
            }
        }
        searchBar.resignFirstResponder()
    }
    
    func searchMovies(){
        mySingleArrayForResults.removeAll()
        if searchBar.text != nil || searchBar.text != "" {
            URLHelper.instance.getMovies(searchRequest: searchBar.text!) {
                (movies) in
                DispatchQueue.main.async {
                    if let movies = movies {
                        for oneMovie in movies.results {
                            self.mySingleArrayForResults.append(oneMovie)
                        }
                        self.tableView.reloadData()
                    }else {
                        print("Could not dequeue data for movies.")
                    }
                }
            }
        }
        searchBar.resignFirstResponder()
    }
    
    func searchApps(){
        mySingleArrayForResults.removeAll()
        if searchBar.text != nil || searchBar.text != "" {
            URLHelper.instance.getApps(searchRequest: searchBar.text!) {
                (apps) in
                DispatchQueue.main.async {
                    if let apps = apps {
                        for oneApp in apps.results {
                            self.mySingleArrayForResults.append(oneApp)
                        }
                        self.tableView.reloadData()
                    }else {
                        print("Could not dequeue data for apps.")
                    }
                }
            }
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBooks(){
        mySingleArrayForResults.removeAll()
             if searchBar.text != nil || searchBar.text != "" {
                 URLHelper.instance.getEbooks(searchRequest: searchBar.text!) {
                     (apps) in
                     DispatchQueue.main.async {
                         if let apps = apps {
                             for oneApp in apps.results {
                                 self.mySingleArrayForResults.append(oneApp)
                             }
                             self.tableView.reloadData()
                         }else {
                             print("Could not dequeue data for books.")
                         }
                     }
                 }
             }
             searchBar.resignFirstResponder()
    }
}

//Tableview starts here--------------------------------
extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                return mySingleArrayForResults.count
            case 1:
                return mySingleArrayForResults.count
            case 2:
                return mySingleArrayForResults.count
            case 3:
                return mySingleArrayForResults.count
            default:
                print("Error")
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath) as! MyCustomCellVC
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let oneMovie = mySingleArrayForResults[indexPath.row]
            cell.updateCellForMovies(with: oneMovie)
            
        case 1:
            let oneArtist = mySingleArrayForResults[indexPath.row]
            cell.updateCell(with: oneArtist)
            
        case 2:
            let oneApp = mySingleArrayForResults[indexPath.row]
            cell.updateCellForApps(with: oneApp)
            
        case 3:
            let oneBook = mySingleArrayForResults[indexPath.row]
            cell.updateCellForEbooks(with: oneBook)            
        default:
            print("Error")
        }
        return cell
    }
}
