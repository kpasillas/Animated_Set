//
//  CardsLayoutView.swift
//  Graphical_Set
//
//  Created by Work Kris on 5/16/19.
//  Copyright © 2019 Kris P. All rights reserved.
//

import UIKit

class SetCardsLayoutView: UIView {
    
//    private lazy var cardArray = createCardArray()
    var cardArray = [SetCardView]() { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    private lazy var cardGrid = Grid(layout: .aspectRatio(5/8), frame: CGRect.zero)
    
    private func configureCardArray(_ cards: [SetCardView]) {
//        print("In configureCardArray")
        
        cardGrid.frame = self.bounds
        cardGrid.cellCount = cards.count
        
        for index in cards.indices {
            cards[index].frame = cardGrid[index]!.inset(by: cardGrid.CardInsetSize)
//            cards[index].borderColorValue = UIColor.blue
            addSubview(cards[index])
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
     
//        print("In layoutSubviews")
        removeAll()

        configureCardArray(cardArray)
        
    }
    
    private func removeAll() {
        
        for view in subviews {
            view.removeFromSuperview()
        }
        
//        print("In CardsLayoutView -> removeAll")
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

//extension CardsLayoutView {
//    private struct SizeRatio {
//        static let borderWidthToBoundsHeight: CGFloat = 0.005
//        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
//    }
//    private var borderWidth: CGFloat {
//        return bounds.size.height * SizeRatio.borderWidthToBoundsHeight
//    }
//    private var cornerRadius: CGFloat {
//        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
//    }
//}

extension Grid {
    struct SizeRatio {
        static let CardInsetRatio: CGFloat = 0.04
    }
    var CardInsetSize: CGSize {
        return CGSize(width: self.cellSize.width * SizeRatio.CardInsetRatio, height: self.cellSize.height * SizeRatio.CardInsetRatio)
    }
}
