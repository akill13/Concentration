//
//  ViewController.swift
//  Concentration
//
//  Created by Akill Halimi on 1/9/19.
//  Copyright © 2019 Akill Halimi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var  game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
    
    var clickCount = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(clickCount)"
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var newGame: UIButton!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            clickCount+=1
            game.chooseCard(at: cardNumber)
            let tempScore = game.getCurrentScore()
            scoreLabel.text = "Score \(tempScore)"
            updateViewFromModel()
        } else {
            print("re-do this action")
        }
    }
    
    @IBAction func createNewGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
        emojiChoices = [["🦇", "🙀", "😱", "👻", "🍬", "🎃"],
                        ["😀", "😃", "😄", "😁", "😆", "😅"],
                        ["🍏", "🍋", "🍓", "🥭", "🍅", "🥬"]]
        clickCount = 0
        random = Int(arc4random_uniform(UInt32(3)))
        self.loadView()
    }
    func updateViewFromModel() {
        for index in 0..<cardButtons.count {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emojiChoices = [["🦇", "🙀", "😱", "👻", "🍬", "🎃"],
                                ["😀", "😃", "😄", "😁", "😆", "😅"],
                                ["🍏", "🍋", "🍓", "🥭", "🍅", "🥬"]]
    
    private var random = Int(arc4random_uniform(UInt32(3)))
    
    var emoji = Dictionary<Int,String>()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifer] == nil, emojiChoices[random].count>0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices[random].count)))
            emoji[card.identifer] = emojiChoices[random].remove(at: randomIndex)
        }
        return emoji[card.identifer] ?? "?"
    }
}
