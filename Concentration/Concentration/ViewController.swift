//
//  ViewController.swift
//  Concentration
//
//  Created by Tohid Fahim on 1/6/20.
//  Copyright © 2020 Tohid Fahim. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    private lazy var game = Concentration(numberOfPairOfCards: numberOfPairOfCards)
    
    private var numberOfPairOfCards : Int {
        get{
            return cardButtons.count/2
        }
    }
    
    private (set) var flipCount = 0{
        didSet{   //property observer
            //flipCountLabel.text = "Flip Count : \(flipCount)"
            labelColour()
        }
    }
    
    func labelColour(){
        let attributes : [NSAttributedString.Key : Any] = [
            .strokeColor : UIColor.black,
            .strokeWidth : 5.0
        ]
        
        let attributeText = NSAttributedString(string: "Flip Count : \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributeText
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
            labelColour()
        }
    }
    @IBOutlet private var cardButtons: [UIButton]!    //array of uibuttons
    
    @IBAction private func touchCard(_ sender: UIButton) {
        
        let cardNumber = cardButtons.firstIndex(of: sender)! //Set optional and get associated data
        if !(cardButtons[cardNumber].backgroundColor == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)){
            flipCount += 1
        }
        
        game.chooseCard(at: cardNumber)
        updateViewFromModel()
    }
    
    private func updateViewFromModel()
    {
        for index in cardButtons.indices
        {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp
            {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            
            else
            {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }

    private var emojiChoices = ["👻", "🐒", "🐸", "😈", "👹", "🧑‍🎓", "🎩", "🐶", "🐧", "🦜","🌸","🔥","🧁","🍭","⚽️","🚌"]
    private var emoji = [Int : String]()
    
    private func emoji(for card : Card) -> String {
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            //let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))  extension
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arcRandom)
        }
        
        if emoji[card.identifier] != nil{   //optional
            return emoji[card.identifier]!
        }
        else{
            return "!"
        }
    }

}

extension Int{
    var arcRandom : Int{
        return Int(arc4random_uniform(UInt32(self)))
    }
}
