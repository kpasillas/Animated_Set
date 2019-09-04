//
//  ViewController.swift
//  Graphical_Set
//
//  Created by Work Kris on 4/6/19.
//  Copyright © 2019 Kris P. All rights reserved.
//

import UIKit

// TODO: Animation demo (Lecture #8, 33:25)
// TODO: Use UISnapBehavior for moving cards to discard pile when matched (Lecture #8, 20:40)


class SetViewController: UIViewController {
    
    private lazy var game = Set()
    @IBOutlet weak var scoreLabel: CustomLabel!
    @IBOutlet weak var dealButton: CustomButton!
    @IBOutlet weak var newGameButton: CustomButton!
   
    @IBOutlet weak var layoutView: SetCardsLayoutView! {
        didSet {
//            print("In SetViewController -> layoutView -> didSet")
            layoutView.backgroundColor = UIColor.clear
        }
    }
    
    override func viewDidLoad() {
//        print("In SetViewController -> viewDidLoad")
        super.viewDidLoad()
        
        for _ in 1...12 {
            placeDealtCard(at: nil)
        }
        
        updateViewFromModel()
    }
    
    @IBAction func dealThreeCards(_ sender: CustomButton) {
//        print("In SetViewController -> dealThreeCards")
        
        if game.isSet {                                             // if cards are a set, replace 3 selected cards
            let sortedCardIndices = game.selectedCardsIndices.sorted(by: { $0 > $1 })
            for index in sortedCardIndices.indices {
                let indexToRemoveAndReplace = sortedCardIndices[index]
                removeMatchedCard(at: indexToRemoveAndReplace)
                placeDealtCard(at: indexToRemoveAndReplace)
            }
            game.deselectSet()
        } else {                                                    // if cards are not a set, deal 3 more cards
            for _ in 1...3 {
                placeDealtCard(at: nil)
            }
        }

        updateViewFromModel()
    }
    
    
    @IBAction func startNewGame(_ sender: CustomButton) {
//        print ("In SetViewController -> startNewGame")
        
        game = Set()
        
        for _ in 0..<layoutView.subviews.count {
            if let viewToRemove = layoutView.subviews.last as? SetCardView {
                viewToRemove.removeFromSuperview()
            }
        }
        layoutView.cardCount = 0
        
        for _ in 1...12 {
            placeDealtCard(at: nil)
        }

        updateViewFromModel()
    }
    
    private func placeDealtCard(at index: Int?) {
//        print ("In SetViewController -> placeDealtCard")
        
        if !game.originalDeckOfCards.isEmpty {
            let newIndex = index ?? game.dealtCards.count           // insert at index if replacing a card, otherwise add to end of dealt cards
            game.dealCard(at: newIndex)
            let newCardView = convertCardToCardView(game.dealtCards[newIndex])
            layoutView.cardCount = game.dealtCards.count
            newCardView.frame = layoutView.cardGrid[newIndex]!.inset(by: layoutView.cardGrid.CardInsetSize)
            layoutView.insertSubview(newCardView, at: newIndex)
        }
    }
    
    private func removeMatchedCard(at indexToRemove: Int) {
        if let viewToRemove = layoutView.subviews[indexToRemove] as? SetCardView {
            viewToRemove.removeFromSuperview()
            game.removeSelectedCard(at: indexToRemove)
            layoutView.cardCount = game.dealtCards.count
        }
    }
    
    private func updateViewFromModel() {
//        print("In SetViewController -> updateViewFromModel")
        
        for index in layoutView.subviews.indices {
//            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1.0, delay: 0.5, options: [.curveEaseInOut], animations:{ self.layoutView.subviews[index].frame = self.layoutView.cardGrid[index]!.inset(by: self.layoutView.cardGrid.CardInsetSize) })
            if let cardView = layoutView.subviews[index] as? SetCardView {
                cardView.frame = layoutView.cardGrid[index]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                cardView.borderColorValue = getBorderColor(index)
            }
        }
        
        updateDealButton()
        updateScoreLabel()
    }
    
    private func convertCardToCardView(_ card: SetCard) -> UIView {
//        print("In SetViewController -> convertCardToCardView")
        
            // initialize new CardView
            let borderColor = UIColor.darkGray
            let newCardView = SetCardView(shapeSymbol: card.shape.description, shapeNumber: card.number.rawValue, shapeColor: card.colorValue, shapeShading: card.shading.description, borderColorValue: borderColor)
        
            // add Tap function
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapCardAction(_:)))
            tap.numberOfTapsRequired = 1
            newCardView.isUserInteractionEnabled = true
            newCardView.addGestureRecognizer(tap)
            return newCardView
    }

    @objc func tapCardAction(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            if var selectedCardIndex = layoutView.subviews.firstIndex(of: recognizer.view!) {
//                print("In SetViewController -> tapCardAction -> Tapped Card = \(selectedCardIndex) : \(game.dealtCards[selectedCardIndex])"
                if game.isSet {                                                             // if selected cards are a set
                    let sortedCardIndices = game.selectedCardsIndices.sorted(by: { $0 > $1 })
                    if game.originalDeckOfCards.isEmpty {                                       // if no more cards to deal
                        if game.selectedCardsIndices.contains(selectedCardIndex) {                  // if selected card is already selected, deselect all
                            for index in sortedCardIndices.indices {
                                let indexToRemove = sortedCardIndices[index]
                                if indexToRemove < selectedCardIndex {
                                    selectedCardIndex -= 1
                                }
                                removeMatchedCard(at: indexToRemove)
                            }
                            game.deselectSet()
                        } else {                                                                    // if selected card is not already selected, deselect all then select new card
                            for index in sortedCardIndices.indices {
                                let indexToRemove = sortedCardIndices[index]
                                if indexToRemove < selectedCardIndex {
                                    selectedCardIndex -= 1
                                }
                                removeMatchedCard(at: indexToRemove)
                            }
                            game.deselectSetAndSelectCard(at: selectedCardIndex)
                        }
                    } else {                                                                    // if there are more cards to deal
                        for index in sortedCardIndices.indices {
                            let indexToRemoveAndReplace = sortedCardIndices[index]
                            removeMatchedCard(at: indexToRemoveAndReplace)
                            placeDealtCard(at: indexToRemoveAndReplace)
                        }
                        if game.selectedCardsIndices.contains(selectedCardIndex) {                  // if selected card is already selected, deselect all
                            game.deselectSet()
                        } else {                                                                    // if selected card is not already selected, deselect all then select new card
                            game.deselectSetAndSelectCard(at: selectedCardIndex)
                        }
                    }
                } else if game.selectedCardsIndices.count == 3 {                            // if there are three selected cards which are not a set, deselect three cards
                    game.deselectNonSetAndSelectCard(at: selectedCardIndex)
                } else {                                                                    // if less than three cards are selected, add new selected card
                    game.selectCard(at: selectedCardIndex)
                }
                updateViewFromModel()
            }
        default:
            break
        }
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

    private func updateDealButton() {
        dealButton.isEnabled = !game.originalDeckOfCards.isEmpty
    }

    private func updateScoreLabel() {
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
}
