//
//  Board.swift
//  Project34
//
//  Created by Anvar Rahimov on 04.03.2022.
//

import UIKit
import GameplayKit

enum ChipColor: Int {
    case none = 0
    case red
    case black
}

class Board: NSObject, GKGameModel {
    
    func apply(_ gameModelUpdate: GKGameModelUpdate) {
        if let move = gameModelUpdate as? Move {
            add(chip: currentPlayer.chip, in: move.column)
            currentPlayer = currentPlayer.opponent
        }
    }
    
    var players: [GKGameModelPlayer]? {
        return Player.allPlayers
    }

    var activePlayer: GKGameModelPlayer? {
        return currentPlayer
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Board()
        copy.setGameModel(self)
        return copy
    }

    func setGameModel(_ gameModel: GKGameModel) {
        if let board = gameModel as? Board {
            slots = board.slots
            currentPlayer = board.currentPlayer
        }
    }
    
    func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]? {
        if let playerObject = player as? Player {
            if isWin(for: playerObject) || isWin(for: playerObject.opponent) {
                return nil
            }

            var moves = [Move]()

            for column in 0 ..< Board.width {
                if canMove(in: column) {
                    moves.append(Move(column: column))
                }
            }

            return moves
        }

        return nil
    }
    
    func score(for player: GKGameModelPlayer) -> Int {
        if let playerObject = player as? Player {
            if isWin(for: playerObject) {
                return 1000
            } else if isWin(for: playerObject.opponent) {
                return -1000
            }
        }

        return 0
    }
    
    static var width = 7
    static var height = 6
    
    func isFull() -> Bool {
        for column in 0 ..< Board.width {
            if canMove(in: column) {
                return false
            }
        }

        return true
    }
    
    func squaresMatch(initialChip: ChipColor, row: Int, col: Int, moveX: Int, moveY: Int) -> Bool {
        if row + (moveY * 3) < 0 { return false }
        if row + (moveY * 3) >= Board.height { return false }
        if col + (moveX * 3) < 0 { return false }
        if col + (moveX * 3) >= Board.width { return false }

        if chip(inColumn: col, row: row) != initialChip { return false }
        if chip(inColumn: col + moveX, row: row + moveY) != initialChip { return false }
        if chip(inColumn: col + (moveX * 2), row: row + (moveY * 2)) != initialChip { return false }
        if chip(inColumn: col + (moveX * 3), row: row + (moveY * 3)) != initialChip { return false }

        return true
    }

    func isWin(for player: GKGameModelPlayer) -> Bool {
        let chip = (player as! Player).chip

        for row in 0 ..< Board.height {
            for col in 0 ..< Board.width {
                if squaresMatch(initialChip: chip, row: row, col: col, moveX: 1, moveY: 0) {
                    return true
                } else if squaresMatch(initialChip: chip, row: row, col: col, moveX: 0, moveY: 1) {
                    return true
                } else if squaresMatch(initialChip: chip, row: row, col: col, moveX: 1, moveY: 1) {
                    return true
                } else if squaresMatch(initialChip: chip, row: row, col: col, moveX: 1, moveY: -1) {
                    return true
                }
            }
        }

        return false
    }
    
    var currentPlayer: Player
    
    var slots = [ChipColor]()

    override init() {
        for _ in 0 ..< Board.width * Board.height {
            slots.append(.none)
        }

        currentPlayer = Player.allPlayers[0]
        
        super.init()
    }
    
    func chip(inColumn column: Int, row: Int) -> ChipColor {
        return slots[row + column * Board.height]
    }

    func set(chip: ChipColor, in column: Int, row: Int) {
        slots[row + column * Board.height] = chip
    }
    
    func nextEmptySlot(in column: Int) -> Int? {
        for row in 0 ..< Board.height {
            if chip(inColumn: column, row: row) == .none {
                return row
            }
        }

        return nil
    }
    
    func canMove(in column: Int) -> Bool {
        return nextEmptySlot(in: column) != nil
    }
    
    func add(chip: ChipColor, in column: Int) {
        if let row = nextEmptySlot(in: column) {
            set(chip: chip, in: column, row: row)
        }
    }
    
}
