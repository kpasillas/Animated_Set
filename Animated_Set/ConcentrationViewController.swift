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
    
    @IBOutlet var cardButtons: [ConcentrationCardButton]!
    
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
                updateFlipCountLabel()
                updateScoreLabel()
//                if card.isFaceUp {
//                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
//                    button.backgroundColor = UIColor.white
//
//                } else {
//                    button.setTitle("", for: UIControl.State.normal)
//                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
//                }
            }
        }
    }
    
    private func updateFlipCountLabel() {
//        let attributes: [NSAttributedString.Key:Any] = [
//            .strokeWidth : 5.0,
//            .strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        ]
//        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
//        flipCountLabel.attributedText = attributedString
        flipCountLabel.updateText(string: "Flips: \(game.flipCount)")
    }
    
    private func updateScoreLabel() {
//        let attributes: [NSAttributedString.Key:Any] = [
//            .strokeWidth : 5.0,
//            .strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        ]
//        let attributedString = NSAttributedString(string: "Score: \(game.score)", attributes: attributes)
//        scoreLabel.attributedText = attributedString
        scoreLabel.updateText(string: "Score: \(game.score)")
//        scoreLabel.attributedText = NSAttributedString(string: "Score: \(game.score)")
    }
    
    private func resetCardButtons() {
        for index in cardButtons.indices {
            cardButtons[index].symbol = ""
            cardButtons[index].isMatched = false
            cardButtons[index].isFaceUp = false
        }
    }
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
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
