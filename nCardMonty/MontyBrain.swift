//
//  MontyBrain.swift
//  nCardMonty
//
//  Created by C4Q  on 7/13/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class MontyBrain {
    var numberOfCards: Int
    init(numberOfCards: Int) {
        self.numberOfCards = numberOfCards
        setupCards(n: numberOfCards)
    }
    
    func isCorrectCard(_ cardNum: Int) -> Bool {
        return cards[cardNum] == .hit
    }
    
    private func setupCards(n: Int)  {
        var newCardArray = [Card]()
        for _ in 0..<n {
            let newCard = Card.miss
            newCardArray.append(newCard)
        }
        let randomIndex = Int(arc4random_uniform(UInt32(n)))
        newCardArray[randomIndex] = .hit
        cards = newCardArray
    }
    
    
    private var cards: [Card] = []
    
}
