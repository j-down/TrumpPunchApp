//
//  TPStoreCollectionViewCell.swift
//  TrumpPunch
//
//  Created by Admin on 2/27/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

//
//  TPPeopleCollectionViewCell.swift
//  TrumpPunch
//
//  Created by Admin on 2/21/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

class TPStoreCollectionViewCell: UICollectionViewCell {
    
    static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.formatterBehavior = .behavior10_4
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    var product: SKProduct!
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCoinsLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productIconImageView: UIImageView!
    
    func setup(for product: SKProduct) {
        
        self.product = product
        
        backgroundColor = UIColor.clear
        
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(cellTapped(gesture:)))
        tapGesture.minimumPressDuration = 0
        
        isUserInteractionEnabled = true
        isExclusiveTouch = true
        
        addGestureRecognizer(tapGesture)
        
        setupContent()
    }
    
    func setupContent() {
        
        if let name = resourceNameForProductIdentifier(product.productIdentifier) {
            
            print("---"  + name)
            productIconImageView.image = UIImage(named: name)
            productNameLabel.text = product.localizedTitle
            productCoinsLabel.text = product.localizedDescription
            TPStoreCollectionViewCell.priceFormatter.locale = product.priceLocale
            productPriceLabel.text = TPStoreCollectionViewCell.priceFormatter.string(from: product.price)
        }
        
    }
    
    func cellTapped(gesture: UITapGestureRecognizer) {
        
        if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.productImageView.transform = CGAffineTransform.identity
            }, completion: { finished in
                
                TPProducts.store.buyProduct(self.product)
            })
        }
        else if gesture.state == .began {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
               self.productImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
        }
        
    }
}

