//
//  Set.swift
//  Set
//
//  Created by Vlad Md Golam on 22.04.2018.
//  Copyright © 2018 Vlad Md Golam. All rights reserved.
//

import Foundation

struct Set {
    
    private lazy var deck = CardDeck()
    private(set) var cards = [Card]()
    private(set) var selectedCards = [Card]()
    private(set) var matchedCards = [Card]()
    
    private(set) var scoreCount = 0
    
    init(numberOfCards: Int) {
        assert(numberOfCards > 0, "You must have at least one card")
        for _ in 1...numberOfCards {
            if let card = deck.draw() {
                cards += [card]
            }
        }
    }
    
    mutating func restart() {
        scoreCount = 0
        cards = []
        selectedCards = []
        matchedCards = []
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Set.chooseCard(at: \(index)): chosen index not in the cards")
        selectedCards.append(cards[index])
    }
    
    mutating func deal() {
        if selectedCards.count == 3 {
            if Card.isSet(cards: selectedCards) {
                print("Set!")
                for card in selectedCards {
                    matchedCards += [card]
                    if let index = cards.index(of: card) {
                        if let newcard = deck.draw() {
                            cards[index] = newcard
                        }
                    }
                }
            } else {
                print("Not Set!")
            }
        } else if selectedCards.count == 0 {
            for _ in 1...3 {
                if let card = deck.draw() {
                    cards += [card]
                }
            }
        }
    }
    
}
