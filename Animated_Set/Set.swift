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
    private(set) var originalDeckOfCards: [SetCard] = {
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
        return CardsArray
    }()
    
    private(set) var dealtCards = [SetCard?]()
    private(set) var selectedCardsIndices = [Int]()
    private(set) var matchedCards = [SetCard]()
    private(set) var score = 0
    
    var isSet: Bool {
        get {
//            if selectedCardsIndices.count == 3 {
//                return true
//            } else {
//                return false
//            }
            return testIfSet(testEnums)
        }
    }
    
    init() {
        for _ in 1...12 {
            dealtCards += [dealCard()]
        }

//        for _ in 0..<57 {
//            _ = originalDeckOfCards.remove(at: originalDeckOfCards.count.arc4random)
//        }
    }
    
    mutating func dealCard() -> SetCard? {
        return (originalDeckOfCards.count > 0 ? originalDeckOfCards.remove(at: originalDeckOfCards.count.arc4random) : nil)
    }
    
    mutating func dealThreeCards() {
        if isSet {
            replaceSet()
            selectedCardsIndices.removeAll()
        } else {
            for _ in 1...3 {
                dealtCards += [dealCard()]
                //            dealtCards += [originalDeckOfCards.remove(at: index)]
            }
        }
    }
    
    mutating func selectCard(at index: Int) {
        if selectedCardsIndices.count < 3 {
            if let deselectIndex = selectedCardsIndices.firstIndex(of: index) {
                selectedCardsIndices.remove(at: deselectIndex)
            } else {
                selectedCardsIndices += [index]
            }
        } else {
            if isSet {
                replaceSet()
                score += 3
            } else {
                score -= 5
            }
            if selectedCardsIndices.contains(index) {
                selectedCardsIndices.removeAll()
            } else {
                selectedCardsIndices.removeAll()
                selectedCardsIndices += [index]
            }
        }
    }
    
    mutating func replaceSet() {
        for index in selectedCardsIndices.indices {
            matchedCards += [dealtCards.remove(at: selectedCardsIndices[index])!]
            dealtCards.insert(dealCard(), at: selectedCardsIndices[index])
        }
    }
    
    mutating func shuffleDealtCards() {
        for index in dealtCards.indices {
            let card = dealtCards.remove(at: index)
            dealtCards.insert(card, at: dealtCards.count)
        }
    }
    
    func testIfSet(_ aClosure: (SetCard, SetCard, SetCard) -> Bool) -> Bool {
        return (selectedCardsIndices.count == 3 && aClosure(dealtCards[selectedCardsIndices[0]]!, dealtCards[selectedCardsIndices[1]]!, dealtCards[selectedCardsIndices[2]]!))
    }
    
    var testEnums: (SetCard, SetCard, SetCard) -> Bool = {
        return ((($0.shape == $1.shape && $0.shape == $2.shape) || ($0.shape != $1.shape && $0.shape != $2.shape && $1.shape != $2.shape)) && (($0.number == $1.number && $0.number == $2.number) || ($0.number != $1.number && $0.number != $2.number && $1.number != $2.number)) && (($0.shading == $1.shading && $0.shading == $2.shading) || ($0.shading != $1.shading && $0.shading != $2.shading && $1.shading != $2.shading)) && (($0.color == $1.color && $0.color == $2.color) || ($0.color != $1.color && $0.color != $2.color && $1.color != $2.color)))
    }
    
}

//extension Int {
//    var arc4random: Int {
//        if self > 0 {
//            return Int(arc4random_uniform(UInt32(self)))
//        } else if self < 0 {
//            return -Int(arc4random_uniform(UInt32(abs(self))))
//        } else {
//            return 0
//        }
//    }
//}
