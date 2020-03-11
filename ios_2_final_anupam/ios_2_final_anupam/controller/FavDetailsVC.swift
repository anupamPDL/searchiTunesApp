//
//  FavDetailsVC.swift
//  ios_2_final_anupam
//
//  Created by Anupam Poudel on 2020-02-22.
//  Copyright © 2020 Mobile Apps. All rights reserved.
//

import UIKit
import MessageUI

class FavDetailsVC: UITableViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    
    var myObj: SearchResults?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    
    @IBOutlet weak var firstLbl: UILabel!
    @IBOutlet weak var secondLbl: UILabel!
    @IBOutlet weak var thirdLbl: UILabel!
    @IBOutlet weak var fourthLbl: UILabel!
    @IBOutlet weak var fifthLbl: UILabel!
    @IBOutlet weak var sixthLbl: UILabel!
    @IBOutlet weak var seventhLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayFavDetails()
    }
    
    func displayFavDetails(){
        
        let imageURL = URL(string: myObj!.artworkUrl100)
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageURL!) {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData)
                }
            }
        }
        
        let title = myObj?.kind
        let name = myObj?.trackName
        let price = String(myObj?.price ?? 0.0)
        
        let releaseDateFormatted = myObj?.releaseDate!.prefix(4)
        
        let genre = myObj?.primaryGenreName
        let userRating = myObj?.averageUserRating
        let desc = myObj?.description ?? myObj?.shortDescription
        
        firstLbl.text = "Kind: \(title?.capitalized ?? "n/a")"
        secondLbl.text = "Name: \(name ?? "n/a")"
        thirdLbl.text = "Price: \(price)"
        fourthLbl.text = "Released on: \(releaseDateFormatted ?? "n/a")"
        fifthLbl.text = "Genre: \(genre ?? "n/a")"
        sixthLbl.text = "Rated: \(userRating ?? 0.0)"
        seventhLbl.text = "Description: \(desc ?? "n/a")"
        
    }
    
    @IBAction func donePressed(_ sender: UIBarButtonItem){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareBtnTapped(_ sender: UIButton){
        guard let fav = imageView.image else {return}
        
        let activityController = UIActivityViewController(activityItems: [fav], applicationActivities: nil)
        
        activityController.popoverPresentationController?.sourceView = sender
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func emailBtnTapped(_ sender: UIButton){
        guard MFMailComposeViewController.canSendMail() else{
            return
        }
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(["anupam.poudel@gmail.com"])
        mailComposer.setSubject("My Fav. list")
        mailComposer.setMessageBody("Hi, I would like to share my favourite item image to you.", isHTML: true)
        
        present(mailComposer, animated: true, completion: nil)
        
        func mailComposeController(_ controller:
            MFMailComposeViewController, didFinishWith result:
            MFMailComposeResult, error: Error?) {
            dismiss(animated: true, completion: nil)
        }
        
    }
    
}
