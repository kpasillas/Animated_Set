//
//  Concentration.swift
//  Concentration
//
//  Created by Work Kris on 10/24/18.
//  Copyright © 2018 Kris P. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [ConcentrationCard]()
    
    private(set) var flipCount = 0
    
    private(set) var score = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if cards[index].hasBeenFlipped { score -= 1 }
                    if cards[matchIndex].hasBeenFlipped { score -= 1 }
                }
                cards[index].hasBeenFlipped = true
                cards[matchIndex].hasBeenFlipped = true
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        
        for _ in 1...numberOfPairsOfCards {
            let card = ConcentrationCard()
            cards += [card, card]
        }
        
        for index in cards.indices {
            cards.swapAt(index, cards.count.arc4random)
        }
    }
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
