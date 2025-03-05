//
//  GameView.swift
//  Fire Chicky Games
//
//  Created by Dias Atudinov on 05.03.2025.
//


import SwiftUI

// MARK: - Игровой экран

struct GameView: View {
    @StateObject var game: GameModel
    
    var body: some View {
        VStack(spacing: 10) {
            // Информация о жизнях и оставшихся флажках
            HStack {
                Text("Жизни: \(game.lives)")
                Text("Флажков: \(game.maxFlags - game.flagsPlaced)")
            }
            .font(.headline)
            
            // Статус игры
            if game.gameOver {
                Text("Game Over!")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            } else if game.gameWon {
                Text("You Win!")
                    .font(.largeTitle)
                    .foregroundColor(.green)
            }
            
            // Подсказки сверху (столбцы)
            let columnHints = game.columnFlameHints()
            HStack(spacing: 10) {
                Text(" ")
                    .frame(width: 30, height: 30)
                HStack(spacing: 0) {
                    ForEach(0..<game.columns, id: \.self) { c in
                        Text("\(columnHints[c])")
                            .frame(width: 30, height: 30)
                            .background(Color.yellow.opacity(0.3))
                    }
                }
            }
            
            // Игровое поле с подсказками слева (строки)
            VStack(spacing: 00) {
                ForEach(0..<game.rows, id: \.self) { r in
                    HStack(spacing: 10) {
                        let rowHints = game.rowFlameHints()
                        Text("\(rowHints[r])")
                            .frame(width: 30, height: 30)
                            .background(Color.yellow.opacity(0.3))
                        HStack(spacing: 0) {
                        ForEach(0..<game.columns, id: \.self) { c in
                            let tile = game.board[r][c]
                            ZStack {
                                Rectangle()
                                    .stroke(Color.black, lineWidth: 1)
                                    .frame(width: 30, height: 30)
                                    .background((r, c) == game.level.chickenStart ? Color.gray.opacity(0.3) : ((tile.isRevealed && tile.arrow == nil) ? Color.gray.opacity(0.3) : Color.blue))
                                
                                // Гнездо всегда видно
                                if (r, c) == game.nestPosition {
                                    Text("🏠")
                                }
                                // Курочка
                                if (r, c) == game.chickenPosition {
                                    Text("🐔")
                                }
                                
                                // Если клетка открыта и содержит огонь
                                if tile.isRevealed && tile.isFlame {
                                    Text("🔥")
                                }
                                // Флажок
                                if tile.isFlagged {
                                    Text("🚩")
                                }
                                // Стрелка – всегда видна и расположена в центре клетки
                                if let arrow = tile.arrow {
                                    Text(arrow.symbol)
                                        .font(.caption)
                                        .foregroundColor(.black)
                                }
                            }
                            .onTapGesture {
                                game.toggleFlag(at: (row: r, col: c))
                            }
                        }
                    }
                    }
                }
            }
            // Обработка свайпов для перемещения курицы
            .gesture(
                DragGesture(minimumDistance: 20)
                    .onEnded { value in
                        let horizontal = value.translation.width
                        let vertical = value.translation.height
                        if abs(horizontal) > abs(vertical) {
                            if horizontal < 0 {
                                game.moveChicken(direction: .left)
                            } else {
                                game.moveChicken(direction: .right)
                            }
                        } else {
                            if vertical < 0 {
                                game.moveChicken(direction: .up)
                            } else {
                                game.moveChicken(direction: .down)
                            }
                        }
                    }
            )
            
            // Кнопка перезапуска уровня
            Button("Restart Level") {
                game.setupBoard()
            }
            .padding()
        }
        .padding()
    }
}
    
#Preview {
    FCTrapSweeperGameView()
}
