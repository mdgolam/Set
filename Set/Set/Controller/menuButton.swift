//
//  menuButton.swift
//  Set
//
//  Created by Vlad Md Golam on 25.04.2018.
//  Copyright © 2018 Vlad Md Golam. All rights reserved.
//

import UIKit

@IBDesignable class menuButton : UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = DefaultValues.cornerRadius {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
//    @IBInspectable var title: String {
//        didSet {
//             setTitle(title, for: .normal)
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure () {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
    
    // Constants
    private struct DefaultValues {
        static let cornerRadius: CGFloat = 6.0
    }
    
}
