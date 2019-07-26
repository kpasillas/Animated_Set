//
//  ViewController.swift
//  Graphical_Set
//
//  Created by Work Kris on 4/6/19.
//  Copyright © 2019 Kris P. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {
    
    private var game = Set()

//    var cardGrid = Grid(layout: .aspectRatio(5/8), frame: CGRect.zero) {
//        didSet {
//            cardGrid.frame = layoutView.bounds
//        }
//    }

//    @IBOutlet private var setCardButtons: [UIButton]! {
//        didSet {
//            for index in setCardButtons.indices {
//                setCardButtons[index].layer.borderWidth = 3.0
//                setCardButtons[index].layer.cornerRadius = 8.0
//                setCardButtons[index].layer.borderColor = UIColor.darkGray.cgColor
//                setCardButtons[index].setAttributedTitle(NSAttributedString(string: ""), for: .disabled)
//            }
//        }
//    }
    
    @IBOutlet weak var layoutView: SetCardsLayoutView! {
        didSet {
            layoutView.backgroundColor = UIColor.clear
        }
    }
    
    @IBOutlet weak var scoreLabel: CustomSetLabel! {
        didSet {
            updateScoreLabel()
        }
    }
    
    @IBOutlet weak var dealButton: CustomSetButtom!
    
    @IBOutlet weak var newGameButton: CustomSetButtom!
    
//    @IBOutlet private var newGameButton: UIButton! {
//        didSet {
//            newGameButton.layer.borderWidth = 3.0
//            newGameButton.layer.cornerRadius = 8.0
//            newGameButton.layer.borderColor = UIColor.darkGray.cgColor
//            newGameButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//            newGameButton.setTitleColor(#colorLiteral(red: 0.06505490094, green: 0.5875003338, blue: 0.9998186231, alpha: 1), for: .normal)
//            newGameButton.sizeToFit()
//        }
//    }

//    @IBOutlet private var dealButton: UIButton! {
//        didSet {
//            dealButton.layer.borderWidth = 3.0
//            dealButton.layer.cornerRadius = 8.0
//            dealButton.layer.borderColor = UIColor.darkGray.cgColor
//            dealButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//            dealButton.setTitleColor(#colorLiteral(red: 0.06505490094, green: 0.5875003338, blue: 0.9998186231, alpha: 1), for: .normal)
//            dealButton.setTitleColor(UIColor.lightGray, for: .disabled)
//            dealButton.sizeToFit()
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        print("In viewDidLoad")
//        resetDeckOfCards()
        updateViewFromModel()
        
    }

//    @IBAction private func touchSetCard(_ sender: UIButton) {
//        if let cardNumber = setCardButtons.index(of: sender), cardNumber < game.dealtCards.count {
//            game.selectCard(at: cardNumber)
//            updateViewFromModel()
//        }
//    }

    @IBAction func dealCardsButton(_ sender: CustomSetButtom) {
        dealCards()
    }
    
    
    @IBAction func startNewGame(_ sender: CustomSetButtom) {
//        print("In startNewGame")
        game = Set()
        updateViewFromModel()
    }
    
//    @IBAction private func startNewGame(_ sender: UIButton) {
//        game = Set()
////        resetDeckOfCards()
//        updateViewFromModel()
//    }
 
