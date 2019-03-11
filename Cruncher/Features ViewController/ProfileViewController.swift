//
//  ProfileViewController.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-03-07.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var profileFeed: [ProfileModels] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileFeed = createArrayForProfileFeed()
        
        collectionView.dataSource = self
        collectionView.delegate = self

        
    }
    
    func createArrayForProfileFeed() -> [ProfileModels] {
        let photo1 = ProfileModels(uploadedImageInProfileFeed: "SalmonDish")
        let photo2 = ProfileModels(uploadedImageInProfileFeed: "steak")
        let photo3 = ProfileModels(uploadedImageInProfileFeed: "pizza")
        let photo4 = ProfileModels(uploadedImageInProfileFeed: "burger")
        
        return  [photo1, photo2, photo3, photo4]
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileFeed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let dataStructure = profileFeed[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCollectionCell", for: indexPath) as! ProfileCollectionCell
        cell.setImageInProfileFeed(image: dataStructure)
        return cell
        
    }
}
