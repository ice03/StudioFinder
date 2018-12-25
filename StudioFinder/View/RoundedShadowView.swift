//
//  RoundedShadowView.swift
//  StudioFinder
//
//  Created by Admin on 04.12.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class RoundedShadowView: UIView {
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = 5
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
