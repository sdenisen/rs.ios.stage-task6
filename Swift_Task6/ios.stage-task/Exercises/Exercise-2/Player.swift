//
//  Player.swift
//  DurakGame
//
//  Created by Дима Носко on 15.06.21.
//
import Foundation

protocol PlayerBaseCompatible {
    var hand: [Card]? { get set }
}

final class Player: PlayerBaseCompatible {
    var hand: [Card]?

    func checkIfCanTossWhenAttacking(card: Card) -> Bool {
        guard let handTmp = hand else {
            return false
        }
        for cardItem in handTmp {
            if cardItem.checkValue(card: card) {
                return true
            }
        }
        return false
    }

    func checkIfCanTossWhenTossing(table: [Card: Card]) -> Bool {
        guard let handTmp = hand else {
            return false
        }

        for cardItem in handTmp {
            for (card1, card2) in table {
                if cardItem.checkValue(card: card1) || cardItem.checkValue(card: card2) {
                    return true
                }
            }
        }
        return false
    }
}
