//
//  TopThreeLeaderboardCell.swift
//  TrumpPunch
//
//  Created by Ryan Coyne on 4/2/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import UIKit

class TopThreeLeaderboardCell: UITableViewCell {

    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var placeLabel : UILabel!
    @IBOutlet weak var circleView : UIView!
    @IBOutlet var imgView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Lets make the circleView into a circle:
        circleView.layer.cornerRadius = circleView.frame.height/2
        circleView.layer.borderColor = UIColor.gray.cgColor
        circleView.layer.borderWidth = 1
        
        imgView.layer.cornerRadius = imgView.frame.height/4
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
