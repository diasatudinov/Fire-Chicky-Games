//
//  FCTrapSweeperGameView.swift
//  Fire Chicky Games
//
//  Created by Dias Atudinov on 05.03.2025.
//

import SwiftUI

struct FCTrapSweeperGameView: View {
    var body: some View {
        // Пример уровня, задаваемого в коде
        let level1 = Level(
            rows: 5,
            columns: 5,
            flames: [(row: 1, col: 2), (row: 2, col: 1), (row: 3, col: 3)],
            arrows: [((row: 2, col: 3), .left), ((row: 3, col: 0), .up)],
            nest: (row: 4, col: 4),
            chickenStart: (row: 0, col: 0)
        )
        
        GameView(game: GameModel(level: level1))
    }
}

#Preview {
    FCTrapSweeperGameView()
}

