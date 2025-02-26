//
//  UILabel + ext.swift
//  MotivationApp
//
//  Created by Надежда Капацина on 24.02.2025.
//

import UIKit

extension UILabel {
    convenience init(title: String, weight: UIFont.Weight, size: CGFloat) {
        self.init()
        self.text = title
        self.font = .systemFont(ofSize: size, weight: weight)
        self.numberOfLines = 0
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}
