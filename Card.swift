//
//  Card.swift
//  Concentration
//
//  Created by Akill Halimi on 1/9/19.
//  Copyright © 2019 Akill Halimi. All rights reserved.
//

import Foundation

public struct Card: Hashable {
    var isFaceUp = false
    var isMatched = false
    var identifer: Int
    var beenSeen = false
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifer() -> Int {
        identifierFactory+=1
        return identifierFactory
    }
    
    public static func ==(lhs: Card, rhs: Card) -> Bool {
        return (lhs.identifer == rhs.identifer)
    }
    
    init() {
        self.identifer = Card.getUniqueIdentifer()
    }
}
