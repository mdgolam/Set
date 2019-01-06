//
//  Set.swift
//  Set
//
//  Created by Vlad Md Golam on 22.04.2018.
//  Copyright © 2018 Vlad Md Golam. All rights reserved.
//

import Foundation

struct Set {
    
    private struct Constants {
        static let bonus = 10
        static let notSetPenalty = 5
        static let deselectPenalty = 1
        static let numberOfCards = 12
    }
    
    private(set) var scoreCount = 0
    private(set) var flipCount = 0
    private(set) var setCount = 0
    
    private(set) var cardsOnTable = [Card]()
    private(set) var selectedCards = [Card]()
    private(set) var hiddenFromDeckCards = [Card]()
    private(set) var cardsTriedToMatch = [Card]()
    
    private lazy var deck = CardDeck()
    
    var isSet: Bool? {
        get {
            guard cardsTriedToMatch.count == 3 else { return nil }
            return Card.isSet(cards: cardsTriedToMatch)
        }
        set {
            if newValue != nil {
                if newValue! {
                    scoreCount += Constants.bonus
                    setCount += 1
                } else {
                    scoreCount -= Constants.notSetPenalty
                }
                cardsTriedToMatch = selectedCards
                selectedCards.removeAll()
            } else {
                cardsTriedToMatch.removeAll()
            }
        }
    }
    
    init() {
        assert(Constants.numberOfCards > 0, "You must have at least one card")
        for _ in 1...Constants.numberOfCards {
            if let card = deck.draw() {
                cardsOnTable += [card]
            }
        }
    }
    
    mutating func restart() {
        scoreCount = 0
        flipCount = 0
        setCount = 0
        
        hiddenFromDeckCards = []
        cardsOnTable = []
        selectedCards = []
        cardsTriedToMatch = []
        deck = CardDeck()
        
        assert(Constants.numberOfCards > 0, "You must have at least one card")
        for _ in 1...Constants.numberOfCards {
            if let card = deck.draw() {
                cardsOnTable += [card]
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cardsOnTable.indices.contains(index), "Set.chooseCard(at: \(index)): chosen index not in the cards")
        
        let chosenCard = cardsOnTable[index]
        // find the touched card by its index

        if isSet != nil {
            if isSet! { replaceOrRemoveThreeCards() } else { (print("else")) }
            isSet = nil
        }
        
        if !hiddenFromDeckCards.contains(chosenCard) && !cardsTriedToMatch.contains(chosenCard) {
            if selectedCards.count == 2, !selectedCards.contains(chosenCard) {
                selectedCards += [chosenCard]
                isSet = Card.isSet(cards: selectedCards)
            } else {
                assert(!hiddenFromDeckCards.contains(chosenCard))
                selectedCards.toggle(element: chosenCard)
                if selectedCards.count == 0 {
                    scoreCount -= Constants.deselectPenalty
                }
            }
            flipCount += 1
        }
    }

    mutating func deal() {
        if let deal3Cards =  take3FromDeck() {
            cardsOnTable += deal3Cards
        }
    }
    
    mutating func replaceOrRemoveThreeCards() {
        if let take3Cards = take3FromDeck() {
            cardsOnTable.replace(elements: cardsTriedToMatch, with: take3Cards)
        } else {
            cardsOnTable.remove(elements: cardsTriedToMatch)
        }
        hiddenFromDeckCards += cardsTriedToMatch
        cardsTriedToMatch.removeAll()
    }
    
    private mutating func take3FromDeck() -> [Card]? {
        var threeCards = [Card]()
        for _ in 0...2 {
            if let card = deck.draw() {
                threeCards += [card]
            } else {
                return nil
            }
        }
        return threeCards
    }
    
}

extension Array where Element : Equatable {
    
    mutating func toggle(element: Element){
        if let from = self.index(of:element)  {
            self.remove(at: from)
        } else {
            self.append(element)
        }
    }
    
    // удалить элементы массива из другого массива
    mutating func remove(elements: [Element]) {
        self = self.filter { !elements.contains($0) }
    }
    
    // заменить элементы внутри одного массива. элементы мэтчатся с первым массивом в аргументах и меняются на новые.
    // в двух массивах должно быть одинаковое количество элементов
    mutating func replace(elements: [Element], with new: [Element]) {
        guard elements.count == new.count else {print("BIACH!\(elements+new)"); return}
        for index in 0..<new.count {
            if let matchedIndex = self.index(of: elements[index]) {
                self[matchedIndex] = new[index]
            }
        }
    }

}
