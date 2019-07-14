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
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        emojiChoices = themeChoices[themeChoices.count.arc4random]
        updateViewFromModel()
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            flipCountLabel.text = "Flips: \(game.flipCount)"
            scoreLabel.text = "Score: \(game.score)"
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            }
        }
    }
    
    private var themeChoices = [["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "🧛‍♂️"],
                                ["🚗", "🚕", "🚌", "🏎", "🚓", "🚑", "🚒", "🚚", "🚙", "🚎"],
                                ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐼", "🦁", "🐮", "🐷"],
                                ["😃", "🤣", "😊", "😇", "🙃", "😍", "😝", "🤓", "😎", "🤩"],
                                ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸"],
                                ["🍎", "🍊", "🍌", "🍉", "🍇", "🍓", "🍒", "🍍", "🥝", "🍐"]]
    
    lazy private var emojiChoices = themeChoices[themeChoices.count.arc4random - 1]
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: ConcentrationCard) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
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
