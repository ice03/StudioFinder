//
//  GradientView.swift
//  StudioFinder
//
//  Created by Admin on 04.12.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    let gradient = CAGradientLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.init(white: 1.0, alpha: 0.0).cgColor]
        gradient.startPoint = .zero
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.locations = [0.7, 1.0]
        layer.addSublayer(gradient)
    }
    
}
