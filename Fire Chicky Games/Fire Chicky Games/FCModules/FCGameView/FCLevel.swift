import SwiftUI

// MARK: - Конфигурация уровня

struct Level {
    let rows: Int
    let columns: Int
    let flames: [(row: Int, col: Int)]
    let arrows: [((row: Int, col: Int), Direction)]
    let nest: (row: Int, col: Int)
    let chickenStart: (row: Int, col: Int)
}

enum Direction: CaseIterable {
    case up, down, left, right

    var rowDelta: Int {
        switch self {
        case .up:    return -1
        case .down:  return 1
        case .left:  return 0
        case .right: return 0
        }
    }

    var colDelta: Int {
        switch self {
        case .left:  return -1
        case .right: return 1
        case .up:    return 0
        case .down:  return 0
        }
    }
    
    var symbol: String {
        switch self {
        case .up:    return "↑"
        case .down:  return "↓"
        case .left:  return "←"
        case .right: return "→"
        }
    }
}

// MARK: - Модель клетки

struct Tile: Identifiable {
    let id = UUID()
    var isFlame: Bool = false
    var arrow: Direction? = nil
    var isRevealed: Bool = false
    var isFlagged: Bool = false
    var adjacentFlameCount: Int = 0
}
