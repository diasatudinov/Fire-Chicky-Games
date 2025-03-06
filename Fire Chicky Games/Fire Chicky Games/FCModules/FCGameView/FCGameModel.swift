//
//  GameModel.swift
//  Fire Chicky Games
//
//  Created by Dias Atudinov on 05.03.2025.
//


import SwiftUI

// MARK: - Модель игры

class GameModel: ObservableObject {
    // Конфигурация уровня
    let level: Level
    let num: Int
    let rows: Int
    let columns: Int
    // Максимальное количество флажков равно числу огней в уровне
    let maxFlags: Int
    // Игровое поле: матрица клеток
    @Published var board: [[Tile]]
    
    // Положение курицы и гнезда
    @Published var chickenPosition: (row: Int, col: Int)
    @Published var nestPosition: (row: Int, col: Int)
    
    // Жизни игрока (3 жизни)
    @Published var lives: Int = 3
    // Состояния игры
    @Published var gameOver: Bool = false
    @Published var gameWon: Bool = false
    
    init(level: Level) {
        self.level = level
        self.num = level.num
        self.rows = level.rows
        self.columns = level.columns
        self.maxFlags = level.flames.count
        self.chickenPosition = level.chickenStart
        self.nestPosition = level.nest
        self.board = Array(repeating: Array(repeating: Tile(), count: columns), count: rows)
        setupBoard()
    }
    
    // Загрузка уровня: размещаем элементы согласно конфигурации
    func setupBoard() {
        board = Array(repeating: Array(repeating: Tile(), count: columns), count: rows)
        chickenPosition = level.chickenStart
        nestPosition = level.nest
        
        // Устанавливаем огни
        for pos in level.flames {
            if isValid(position: pos) {
                board[pos.row][pos.col].isFlame = true
            }
        }
        
        // Устанавливаем стрелки
        for (pos, direction) in level.arrows {
            if isValid(position: pos) {
                board[pos.row][pos.col].arrow = direction
            }
        }
        
        recalcAdjacentCounts()
        gameOver = false
        gameWon = false
        if lives < 1 {
            lives = 3
        }
    }
    
    // Пересчёт для каждой клетки количества огней вокруг
    func recalcAdjacentCounts() {
        for r in 0..<rows {
            for c in 0..<columns {
                if !board[r][c].isFlame {
                    board[r][c].adjacentFlameCount = countAdjacentFlames(row: r, col: c)
                } else {
                    board[r][c].adjacentFlameCount = 0
                }
            }
        }
    }
    
    // Подсчёт огней в 8 направлениях от клетки
    func countAdjacentFlames(row: Int, col: Int) -> Int {
        let directions = [(-1,-1), (-1,0), (-1,1),
                          (0,-1),          (0,1),
                          (1,-1),  (1,0),  (1,1)]
        var count = 0
        for (dr, dc) in directions {
            let newRow = row + dr, newCol = col + dc
            if isValid(position: (row: newRow, col: newCol)) && board[newRow][newCol].isFlame {
                count += 1
            }
        }
        return count
    }
    
    // Проверка, что позиция внутри поля
    func isValid(position: (row: Int, col: Int)) -> Bool {
        position.row >= 0 && position.row < rows && position.col >= 0 && position.col < columns
    }
    
    // Открытие клетки (при перемещении курицы)
    func revealTile(at position: (row: Int, col: Int)) {
        guard isValid(position: position) else { return }
        board[position.row][position.col].isRevealed = true
    }
    
    // Количество установленных флажков
    var flagsPlaced: Int {
        board.flatMap { $0 }.filter { $0.isFlagged }.count
    }
    
    // Установка/снятие флажка (не более maxFlags)
    func toggleFlag(at position: (row: Int, col: Int)) {
        guard isValid(position: position) else { return }
        let r = position.row, c = position.col
        if !board[r][c].isRevealed {
            if board[r][c].isFlagged {
                board[r][c].isFlagged.toggle()
            } else if flagsPlaced < maxFlags {
                board[r][c].isFlagged.toggle()
            }
        }
    }
    
    // Перемещение курицы по направлению
    func moveChicken(direction: Direction) {
        guard !gameOver && !gameWon else { return }
        let newRow = chickenPosition.row + direction.rowDelta
        let newCol = chickenPosition.col + direction.colDelta
        let newPosition = (row: newRow, col: newCol)
        if isValid(position: newPosition) {
            chickenPosition = newPosition
            revealTile(at: newPosition)
            checkTile(at: newPosition)
            
            // Если в новой клетке есть стрелка – выполняем прыжок
            if let arrow = board[newRow][newCol].arrow {
                // Вычисляем целевую клетку: перепрыгиваем через соседнюю клетку (два шага)
                let jumpRow = newRow + 2 * arrow.rowDelta
                let jumpCol = newCol + 2 * arrow.colDelta
                let jumpPosition = (row: jumpRow, col: jumpCol)
                if isValid(position: jumpPosition) {
                    chickenPosition = jumpPosition
                    revealTile(at: jumpPosition)
                    checkTile(at: jumpPosition)
                } else {
                    // Если прыжок за пределы поля, берем соседнюю клетку (один шаг)
                    let fallbackRow = newRow + arrow.rowDelta
                    let fallbackCol = newCol + arrow.colDelta
                    let fallbackPosition = (row: fallbackRow, col: fallbackCol)
                    if isValid(position: fallbackPosition) {
                        chickenPosition = fallbackPosition
                        revealTile(at: fallbackPosition)
                        checkTile(at: fallbackPosition)
                    }
                }
            }
        }
    }
    
    // Проверка клетки: если курица попадает на огонь – теряется жизнь,
    // если жизней больше не осталось – выводится сообщение, иначе уровень перезапускается.
    func checkTile(at position: (row: Int, col: Int)) {
        let tile = board[position.row][position.col]
        if tile.isFlame {
            lives -= 1
            if lives > 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.setupBoard()
                }
            } else {
                print("отправляйся на предыдущий уровень")
                gameOver = true
            }
        } else if position == nestPosition {
            gameWon = true
        }
    }
    
    // Подсказки для столбцов
    func columnFlameHints() -> [Int] {
        var hints: [Int] = []
        for c in 0..<columns {
            var count = 0
            for r in 0..<rows {
                if board[r][c].isFlame { count += 1 }
            }
            hints.append(count)
        }
        return hints
    }
    
    // Подсказки для строк
    func rowFlameHints() -> [Int] {
        var hints: [Int] = []
        for r in 0..<rows {
            var count = 0
            for c in 0..<columns {
                if board[r][c].isFlame { count += 1 }
            }
            hints.append(count)
        }
        return hints
    }
}
