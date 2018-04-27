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
    
    private func updateButtonsFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
//            let card = game.cards[index]
            button.setTitle( String (index), for: .normal)
            if index < 12 {
                button.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            }
//            if game.cards.contains(card) {
////                draw card
////                attribute depends on the selectedCards.contains
//            } else {
////                zero string
//            }
        }
    }
    
    @IBAction func dealThreeMoreCards(_ sender: UIButton) {
    }
    @IBAction func restartGame(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtonsFromModel()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

