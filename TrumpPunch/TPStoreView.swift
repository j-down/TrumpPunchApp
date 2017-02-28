//
//  TPStoreView.swift
//  TrumpPunch
//
//  Created by Admin on 2/20/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

class TPStoreView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    func setup() {
        
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = true
        
        frame = CGRect(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY + 40, width: UIScreen.main.bounds.width, height: 440)
        center = CGPoint(x: UIScreen.main.bounds.midX,y: UIScreen.main.bounds.midY - 40)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.isUserInteractionEnabled = true
        
        collectionView.register(UINib.init(nibName: "TPStoreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TPStoreCollectionViewCell")
    }
    
    func setupIAP() {
        
        
    }
}

//MARK: UICollectionViewDelegate
extension TPStoreView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return Products.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = "TPStoreCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
            as! TPStoreCollectionViewCell
        
        let product = Products[indexPath.row]
        
        cell.setup(for: product)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didDeselectItemAt indexPath: IndexPath) {
        
        
    }
}

//MARK: UICollectionViewFlowLayout
extension TPStoreView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let paddingSpace = sectionInsets.left * (3 + 1)
        let availableWidth = frame.width - paddingSpace
        let widthPerItem = availableWidth / 3
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

//MARK: IAP 
extension TPStoreView {
    
    func loadProducts()  {
        
        Products = []
        
        TPProducts.store.requestProducts{success, products in
            if success {
                Products = products!
                
                self.collectionView.reloadData()
            }
        }
    }
}
