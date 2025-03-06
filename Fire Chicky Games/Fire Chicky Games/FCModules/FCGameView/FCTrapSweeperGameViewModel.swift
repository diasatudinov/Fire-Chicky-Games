//
//  FCTrapSweeperGameViewModel.swift
//  Fire Chicky Games
//
//  Created by Dias Atudinov on 06.03.2025.
//

import Foundation

class FCTrapSweeperGameViewModel: ObservableObject {
    @Published var levels: [Level] = [
        //Level 1
        Level(
            num: 1, rows: 2,
            columns: 3,
            flames: [(row: 0, col: 1)],
            arrows: [],
            nest: (row: 0, col: 2),
            chickenStart: (row: 0, col: 0),
            levelPass: true
        ),
        
        //Level 2
        Level(
            num: 2, rows: 3,
            columns: 2,
            flames: [(row: 1, col: 0)],
            arrows: [],
            nest: (row: 2, col: 0),
            chickenStart: (row: 0, col: 0)
        ),
        
        //Level 3
        Level(
            num: 3, rows: 3,
            columns: 3,
            flames: [(row: 1, col: 0), (row: 2, col: 0), (row: 1, col: 1), (row: 2, col: 1)],
            arrows: [],
            nest: (row: 2, col: 2),
            chickenStart: (row: 0, col: 0)
        ),
        
        //Level 4
        Level(
            num: 4, rows: 3,
            columns: 3,
            flames: [(row: 0, col: 0), (row: 2, col: 1), (row: 2, col: 2)],
            arrows: [],
            nest: (row: 2, col: 0),
            chickenStart: (row: 0, col: 1)
        ),
        
        //Level 5
        Level(
            num: 5, rows: 3,
            columns: 5,
            flames: [(row: 0, col: 1), (row: 0, col: 2), (row: 0, col: 3), (row: 1, col: 1), (row: 1, col: 2), (row: 1, col: 3)],
            arrows: [],
            nest: (row: 0, col: 0),
            chickenStart: (row: 0, col: 4)
        ),
        
        //Level 6
        Level(
            num: 6, rows: 3,
            columns: 5,
            flames: [(row: 2, col: 0), (row: 2, col: 1), (row: 1, col: 1), (row: 0, col: 3), (row: 1, col: 3)],
            arrows: [],
            nest: (row: 0, col: 4),
            chickenStart: (row: 1, col: 0)
        ),
        
        //Level 7
        Level(
            num: 7, rows: 3,
            columns: 5,
            flames: [(row: 0, col: 0), (row: 0, col: 1), (row: 1, col: 1), (row: 2, col: 3), (row: 0, col: 4)],
            arrows: [],
            nest: (row: 2, col: 4),
            chickenStart: (row: 1, col: 0)
        ),
        
        //Level 8
        Level(
            num: 8, rows: 3,
            columns: 4,
            flames: [(row: 1, col: 0), (row: 1, col: 1), (row: 1, col: 2), (row: 0, col: 2), (row: 2, col: 2)],
            arrows: [((row: 0, col: 1), .right), ((row: 2, col: 3), .left)],
            nest: (row: 2, col: 0),
            chickenStart: (row: 0, col: 0)
        ),
        
        //Level 9
        Level(
            num: 9, rows: 4,
            columns: 4,
            flames: [(row: 0, col: 2), (row: 0, col: 3), (row: 2, col: 0), (row: 2, col: 2), (row: 2, col: 3), (row: 2, col: 3), (row: 2, col: 3), (row: 3, col: 1)],
            arrows: [((row: 0, col: 1), .right), ((row: 1, col: 3), .down), ((row: 2, col: 1), .right), ((row: 3, col: 2), .left)],
            nest: (row: 3, col: 0),
            chickenStart: (row: 0, col: 0)
        ),
        
        //Level 10
        Level(
            num: 10,
            rows: 5,
            columns: 4,
            flames: [(row: 0, col: 2),(row: 0, col: 0), (row: 0, col: 3), (row: 2, col: 1), (row: 3, col: 2)],
            arrows: [((row: 1, col: 0), .right), ((row: 2, col: 2), .left), ((row: 3, col: 0), .up), ((row: 3, col: 3), .up)],
            nest: (row: 2, col: 0),
            chickenStart: (row: 4, col: 0)
        ),
        
        //Level 11
        Level(
            num: 11, rows: 4,
            columns: 5,
            flames: [(row: 1, col: 2),(row: 0, col: 1),(row: 0, col: 3), (row: 1, col: 4), (row: 2, col: 4), (row: 3, col: 4)],
            arrows: [((row: 0, col: 2), .right), ((row: 0, col: 4), .down), ((row: 1, col: 3), .right), ((row: 2, col: 0), .right), ((row: 2, col: 1), .up), ((row: 2, col: 3), .down), ((row: 3, col: 1), .right), ((row: 3, col: 2), .left)],
            nest: (row: 3, col: 0),
            chickenStart: (row: 0, col: 0)
        ),
        
        //Level 12
        Level(
            num: 12, rows: 3,
            columns: 4,
            flames: [(row: 1, col: 1),(row: 1, col: 2), (row: 1, col: 3), (row: 2, col: 0), (row: 2, col: 2)],
            arrows: [((row: 0, col: 0), .right), ((row: 0, col: 3), .down), ((row: 2, col: 1), .up)],
            nest: (row: 2, col: 3),
            chickenStart: (row: 1, col: 0)
        ),
        
    ]
    
    init() {
        let passed = UserDefaults.standard.passedLevels
        for i in 0..<levels.count {
            if passed.contains(levels[i].num) {
                levels[i].levelPass = true
            }
        }
    }
    
    
    func levelUp(index: Int) {
        if index < levels.count {
            levels[index].levelPass = true
            
            var passed = UserDefaults.standard.passedLevels
            if !passed.contains(levels[index].num) {
                passed.append(levels[index].num)
                UserDefaults.standard.passedLevels = passed
            }
        }
    }
}

extension UserDefaults {
    private var passedLevelsKey: String { "passedLevelsKey" }
    
    var passedLevels: [Int] {
        get {
            return self.array(forKey: passedLevelsKey) as? [Int] ?? []
        }
        set {
            self.set(newValue, forKey: passedLevelsKey)
        }
    }
}