//    @IBAction func dealCardsButton(_ sender: UIButton) {
//        dealCards()
//    }
    
    @IBAction func dealCardsSwipe(_ sender: UISwipeGestureRecognizer) {
        dealCards()
    }
    
    @IBAction func shuffleCardsRotate(_ sender: UIRotationGestureRecognizer) {
        game.shuffleDealtCards()
        updateViewFromModel()
    }
    
    private func dealCards() {
        game.dealThreeCards()
        updateViewFromModel()
    }

    private func updateViewFromModel() {
//        for index in setCardButtons.indices {                                           // update all cards
//            let button = setCardButtons[index]
//            if index < game.dealtCards.count {                                          // test if card has been dealt
//                button.isEnabled = true
//                button.isSelected = game.selectedCardsIndices.contains(index)               // test if card is selected
//                if let card = game.dealtCards[index] {                                      // if card is currently dealt, draw with attributes
//                    let flippedCardAttributes = NSAttributedString(string: card.attributesSymbolNumber, attributes: card.attributesColorShade)
//                    button.setAttributedTitle(flippedCardAttributes, for: .normal)
//                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//                } else {                                                                    // if original deck of cards is empty, hide card
//                    button.alpha = 0.0
//                }
//            } else {                                                                    // if card has not been dealt, leave unflipped
//                button.isEnabled = false
//            }
//            updateSetButtonBorder(button)
//        }
//        print("In updateViewFromModel")
        
        layoutView.cardArray = convertCardToCardView(game.dealtCards)
        updateDealLabel()
        updateScoreLabel()
    }
    
    private func convertCardToCardView(_ cards: [SetCard?]) -> [SetCardView] {
        var cardViews = [SetCardView]()
        
        for index in cards.indices {
            if let card = cards[index] {
                
                // initialize new CardView
                let borderColor = getBorderColor(index)
                let newCardView = SetCardView(shapeSymbol: card.shape.description, shapeNumber: card.number.rawValue, shapeColor: card.colorValue, shapeShading: card.shading.description, borderColorValue: borderColor)
                
                // add Tap function
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapCardAction(_:)))
                tap.numberOfTapsRequired = 1
                newCardView.isUserInteractionEnabled = true
                newCardView.tag = index
                newCardView.addGestureRecognizer(tap)
                
                // set card border color
//                if game.selectedCardsIndices.contains(index) {
//                    newCardView.borderColorValue = UIColor.blue
//                } else {
//                    newCardView.borderColorValue = UIColor.gray
//                }
                
                cardViews += [newCardView]
            }
        }
        return cardViews
    }

    @objc func tapCardAction(_ sender: UITapGestureRecognizer) {
//        let card = layoutView.cardArray[(sender.view?.tag)!]
//        card.isSelected = !card.isSelected
        
        game.selectCard(at: (sender.view?.tag)!)
        updateViewFromModel()
    }
    
    private func getBorderColor(_ index: Int) -> UIColor {
        var color = UIColor()
        
        if game.selectedCardsIndices.contains(index) {
            if game.selectedCardsIndices.count == 3 {
                if game.isSet {
                    color = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                } else {
                    color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                }
            } else {
                color = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            }
        } else {
            color = UIColor.darkGray
        }
        
        return color
    }

//    private func resetDeckOfCards() {
//        layoutView.cardArray = convertCardToCardView(game.dealtCards)
//    }

//    private func updateSetButtonBorder(_ button: UIButton) {
//        if button.isSelected {                                                          // test if button has been selected
//            if game.isSet {                                                                 // if 3 buttons are set, border = green
//                button.layer.borderColor = UIColor.green.cgColor
//            } else if game.selectedCardsIndices.count == 3 {                                // if 3 buttons are not set, border = red
//                button.layer.borderColor = UIColor.red.cgColor
//            } else {                                                                        // if < 3 buttons are selected, border = blue
//                button.layer.borderColor = UIColor.blue.cgColor
//            }
//        } else {                                                                        // if button is not selected, border = gray
//            button.layer.borderColor = UIColor.darkGray.cgColor
//        }
//    }

    private func updateDealLabel() {
        dealButton.isEnabled = !game.originalDeckOfCards.isEmpty
    }

    private func updateScoreLabel() {
//        let scoreAttributes: [NSAttributedString.Key:Any] = [
//            .font : UIFont.systemFont(ofSize: 25.0),
//            .strokeWidth : 5.0,
//            .strokeColor : #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
//        ]
//        let attributedString = NSAttributedString(string: "Score: \(game.score)", attributes: scoreAttributes)
//        let attributedString = NSAttributedString(string: "Score: \(game.score)")
        
//        print("In updateScoreLabel")
//        scoreLabel.attributedText = NSAttributedString(string: "Score: \(game.score)")
        scoreLabel.updateText(string: "Score: \(game.score)")
    }

}

extension SetCard {
    var colorValue: UIColor {
        switch self.color {
        case .red: return UIColor.red
        case .green: return UIColor.green
        case .purple: return UIColor.purple
        }
    }
    
    //    var attributesColorShade: [NSAttributedString.Key : Any] {
//        let foregroundColor: UIColor
//        switch self.color {
//        case .green: foregroundColor = UIColor.green
//        case .purple: foregroundColor = UIColor.purple
//        case .red: foregroundColor = UIColor.red
//        }
//
//        var alpha = CGFloat(1.0)
//        var stroke = 0.0
//        switch self.shading {
//        case .solid: break
//        case .striped: alpha = 0.15
//        case .open: stroke = 3.0
//        }
//
//        let attributes: [NSAttributedString.Key : Any] = [
//            .foregroundColor : foregroundColor.withAlphaComponent(alpha),
//            .strokeColor : foregroundColor,
//            .strokeWidth : stroke
//        ]
//        return attributes
//    }
//
//    var attributesSymbolNumber: String {
//        switch self.number {
//        case .one: return "\(self.shape.rawValue)"
//        case .two: return "\(self.shape.rawValue)\n   \(self.shape.rawValue)"
//        case .three: return "\(self.shape.rawValue)\n   \(self.shape.rawValue)\n      \(self.shape.rawValue)"
//        }
//    }
}

