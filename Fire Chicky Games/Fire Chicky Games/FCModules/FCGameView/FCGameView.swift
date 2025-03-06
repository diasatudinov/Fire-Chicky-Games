import SwiftUI

// MARK: - Игровой экран
struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var game: GameModel
    @State var backBtnHandle: () -> ()
    @State var gameWonHandle: () -> ()
    let cellSize: CGFloat = 35
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    backBtnHandle()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(.backIconFC)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                }
                
                Button {
                    game.setupBoard()
                } label: {
                    Image(.restartIconFC)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                }
                Spacer()
            }.padding()
            Spacer()
            VStack(spacing: 10) {
                
                // Подсказки сверху (столбцы)
                let columnHints = game.columnFlameHints()
                HStack(spacing: 10) {
                    Text(" ")
                        .frame(width: cellSize, height: cellSize)
                    HStack(spacing: 5) {
                        ForEach(0..<game.columns, id: \.self) { c in
                            ZStack {
                                Image(columnHints[c] == 0 ? .brownCellFC: .yellowCellFC)
                                    .resizable()
                                    .scaledToFit()
                                Image("\(columnHints[c])FC")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(5)
                                
                            }.frame(width: cellSize, height: cellSize)
                        }
                    }
                }
                
                // Игровое поле с подсказками слева (строки)
                VStack(spacing: 5) {
                    ForEach(0..<game.rows, id: \.self) { r in
                        HStack(spacing: 10) {
                            let rowHints = game.rowFlameHints()
                            ZStack {
                                Image(rowHints[r] == 0 ? .brownCellFC: .yellowCellFC)
                                    .resizable()
                                    .scaledToFit()
                                Image("\(rowHints[r])FC")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(5)
                                
                            }.frame(width: cellSize, height: cellSize)
                            HStack(spacing: 5) {
                                ForEach(0..<game.columns, id: \.self) { c in
                                    let tile = game.board[r][c]
                                    ZStack {
                                        Image((r, c) == game.level.chickenStart ? "greenCellFC" : ((tile.isRevealed && tile.arrow == nil) ? "greenCellFC" : "blueCellFC"))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: cellSize, height: cellSize)
                                        
                                        // Гнездо всегда видно
                                        if (r, c) == game.nestPosition {
                                            Image(.finishFC)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: cellSize, height: cellSize)
                                                .offset(y: -5)
                                        }
                                        // Курочка
                                        if (r, c) == game.chickenPosition {
                                            Image(.gameChichenFC)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: cellSize, height: cellSize)
                                                .offset(y: -5)
                                        }
                                        
                                        // Если клетка открыта и содержит огонь
                                        if tile.isRevealed && tile.isFlame {
                                            Image(.fireFC)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: cellSize, height: cellSize)
                                                .offset(y: -5)
                                        }
                                        
                                        if (game.gameOver || game.gameWon) && tile.isFlame {
                                            Image(.fireFC)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: cellSize, height: cellSize)
                                                .offset(y: -5)
                                        }
                                        
                                        // Флажок
                                        if tile.isFlagged {
                                            Image("type1_flagFC")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: cellSize, height: cellSize)
                                                .offset(x: 5, y: -5)
                                        }
                                        // Стрелка – всегда видна и расположена в центре клетки
                                        if let arrow = tile.arrow {
                                            //                                    Text(arrow.symbol)
                                            //                                        .font(.caption)
                                            //                                        .foregroundColor(.black)
                                            Image(.arrowLeftFC)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: cellSize - 10, height: cellSize - 10)
                                                .rotationEffect(Angle(degrees: arrow.degree))
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
                
                // Информация о жизнях и оставшихся флажках
                HStack(spacing: 20) {
                    HStack(spacing: 5) {
                        Text("\(game.maxFlags - game.flagsPlaced)")
                        Image("type1_flagFC")
                            .resizable()
                            .scaledToFit()
                    }
                    .padding(5)
                    .padding(.horizontal, 5)
                    .background(
                        Color.purpleFC
                    )
                    .cornerRadius(10)
                    HStack(spacing: 5) {
                        Text("\(game.lives)")
                        Image(.gameChichenFC)
                            .resizable()
                            .scaledToFit()
                    }
                    .padding(5)
                    .padding(.horizontal, 5)
                    .background(
                        Color.purpleFC
                    )
                    .cornerRadius(10)
                }.frame(height: 30)
                    .font(.system(size: 20, weight: .black))
                    .foregroundStyle(.white)
            }
            .padding()
            Spacer()
        }.background(
            Image(.bgFC)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .blur(radius: 4)
            
        )
        .onChange(of: game.gameWon) { newValue in
            if newValue {
                gameWonHandle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    backBtnHandle()
                    presentationMode.wrappedValue.dismiss()
                }
                
            }
        }
        .onChange(of: game.gameOver) { newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    backBtnHandle()
                    presentationMode.wrappedValue.dismiss()
                }
                
            }
        }
        
        
    }
}

#Preview {
    FCTrapSweeperGameView()
}
