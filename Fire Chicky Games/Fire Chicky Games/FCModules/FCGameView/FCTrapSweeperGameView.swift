//
//  FCTrapSweeperGameView.swift
//  Fire Chicky Games
//
//  Created by Dias Atudinov on 05.03.2025.
//

import SwiftUI

struct FCTrapSweeperGameView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var openLevel = false
    @State var currentLevel: Level?
    @ObservedObject var viewModel = FCTrapSweeperGameViewModel()
    @ObservedObject var shopVM: FCShopViewModel
    @State private var currentPage: Int = 0
    let levelsPerPage = 10
    
    var body: some View {
        // Пример уровня, задаваемого в коде
        ZStack {
            VStack {
                // Determine the range for the current page
                let startIndex = currentPage * levelsPerPage
                let endIndex = min(startIndex + levelsPerPage, viewModel.levels.count)
                let currentLevels = Array(viewModel.levels[startIndex..<endIndex])
                
                
                HStack {
                    if currentPage > 0 {
                        Button(action: {
                            withAnimation {
                                currentPage -= 1
                            }
                        }) {
                            Image(.levelArrow)
                                .resizable()
                                .scaledToFit()
                                .rotationEffect(Angle(degrees: 180))
                                .frame(height: 80)
                        }
                    } else {
                        Image(.levelArrow)
                            .resizable()
                            .scaledToFit()
                            .rotationEffect(Angle(degrees: 180))
                            .frame(height: 80)
                            .opacity(0)
                    }
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 5), spacing: 10) {
                        ForEach(0..<currentLevels.count, id: \.self) { index in
                            let levelNumber = startIndex + index + 1
                            Button(action: {
                                    DispatchQueue.main.async {
                                        currentLevel = viewModel.levels[startIndex + index]
                                   }
                                    
                                    openLevel = true
                            }) {
                                ZStack {
                                    Image(viewModel.levels[startIndex + index].levelPass ? .yellowCellFC : .blueCellFC)
                                        .resizable()
                                        .scaledToFit()
                                    Text("\(levelNumber)")
                                        .font(.system(size: 60, weight: .black))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }.frame(width: 100, height: 100)
                            }.disabled(!viewModel.levels[startIndex + index].levelPass)
                        }
                    }.frame(width: 550)
                    
                    
                    if (currentPage + 1) * levelsPerPage < viewModel.levels.count {
                        Button(action: {
                            withAnimation {
                                currentPage += 1
                            }
                        }) {
                            Image(.levelArrow)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                        }
                    } else {
                        Image(.levelArrow)
                            .resizable()
                            .scaledToFit()
                            .rotationEffect(Angle(degrees: 180))
                            .frame(height: 80)
                            .opacity(0)
                    }
                    
                }.padding(.horizontal)
//                ForEach(Range(0...viewModel.levels.count - 1)) { index in
//                    Text("\(index + 1)")
//                        .padding()
//                        .background(.white)
//                    
//                        .onTapGesture {
//                            DispatchQueue.main.async {
//                                currentLevel = viewModel.levels[index]
//                           }
//                            
//                           
//                            openLevel = true
//                            
//                        }
//                }
            }
            
            VStack {
                HStack {
                    
                    Button {
                       presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(.backIconFC)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 60)
                    }
                    Spacer()
                }
                Spacer()
            }.padding()
        }
        .background(
            Image(.bgFC)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .blur(radius: 4)
            
        )
        .fullScreenCover(isPresented: $openLevel) {
            if let level = currentLevel {
                GameView(game: GameModel(level: level), shopVM: shopVM, backBtnHandle: {
                    currentLevel = nil
                }, gameWonHandle: {
                    viewModel.levelUp(index: level.num)
                })
            } else {
                VStack {
                    HStack {
                        Spacer()
                    }
                    Spacer()
                }.background(
                    Image(.bgFC)
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                        .blur(radius: 4)
                    
                )
            }
        }
    }
}

#Preview {
    FCTrapSweeperGameView(shopVM: FCShopViewModel())
}

