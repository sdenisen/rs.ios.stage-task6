//
//  Game.swift
//  DurakGame
//
//  Created by Дима Носко on 16.06.21.
//
import Foundation

protocol GameCompatible {
    var players: [Player] { get set }
}

struct Game: GameCompatible {
    var players: [Player]
}

extension Game {

    func defineFirstAttackingPlayer(players: [Player]) -> Player? {
        var playerStart: Player?

        guard players.count > 0 else { return nil }
        playerStart = players[0]
        var minCard: Card?
        for player in players {
            if let cards = player.hand {
                for card in cards {
                    if card.isTrump == true {
                        if minCard == nil {
                            minCard = card
                            playerStart = player
                        } else if let cardTmp = minCard {
                            if cardTmp.value.rawValue < card.value.rawValue {
                            minCard = card
                            playerStart = player
                        }
                        }
                    }
                }
            }
        }

        return playerStart
    }
}
