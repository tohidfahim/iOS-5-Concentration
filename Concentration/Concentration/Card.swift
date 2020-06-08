//
//  Card.swift
//  Concentration
//
//  Created by Tohid Fahim on 2/6/20.
//  Copyright © 2020 Tohid Fahim. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    init(identifier : Int) {
        self.identifier = identifier
    }
}
