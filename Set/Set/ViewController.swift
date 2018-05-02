//
//  ViewController.swift
//  Set
//
//  Created by Vlad Md Golam on 13.04.2018.
//  Copyright © 2018 Vlad Md Golam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = Set(numberOfCards: 12)
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateButtonsFromModel()
        }
    }
    
    @IBAction func dealThreeMoreCards(_ sender: UIButton) {
        if game.cards.count < 22 || game.selectedCards.count == 3 {
            game.deal()
            updateButtonsFromModel()
        }
    }
    @IBAction func restartGame(_ sender: UIButton) {
        updateButtonsFromModel()
    }
    
    let figures = ["▲●■"]
    
    private func updateButtonsFromModel() {
        for index in game.cards.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            let attributes: [NSAttributedStringKey : Any] = [
                .strokeColor : game.selectedCards.contains(card) ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                ]
            
            let title = String(repeating: figures[card.shape.rawValue], count: card.number.rawValue)
            let attributedTitle = NSAttributedString(string: title, attributes: attributes)
            button.setAttributedTitle(attributedTitle, for: .normal)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtonsFromModel()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

