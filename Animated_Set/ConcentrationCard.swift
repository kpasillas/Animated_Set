//
//  Card.swift
//  Concentration
//
//  Created by Work Kris on 10/24/18.
//  Copyright © 2018 Kris P. All rights reserved.
//

import Foundation

//Lecture #4, 33:41
struct ConcentrationCard: Hashable
{
    var hashValue: Int { return identifier }
    
    static func ==(lhs: ConcentrationCard, rhs: ConcentrationCard) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    var hasBeenFlipped = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqeIdentifier() -> Int {
        identifierFactory += 1
        return ConcentrationCard.identifierFactory
    }
    
    init() {
        self.identifier = ConcentrationCard.getUniqeIdentifier()
    }
}
