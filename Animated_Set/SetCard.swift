//
//  Card.swift
//  Graphical_Set
//
//  Created by Work Kris on 4/6/19.
//  Copyright © 2019 Kris P. All rights reserved.
//

import Foundation

struct SetCard: CustomStringConvertible
{
    var description: String { return "\(shape)-\(number)-\(shading)-\(color)" }
    
    let shape: Shape, number: Number, shading: Shading, color: Color
    
    enum Shape: Character, CaseIterable, CustomStringConvertible {
        
        case diamond = "▲"
        case squiggle = "■"
        case oval = "●"
        
//        static var all = [Symbol.triangle, .circle, .square]
        
        var description: String {
            switch self {
            case .diamond: return "Diamond"
            case .squiggle: return "Squiggle"
            case .oval: return "Oval"
            }
        }
    }
    
    enum Number: Int, CaseIterable, CustomStringConvertible {
        
        case one = 1
        case two
        case three
        
//        static var all = [Number.one, .two, .three]
        
        var description: String { return String(rawValue) }
    }
    
    enum Shading: CaseIterable, CustomStringConvertible {
        
        case solid
        case striped
        case open
        
//        static var all = [Shading.solid, .striped, .open]
        
        var description: String {
            switch self {
            case .solid: return "Solid"
            case .striped: return "Striped"
            case .open: return "Open"
            }
        }
    }
    
    enum Color: CaseIterable, CustomStringConvertible {
        
        case red
        case green
        case purple
        
//        static var all = [Color.red, .green, .purple]
        
        var description: String {
            switch self {
            case .red: return "Red"
            case .green: return "Green"
            case .purple: return "Purple"
            }
        }
    }
}
