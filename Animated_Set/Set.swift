//
//  Set.swift
//  Graphical_Set
//
//  Created by Work Kris on 4/6/19.
//  Copyright © 2019 Kris P. All rights reserved.
//

import Foundation
import UIKit

struct Set
{
    private var originalDeckOfCards: [SetCard] = {
//        print ("In Set -> originalDeckOfCards")
        var CardsArray = [SetCard]()
        for shape in SetCard.Shape.allCases {
            for number in SetCard.Number.allCases {
                for shading in SetCard.Shading.allCases {
                    for color in SetCard.Color.allCases {
                        CardsArray += [SetCard(shape: shape, number: number, shading: shading, color: color)]
                    }
                }
            }
        }
//        for index in CardsArray.indices {
//            print("\(index): \(CardsArray[index])")
//        }
        
        return CardsArray
    }()
    
    private(set) var dealtCards = [SetCard]()
    private var matchedCards = [SetCard]()
    private(set) var score = 0
    private(set) var selectedCardsIndices = [Int]()
    
    var deckIsEmpty: Bool {
        get {
            return originalDeckOfCards.isEmpty
        }
    }
    
    var isSet: Bool {
        get {
//            if selectedCardsIndices.count == 3 {                              // any 3 card are a set (for debugging)
//                return true
//            } else {
//                return false
//            }
            
            return testIfSet(testEnums)
        }
    }
    
    init() {
//        print("In Set -> init")
        
        originalDeckOfCards = shuffleDeck(originalDeckOfCards)
        
        for _ in 1...12 {
            insertCard(at: dealtCards.count)
        }
        
//        for _ in 15..<81 {                                                    // start with 15 cards in deck (for debugging)
//            _ = originalDeckOfCards.removeLast()
//        }
    }
    
    private mutating func shuffleDeck(_ deck: [SetCard]) -> [SetCard] {
        var shuffledDeck = deck
        for index in shuffledDeck.indices {
            let card = shuffledDeck.remove(at: index)
            shuffledDeck.insert(card, at: shuffledDeck.count.arc4random)
        }
        return shuffledDeck
    }
    
    private mutating func insertCard(at newIndex: Int) {
        if !originalDeckOfCards.isEmpty {
            dealtCards.insert(originalDeckOfCards.removeFirst(), at: newIndex)
        }
    }
    
    private mutating func removeCard(at oldIndex: Int) {
        let oldCard = dealtCards.remove(at: oldIndex)
        matchedCards.append(oldCard)
    }
    
    mutating func dealThreeCards() {
        for _ in 1...3 {
            insertCard(at: dealtCards.endIndex)
        }
    }
    
    mutating func replaceAndDeselectSet() {
        score += 3
        let sortedCardIndices = selectedCardsIndices.sorted(by: { $0 < $1 })
        for index in sortedCardIndices.indices {
            removeCard(at: sortedCardIndices[index])
            insertCard(at: sortedCardIndices[index])
        }
        selectedCardsIndices.removeAll()
    }
    
    mutating func discardAndDeselectSet() {
        score += 3
        let sortedCardIndices = selectedCardsIndices.sorted(by: { $0 > $1 })
        for index in sortedCardIndices.indices {
            removeCard(at: sortedCardIndices[index])
        }
        selectedCardsIndices.removeAll()
    }

    mutating func deselectNonSetAndSelectCard(at selectedIndex: Int) {
        score -= 5
        if selectedCardsIndices.contains(selectedIndex) {
            selectedCardsIndices.removeAll()
        } else {
            selectedCardsIndices.removeAll()
            selectedCardsIndices.append(selectedIndex)
        }
    }
    
    mutating func selectCard(at selectedIndex: Int) {
        if let deselectIndex = selectedCardsIndices.firstIndex(of: selectedIndex) {
            selectedCardsIndices.remove(at: deselectIndex)
        } else {
            selectedCardsIndices.append(selectedIndex)
        }
    }
    
    private func testIfSet(_ aClosure: (SetCard, SetCard, SetCard) -> Bool) -> Bool {
        return (selectedCardsIndices.count == 3 && aClosure(dealtCards[selectedCardsIndices[0]], dealtCards[selectedCardsIndices[1]], dealtCards[selectedCardsIndices[2]]))
    }
    
    var testEnums: (SetCard, SetCard, SetCard) -> Bool = {
        return ((($0.shape == $1.shape && $0.shape == $2.shape) || ($0.shape != $1.shape && $0.shape != $2.shape && $1.shape != $2.shape)) && (($0.number == $1.number && $0.number == $2.number) || ($0.number != $1.number && $0.number != $2.number && $1.number != $2.number)) && (($0.shading == $1.shading && $0.shading == $2.shading) || ($0.shading != $1.shading && $0.shading != $2.shading && $1.shading != $2.shading)) && (($0.color == $1.color && $0.color == $2.color) || ($0.color != $1.color && $0.color != $2.color && $1.color != $2.color)))
    }
    
}
