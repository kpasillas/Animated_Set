//
//  CustomSetLabel.swift
//  Graphical_Set
//
//  Created by Work Kris on 6/22/19.
//  Copyright © 2019 Kris P. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        print("In label Init")
        setupLabel()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
//    public convenience init(string: String) {
//        self.init()
//        self.attributedText = NSAttributedString(string: string)
////        self.setTitle(string, for: .normal)
//        
//    }
    
    private func setupLabel() {
//        self.isOpaque = false
//        self.contentMode = .redraw
//        self.sizeToFit()
//
//        layer.borderWidth = 3.0
//        layer.cornerRadius = 8.0
//        contentEdgeInsets.left = 10.0
//        contentEdgeInsets.right = 10.0
//        contentEdgeInsets.top = 5.0
//        contentEdgeInsets.bottom = 5.0
        //        layer.borderWidth = borderWidth
        //        layer.cornerRadius = cornerRadius
//        layer.borderColor = UIColor.darkGray.cgColor
        
//        print("In setupLabel")
        
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
        //        setTitleColor(#colorLiteral(red: 0.06505490094, green: 0.5875003338, blue: 0.9998186231, alpha: 1), for: .normal)
//        titleLabel?.font = .systemFont(ofSize: fontSize, weight: .semibold)
//
//        setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
//        setTitleColor(UIColor.lightGray, for: .disabled)
//        sizeToFit()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        updateText(string: self.text!)
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    func updateText(string: String) {
        
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(25.0)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        
        let labelAttributes: [NSAttributedString.Key:Any] = [
            .font : font,
            .foregroundColor : UIColor.white,
            .strokeWidth : -5.0,
            .strokeColor : #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        ]
        
//        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
//        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.alignment = .center
//        return NSAttributedString(string: string, attributes: [.paragraphStyle:paragraphStyle, .font:font])
        
        self.attributedText = NSAttributedString(string: string, attributes: labelAttributes)
    }
    
}

extension CustomLabel {
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
