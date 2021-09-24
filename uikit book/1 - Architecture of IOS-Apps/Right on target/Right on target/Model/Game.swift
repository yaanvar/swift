//
//  Game.swift
//  Right on target
//
//  Created by Anvar Rahimov on 24.09.2021.
//

import Foundation

protocol GameProtocol {
    // количество заработанных очков
    var score: Int { get }
    // текущий раунд
    var currentRound: GameRoundProtocol! { get }
    // проверяет, окончена ли игра
    var isGameEnded: Bool { get }
    // генератор случайного значения
    var secretValueGenerator: GeneratorProtocol { get }
    // начинает новую игру и сразу стартует первый раунд
    func restartGame()
    // начинает новый раунд
    func startNewRound()
}

class Game: GameProtocol {

    var score: Int {
        var finalScore: Int = 0
        for round in self.rounds {
            finalScore += round.score
        }
        return finalScore
    }
    
    var currentRound: GameRoundProtocol!
    private var rounds: [GameRoundProtocol] = []
    var secretValueGenerator: GeneratorProtocol
    private var roundsCount: Int!
    
    var isGameEnded: Bool {
        if roundsCount == rounds.count {
            return true
        } else {
            return false
        }
    }
    
    init(valueGenerator: GeneratorProtocol, rounds: Int) {
        secretValueGenerator = valueGenerator
        roundsCount = rounds
        startNewRound()
    }
    
    func restartGame() {
        rounds = []
        startNewRound()
    }

    func startNewRound() {
        let newSecretValue = self.getNewSecretValue()
        currentRound = GameRound(secretValue: newSecretValue)
        rounds.append( currentRound )
    }

    private func getNewSecretValue() -> Int {
        return secretValueGenerator.getRandomValue()
    }
    
}
