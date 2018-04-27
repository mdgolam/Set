//
//  CardDeck.swift
//  Set
//
//  Created by Vlad Md Golam on 26.04.2018.
//  Copyright © 2018 Vlad Md Golam. All rights reserved.
//

import Foundation

struct CardDeck {
    
    private(set) var cards = [Card]()
    
    init() {
        for fill in Card.Option.all {
            for shape in Card.Option.all {
                for colour in Card.Option.all {
                    for number in Card.Option.all {
                        cards.append(Card(colour: colour, shape: shape, fill: fill, number: number))
                    }
                }
            }
        }
    }
    
    mutating func draw() -> Card? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        } else {
            return nil
        }
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
