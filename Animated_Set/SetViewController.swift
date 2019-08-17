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
   
    @IBOutlet weak var layoutView: SetCardsLayoutView! {
        didSet {
            layoutView.backgroundColor = UIColor.clear
        }
    }
    
    @IBOutlet weak var scoreLabel: CustomLabel! {
        didSet {
            updateScoreLabel()
        }
    }
    
    @IBOutlet weak var dealButton: CustomButton!
    
    @IBOutlet weak var newGameButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("In viewDidLoad")
//        resetDeckOfCards()
        updateViewFromModel()
        
    }
    
    @IBAction func dealCards(_ sender: CustomButton) {
        game.dealThreeCards()
        updateViewFromModel()
    }
    
    
    @IBAction func startNewGame(_ sender: CustomButton) {
        game = Set()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        layoutView.cardArray = convertCardToCardView(game.dealtCards)
        updateDealButton()
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
                
                cardViews += [newCardView]
            }
        }
        return cardViews
    }

    @objc func tapCardAction(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            if let chosenCard = recognizer.view as? SetCardView {
                game.selectCard(at: chosenCard.tag)
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
