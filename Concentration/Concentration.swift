//
//  Concentration.swift
//  Concentration
//
//  Created by Tohid Fahim on 2/6/20.
//  Copyright © 2020 Tohid Fahim. All rights reserved.
//

import Foundation

/*struct*/ class Concentration
{
    private (set) var cards = [Card]()
    
    private var indexOfTheOneAndOnlyFacedUp : Int?
    {
        get{
//            var foundIndex : Int?
//            for index in cards.indices{
//                if cards[index].isFaceUp{
//                    if foundIndex == nil{
//                        foundIndex = index
//                    }
//                    else{
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
            let faceUpCardIndices = cards.indices.filter({cards[$0].isFaceUp})
            return faceUpCardIndices.count == 1 ?  faceUpCardIndices.first : nil
            
        }
        
        set(newValue){
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    /*mutating*/ func chooseCard(at Index : Int)
    {
        //assertions
        assert(cards.indices.contains(Index), "Choosen Index isn't at Class")
        
        /*if cards[Index].isFaceUp {
            cards[Index].isFaceUp = false
        }
        
        else{
            cards[Index].isFaceUp = true
        }*/
        
        if !cards[Index].isMatched {
            if let matchIndex = indexOfTheOneAndOnlyFacedUp , matchIndex != Index
            {
                if cards[Index].identifier == cards[matchIndex].identifier
                {
                    cards[Index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                ///indexOfTheOneAndOnlyFacedUp = nil
                cards[Index].isFaceUp = true
            }
            else
            {
                /*for flipDownIndex in cards.indices
                {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[Index].isFaceUp = true*/
                indexOfTheOneAndOnlyFacedUp = Index  //call set in indexoftheoneandonlyfacedup
            }
            
        }
        
    }
    
    init (numberOfPairOfCards : Int)
    {
        assert(numberOfPairOfCards > 0, "You must have 1 pair of card")
        for id in 1...numberOfPairOfCards{
            let card = Card(identifier: id)
            let matchingCard = card
            
            cards += [card, matchingCard]
        }
        
        // TODO : Shuffle The Cards
        cards = cards.shuffled()
    }
    
}
