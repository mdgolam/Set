//
//  Set.swift
//  Set
//
//  Created by Vlad Md Golam on 22.04.2018.
//  Copyright © 2018 Vlad Md Golam. All rights reserved.
//

import Foundation

struct Set {
    
    private(set) var cards = [Card]()
    
    init(numberOfCards: Int) {
        assert(numberOfCards > 0, "You must have at least one card")
        for _ in 1...numberOfCards {
//            let card = Card() from the deck
//            cards += [card]
        }
    }
    
    var newCard = Card.Shape.first
    
    private(set) var selectedCards = [Card]()
    private(set) var matchedCards = [Card]()
//    private var deckOfCards: [Card] {
////        for _ in Card.Colour {
////        }
//    }
    
    private(set) var scoreCount = 0
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Set.chooseCard(at: \(index)): chosen index not in the cards")
        selectedCards.append(cards[index])
    }
    
    mutating func deal(on cards: [Card]) {
        assert(cards.count == 3)
//        if
    }
    
}
