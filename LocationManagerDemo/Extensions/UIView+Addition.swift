//
//  UIView+Addition.swift
//  LocationManagerDemo
//
//  Created by Rajan Maheshwari on 14/06/23.
//  Copyright © 2023 Rajan Maheshwari. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
