//
//  SHBorderLayer.swift
//  Rent
//
//  Created by sahib hussain on 02/04/17.
//  Copyright © 2017 Burning Desire Inclusive. All rights reserved.
//

import UIKit

public class BorderLayer {

    
    public static let shared = BorderLayer()
    
    private init() {
        
    }
    
    public func bottomLayer(height: CGFloat,color: UIColor,frame: CGRect) -> CALayer {
        let bottomLayer = CALayer()
        bottomLayer.backgroundColor = color.cgColor
        bottomLayer.frame = CGRect(x: 0, y: frame.size.height-height, width: frame.size.width, height: height)
        return bottomLayer;
    }
    
    public func TopLayer(height: CGFloat,color: UIColor,frame: CGRect) -> CALayer {
        let bottomLayer = CALayer()
        bottomLayer.backgroundColor = color.cgColor
        bottomLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: height)
        return bottomLayer;
    }
    
    public func RightLayer(height: CGFloat,color: UIColor,frame: CGRect) -> CALayer {
        let bottomLayer = CALayer()
        bottomLayer.backgroundColor = color.cgColor
        bottomLayer.frame = CGRect(x: frame.size.width-height, y: 0, width: height, height: frame.size.height)
        return bottomLayer;
    }
    
    public func LeftLayer(height: CGFloat,color: UIColor,frame: CGRect) -> CALayer {
        let bottomLayer = CALayer()
        bottomLayer.backgroundColor = color.cgColor
        bottomLayer.frame = CGRect(x: 0, y: 0, width: height, height: frame.size.height)
        return bottomLayer;
    }
    
}
