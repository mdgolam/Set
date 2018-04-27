//
//  Card.swift
//  Set
//
//  Created by Vlad Md Golam on 22.04.2018.
//  Copyright © 2018 Vlad Md Golam. All rights reserved.
//

import Foundation

struct Card: Equatable, CustomStringConvertible {
    
    static func ==(fSide: Card, sSide: Card) -> Bool {
        return true
    }
    
    enum Option: Int, CustomStringConvertible {
        case first = 1
        case second
        case third
        
        static var all: [Option] { return [.first, .second, .third] }
        var description: String { return String(self.rawValue) }
        var idx: Int { return (self.rawValue - 1) }
    }
    
    let colour: Option
    let shape: Option
    let fill: Option
    let number: Option
    
    var description: String { return "\(number)-\(colour)-\(shape)-\(fill)" }
    
    static func isSet(cards: [Card]) -> Bool {
        guard cards.count == 3 else { return false }
        let sum = [
            cards.reduce(0, { $0 + $1.number.rawValue }),
            cards.reduce(0, { $0 + $1.fill.rawValue }),
            cards.reduce(0, { $0 + $1.colour.rawValue }),
            cards.reduce(0, { $0 + $1.shape.rawValue })
        ]
        return (sum.reduce(true, { $0 && ($1 % 3  == 0) } ))
    
    }
    
}
