//
//  Concentration.swift
//  Concentration
//
//  Created by Akill Halimi on 1/9/19.
//  Copyright © 2019 Akill Halimi. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    
    private var currentScore: Int
    
    //This is an optional because there is a case where there is no one and only face up card
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
        if !cards[index].isMatched {
            if let matchedIndex = indexOfOneAndOnlyFaceUpCard, matchedIndex != index {
                    if cards[index].beenSeen && cards[matchedIndex].beenSeen, cards[index].identifer != cards[matchedIndex].identifer {
                        currentScore-=1
                    }
                cards[index].beenSeen = true
                //The second card up is being marked sceen and if it already been seen we shall reduce points if its not a match
                    if !cards[matchedIndex].beenSeen {
                        cards[matchedIndex].beenSeen = true
                    }
                //The cards match and we are increasing the score
                    if cards[matchedIndex] == cards[index] {
                        cards[matchedIndex].isMatched = true
                        cards[index].isMatched = true
                        currentScore+=2
                    }
                cards[index].isFaceUp = true
            }else {
                //either no cards or two cards are up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    //in the initilizer we can do matchingCard = card because card is a struct so matchingCard does not refrence it but is actually a copy, not a shollow copy(which is a refrence) for those who are use to using java.
    //Also an array is a struct so it makes a copy of what ever is added so one could actually just add card twice and it will have 2 cards in the array, NOT TWO REFRENCES!!
    //Easier to do: cards.append(card)
    //            : cards.apprend(card)
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            let matchingCard = card
            cards.append(card)
            cards.append(matchingCard)
        }
        cards.shuffle()
        currentScore = 0
    }
    
    public func getCurrentScore() -> Int {
        return currentScore
    }
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
