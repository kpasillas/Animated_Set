//
//  CardsLayoutView.swift
//  Graphical_Set
//
//  Created by Work Kris on 5/16/19.
//  Copyright © 2019 Kris P. All rights reserved.
//

import UIKit

class SetCardsLayoutView: UIView {
    
    private(set) lazy var cardGrid = Grid(layout: .aspectRatio(5/8), frame: CGRect.zero)
    
    var cardCount = 0 {
        didSet {
//            print("In SetCardsLayoutView -> cardCount -> didSet")
            cardGrid.cellCount = cardCount
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    var gridFrame = CGRect.zero {
        didSet {
//            print("In SetCardsLayoutView -> gridFrame -> didSet")
            cardGrid.frame = gridFrame
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
////        print("In SetCardsLayoutView -> layoutSubviews")
//
//    }
}

extension Grid {
    struct SizeRatio {
        static let CardInsetRatio: CGFloat = 0.04
    }
    var CardInsetSize: CGSize {
        return CGSize(width: self.cellSize.width * SizeRatio.CardInsetRatio, height: self.cellSize.height * SizeRatio.CardInsetRatio)
    }
}
