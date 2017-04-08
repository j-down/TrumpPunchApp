//
//  TPShopTopView.swift
//  TrumpPunch
//
//  Created by Admin on 2/21/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import UIKit

class TPShopTopView: UIView {
    
    @IBOutlet weak var shopLabel: UILabel!
    
    @IBOutlet weak var exitButton: UIImageView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    func setup() {
        
        frame = CGRect(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY, width: UIScreen.main.bounds.width, height: 110)
        center = CGPoint(x: UIScreen.main.bounds.midX,y: UIScreen.main.bounds.midY - UIScreen.main.bounds.height / 2 + frame.height / 2)
        isHidden = true
        isUserInteractionEnabled = true
        
    }
}
