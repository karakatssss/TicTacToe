//
//  ContentView.swift
//  TicTacToe
//
//  Created by Qwerty on 13.12.2025.
//

import SwiftUI

struct ContentView: View {

    enum Player {
        case x, o

        var symbol: String { self == .x ? "X" : "O" }
        var next: Player { self == .x ? .o : .x }
    }

    @State private var board: [Player?] = Array(repeating: nil, count: 9)
    @State private var currentPlayer: Player = .x
    @State private var statusText = "Player X Turn"
    @State private var gameOver = false

    let columns = Array(repeating: GridItem(.fixed(90), spacing: 10), count: 3)
    let winPatterns = [
        [0,1,2],[3,4,5],[6,7,8],
        [0,3,6],[1,4,7],[2,5,8],
        [0,4,8],[2,4,6]
    ]

    var body: some View {
        VStack(spacing: 20) {

            Text(statusText)
                .font(.title2)
                .bold()

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0..<9) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 90, height: 90)

                        Text(board[index]?.symbol ?? "")
                            .font(.system(size: 40, weight: .bold))
                    }
                    .onTapGesture {
                        handleTap(at: index)
                    }
                }
            }

            Button("Restart Game") {
                resetGame()
            }
            .padding(.top, 20)
        }
        .padding()
    }

    private func handleTap(at index: Int) {
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

    private func resetGame() {
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

#Preview {
    ContentView()
}

