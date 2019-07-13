//
//  Card.swift
//  Concentration
//
//  Created by Work Kris on 10/24/18.
//  Copyright © 2018 Kris P. All rights reserved.
//

import Foundation

struct ConcentrationCard
{
    var isFaceUp = false
    var isMatched = false
    var hasBeenFlipped = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqeIdentifier() -> Int {
        identifierFactory += 1
        return ConcentrationCard.identifierFactory
    }
    
    init() {
        self.identifier = ConcentrationCard.getUniqeIdentifier()
    }
}
