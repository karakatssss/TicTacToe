//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Qwerty on 13.12.2025.
//

import SwiftUI

class GameViewModel: ObservableObject {

    enum Player {
        case x, o

        var symbol: String { self == .x ? "X" : "O" }
        var next: Player { self == .x ? .o : .x }
    }

    @Published var board: [Player?] = Array(repeating: nil, count: 9)
    @Published var currentPlayer: Player = .x
    @Published var statusText = "Player X Turn"
    @Published var gameOver = false

    private let winPatterns = [
        [0,1,2],[3,4,5],[6,7,8],
        [0,3,6],[1,4,7],[2,5,8],
        [0,4,8],[2,4,6]
    ]

    func tapCell(_ index: Int) {
        guard board[index] == nil, !gameOver else { return }

        board[index] = currentPlayer

        if checkWinner() {
            statusText = "Player \(currentPlayer.symbol) Wins!"
            gameOver = true
            return
        }

        if !board.contains(nil) {
            statusText = "It's a Draw!"
            gameOver = true
            return
        }

        currentPlayer = currentPlayer.next
        statusText = "Player \(currentPlayer.symbol) Turn"
    }

    func reset() {
        board = Array(repeating: nil, count: 9)
        currentPlayer = .x
        statusText = "Player X Turn"
        gameOver = false
    }

    private func checkWinner() -> Bool {
        for pattern in winPatterns {
            if let p = board[pattern[0]],
               board[pattern[1]] == p,
               board[pattern[2]] == p {
                return true
            }
        }
        return false
    }
}

