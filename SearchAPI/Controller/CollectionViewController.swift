//
//  CollectionViewController.swift
//  SearchAPI
//
//  Created by Ashish Singh Chauhan on 28/02/20.
//  Copyright © 2020 Ashish Singh Chauhan. All rights reserved.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "Cell"

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var productsCollection: UICollectionView!
    var productDataModel: ProductDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productsCollection.delegate = self
        self.productsCollection.dataSource = self
        let nib = UINib(nibName: "CollectionView", bundle: nil)
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .horizontal
//        flowLayout.itemSize = C
//        flowLayout.estimatedItemSize
//        flowLayout.minimumLineSpacing = 0
//        flowLayout.minimumInteritemSpacing = 0
        self.productsCollection.register(nib, forCellWithReuseIdentifier: "CollectionView")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var returnedCell: UICollectionViewCell = UICollectionViewCell()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionView", for: indexPath) as? CollectionView, let item = productDataModel?.data?.products?[indexPath.row]  {
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.label.text = item.name
            let imageURL = URL(string: (item.images?[0])!)
            cell.imageView.kf.setImage(with: imageURL)
            returnedCell = cell
        }
        return returnedCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(collectionView.bounds.width/2)
        return CGSize(width: collectionView.bounds.width/2, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
