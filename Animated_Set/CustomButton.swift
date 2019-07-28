//
//  CustomSetButton.swift
//  Graphical_Set
//
//  Created by Work Kris on 6/15/19.
//  Copyright © 2019 Kris P. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        print("In button Init")
        setupButton()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    public convenience init(string: String) {
        self.init()
        self.setTitle(string, for: .normal)
    }
    
    private func setupButton() {
//        self.isOpaque = false
//        self.contentMode = .redraw
//        self.sizeToFit()
        
        layer.borderWidth = 3.0
        layer.cornerRadius = 8.0
        contentEdgeInsets.left = 10.0
        contentEdgeInsets.right = 10.0
        contentEdgeInsets.top = 5.0
        contentEdgeInsets.bottom = 5.0
//        layer.borderWidth = borderWidth
//        layer.cornerRadius = cornerRadius
        layer.borderColor = UIColor.darkGray.cgColor
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
//        setTitleColor(#colorLiteral(red: 0.06505490094, green: 0.5875003338, blue: 0.9998186231, alpha: 1), for: .normal)
        
//        titleLabel?.font = .systemFont(ofSize: fontSize, weight: .semibold)
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(25.0)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        titleLabel?.font = font
        setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        setTitleColor(UIColor.lightGray, for: .disabled)
        sizeToFit()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupButton()
        setNeedsDisplay()
        setNeedsLayout()
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//    }
    
}

extension CustomButton {
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeightRatio: CGFloat = 0.06
        static let borderWidthToBoundsHeightRatio: CGFloat = 0.06
        static let buttonWidthRatio: CGFloat = 0.1
        static let buttonHeightRatio: CGFloat = 0.05
        static let fontSizeToBoundsHeight: CGFloat = 0.6
    }

    private var cornerRadius: CGFloat {
//        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeightRatio
        return (superview?.frame.size.height)! * SizeRatio.cornerRadiusToBoundsHeightRatio
    }
    private var borderWidth: CGFloat {
        return bounds.size.height * SizeRatio.borderWidthToBoundsHeightRatio
    }
    private var buttonWidth: CGFloat {
        return bounds.size.width * SizeRatio.buttonWidthRatio
    }
    private var buttonHeight: CGFloat {
        return bounds.size.height * SizeRatio.buttonHeightRatio
    }
    private var fontSize: CGFloat {
        return bounds.size.height * SizeRatio.fontSizeToBoundsHeight
    }
}

