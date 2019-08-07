//
//  ViewController.swift
//  Concentration
//
//  Created by Work Kris on 10/21/18.
//  Copyright © 2018 Kris P. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1) / 2
    }
    
    @IBOutlet weak var scoreLabel: CustomLabel! {
        didSet {
            updateScoreLabel()
        }
    }
    
    @IBOutlet weak var flipCountLabel: CustomLabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        emojiChoices = theme ?? ""
        resetCardButtons()
        updateViewFromModel()
    }
    
    @IBOutlet var cardButtons: [ConcentrationCardButton]! {
        didSet {
            resetCardButtons()
        }
    }
    
    @IBAction func touchCard(_ sender: ConcentrationCardButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                button.symbol = emoji(for: card)
                button.isFaceUp = card.isFaceUp
                button.isMatched = card.isMatched
            }
                
                updateFlipCountLabel()
                updateScoreLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        flipCountLabel.updateText(string: "Flips: \(game.flipCount)")
    }
    
    private func updateScoreLabel() {
        scoreLabel.updateText(string: "Score: \(game.score)")
    }
    
    private func resetCardButtons() {
        for index in cardButtons.indices {
            cardButtons[index].isUserInteractionEnabled = (theme != nil)
            cardButtons[index].symbol = ""
            cardButtons[index].isMatched = false
            cardButtons[index].isFaceUp = false
        }
    }
    
    private func updateAreCardsEnabled() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                cardButtons[index].isUserInteractionEnabled = (theme != nil)
            }
        }
    }
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateAreCardsEnabled()
            updateViewFromModel()
        }
    }
    
    private var emojiChoices = "🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨"

    //    Lecture #4, 33:41
    private var emoji = [ConcentrationCard:String]()
    
    private func emoji(for card: ConcentrationCard) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
        
    }
}
