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
    
    override func layoutSubviews() {
//        print("In SetCardsLayoutView -> layoutSubviews")
        super.layoutSubviews()

        cardGrid.frame = self.bounds
        for index in subviews.indices {
            subviews[index].frame = cardGrid[index]!.inset(by: cardGrid.CardInsetSize)
        }
    }
}

extension Grid {
    struct SizeRatio {
        static let CardInsetRatio: CGFloat = 0.04
    }
    var CardInsetSize: CGSize {
        return CGSize(width: self.cellSize.width * SizeRatio.CardInsetRatio, height: self.cellSize.height * SizeRatio.CardInsetRatio)
    }
}
