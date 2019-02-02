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
        static let dealWhenThereIsSet = 2
        static let numberOfCards = 12
    }
    
    private(set) var scoreCount = 0
    private(set) var flipCount = 0
    private(set) var setCount = 0     
    
    private(set) var cardsOnTable = [Card]()
    private(set) var selectedCards = [Card]()
    private(set) var cardsHiddenFromDeck = [Card]()
    private(set) var cardsTriedToMatch = [Card]()
    
    var lastTryTime:Date?
    var timeBonus:Int {
        var bonus = 0
        if let timeSinceLastTry = lastTryTime?.timeIntervalSinceMoment {
            if timeSinceLastTry <= 60 && timeSinceLastTry > 0 {
                bonus = Int(60/timeSinceLastTry)
            }
        }
        return bonus
    }
    
    private lazy var deck = CardDeck()
    
    var isSet: Bool? {
        get {
            guard cardsTriedToMatch.count == 3 else { return nil }
            return Card.isSet(cards: cardsTriedToMatch)
        }
        set {
            if newValue != nil {
                if newValue! {
                    scoreCount += Constants.bonus + timeBonus // считаем таймбонус относительно последнего сета
                    lastTryTime = Date.init() // записываем время этого сета
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
    
    
    var cardSetsThatMakeSet:[[Int]] {
        var setsThatMakeSet = [[Int]]()
        if cardsOnTable.count > 2 {
            for i in 0..<cardsOnTable.count {
                for j in (i+1)..<cardsOnTable.count {
                    for k in (j+1)..<cardsOnTable.count {
                        let cardsToCheck = [cardsOnTable[i], cardsOnTable[j], cardsOnTable[k]]
                        if Card.isSet(cards: cardsToCheck) {
                            setsThatMakeSet.append([i, j, k])
                        }
                    }
                }
            }
        }
        return setsThatMakeSet
    }
    
    
    init() {
        assert(Constants.numberOfCards > 0, "You must have at least one card")
        lastTryTime = Date.init()
        for _ in 1...Constants.numberOfCards {
            if let card = deck.draw() {
                cardsOnTable += [card]
            }
        }
        
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cardsOnTable.indices.contains(index), "Set.chooseCard(at: \(index)): chosen index not in the cards")
        
        let chosenCard = cardsOnTable[index]
        // find the touched card by index

        if isSet != nil {
            if isSet! { replaceOrRemoveThreeCards() }
            isSet = nil
        }
        
        if !cardsHiddenFromDeck.contains(chosenCard) && !cardsTriedToMatch.contains(chosenCard) {
            if selectedCards.count == 2, !selectedCards.contains(chosenCard) {
                selectedCards += [chosenCard]
                // попытка собрать сет
                isSet = Card.isSet(cards: selectedCards)
            } else {
                assert(!cardsHiddenFromDeck.contains(chosenCard))
                selectedCards.toggle(element: chosenCard)
                if selectedCards.count == 0 {
                    scoreCount -= Constants.deselectPenalty
                }
            }
            flipCount += 1
        }
    }

    mutating func deal() {
        if !cardSetsThatMakeSet.isEmpty {
            scoreCount -= Constants.dealWhenThereIsSet
        }
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
        cardsHiddenFromDeck += cardsTriedToMatch
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
        guard elements.count == new.count else { return }
        for index in 0..<new.count {
            if let matchedIndex = self.index(of: elements[index]) {
                self[matchedIndex] = new[index]
            }
        }
    }

}

extension Date {
    var timeIntervalSinceMoment: Int {
        return Int(-self.timeIntervalSinceNow)
    }
}
