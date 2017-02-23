//
//  TPHelpers.swift
//  TrumpPunch
//
//  Created by Admin on 2/20/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import UIKit

func convertToGrayScale(image: UIImage) -> UIImage {
    
    let imageRect:CGRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
    let colorSpace = CGColorSpaceCreateDeviceGray()
    let width = image.size.width
    let height = image.size.height
    
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
    
    var newImage = UIImage()
    
    if let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) {
        
        if let cg = image.cgImage {
            
            context.draw(cg, in: imageRect)
            
            if let imageRef = context.makeImage() {
                
                newImage = UIImage(cgImage: imageRef)
            }
        }
    }
    return newImage
}
