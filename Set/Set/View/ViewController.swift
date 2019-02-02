//
//  ViewController.swift
//  Set
//
//  Created by Vlad Md Golam on 13.04.2018.
//  Copyright © 2018 Vlad Md Golam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = Set()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var setsLabel: UILabel!
    @IBOutlet weak var setIndicator: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateButtonsFromModel()
        }
    }
    
    @IBAction func dealThreeMoreCards(_ sender: UIButton) {
        if (game.cardsOnTable.count + 3) <= cardButtons.count {
            game.deal()
            updateButtonsFromModel()
        }
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        game = Set()
        updateButtonsFromModel()
    }
    
    let figures = ["▲","●","■"]
    let colours = [#colorLiteral(red: 0.3333333333, green: 0.8470588235, blue: 0.3725490196, alpha: 1),#colorLiteral(red: 0.3557647059, green: 0.3388235294, blue: 0.8470588235, alpha: 1),#colorLiteral(red: 1, green: 0, blue: 0.5294117647, alpha: 1)]
    
    private func updateButtonsFromModel() {
        scoreLabel.text = "score: \(game.scoreCount)"
        setsLabel.text = "sets: \(game.setCount)"

        let itIsSet = game.isSet
        
        if itIsSet != nil {
            if itIsSet! {
                setIndicator.textColor = #colorLiteral(red: 0.1960784314, green: 0.8431372549, blue: 0.2941176471, alpha: 1)
                setIndicator.text = "Set!"
            } else {
                setIndicator.textColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1)
                setIndicator.text = "Not Set"
            }
        } else {
            setIndicator.text = ""
        }
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            button.alpha = 1
            
            if index < game.cardsOnTable.count {
                let card = game.cardsOnTable[index]
                let colour = colours[card.colour.rawValue-1]
                
                var attributes: [NSMutableAttributedString.Key : Any] = [
                    .strokeColor: colour,
                    .foregroundColor: colour,
                ]
                switch card.shading {
                case .first:
                    attributes[.strokeWidth] = 4
                    attributes[.foregroundColor] = colour
                case .second:
                    attributes[.strokeWidth] = -1
                    attributes[.foregroundColor] = colour
                case .third:
                    attributes[.strokeWidth] = -1
                    attributes[.strokeWidth] = 2
                    attributes[.foregroundColor] = colour.withAlphaComponent(0.35)
                }
                
                let title = String(repeating: figures[card.shape.rawValue-1], count: card.number.rawValue)
                let attributedTitle = NSMutableAttributedString(string: title, attributes: attributes)
                button.setAttributedTitle(attributedTitle, for: .normal)
                
                // не Set → карты остаются выделенными (внешне)
                if game.cardsTriedToMatch.contains(card) || game.selectedCards.contains(card) {
                    button.layer.borderWidth = 3.0
                    // TODO: вообще по-хорошему не надо каждый раз спрашивать, был ли сет для всех 24 кнопок. как бы это оптимизировать?
                    if itIsSet != nil {
                        if itIsSet! {
                            button.layer.borderColor = #colorLiteral(red: 0.1960784314, green: 0.8431372549, blue: 0.2941176471, alpha: 1)
                        } else {
                            button.layer.borderColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1)
                        }
                    } else {
                        button.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                    }
                } else {
                    button.layer.borderWidth = 0
                }
                
                    // не Set → карты остаются выделенными (внешне)
//                    if itIsSet != nil && itIsSet! {
//                        button.layer.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//                    } else {
//                        button.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
//                    }
//                } else {
//                     button.layer.borderWidth = 0
//                }

                // не Set → выделение снимается, но составленным Сетом можно полюбоваться
//                if itIsSet != nil && itIsSet! && game.cardsTriedToMatch.contains(card) {
////                if (itIsSet == nil || itIsSet == false) && game.cardsTriedToMatch.contains(card) {
//                    button.layer.borderWidth = 3.0
//                    button.layer.borderColor = #colorLiteral(red: 0.1960784314, green: 0.8431372549, blue: 0.2941176471, alpha: 1)
//                } else if game.selectedCards.contains(card) {
//                    button.layer.borderWidth = 3.0
//                    button.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//                } else {
//                    button.layer.borderWidth = 0
//                }
                
            } else {
                button.alpha = 0
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtonsFromModel()
    }

}

