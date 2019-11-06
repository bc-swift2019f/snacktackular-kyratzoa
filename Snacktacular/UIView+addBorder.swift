//
//  UIView+addBorder.swift
//  Snacktacular
//
//  Created by Anastasia on 11/6/19.
//  Copyright © 2019 John Gallaugher. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addBorder(width: CGFloat, radius: CGFloat, color: UIColor){
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = radius
    }
    
    func noborder(){
        self.layer.borderWidth = 0.0
    }
    
}
