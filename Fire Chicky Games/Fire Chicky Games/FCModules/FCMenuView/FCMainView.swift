//
//  FCMainView.swift
//  Fire Chicky Games
//
//  Created by Dias Atudinov on 06.03.2025.
//

import SwiftUI

struct FCMainView: View {
    @State private var showGames = false
    @State private var showInfo = false
    @State private var showShop = false
    @State private var showSettings = false
    
    @StateObject var settingsVM = FCSettingsViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                
                    ZStack {
                        VStack(spacing: 0) {
                            
                            VStack(spacing: 0) {
                                Text("score")
                                    .font(.system(size: 20, weight: .black))
                                    .foregroundStyle(.white)
                                    .textCase(.uppercase)
                                ZStack {
                                    Image(.scoreBgFC)
                                        .resizable()
                                        .scaledToFit()
                                    Text("0000")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundStyle(.white)
                                        .textCase(.uppercase)
                                }.frame(height: 35)
                            }
                            Spacer()
                            ZStack {
                                
                                HStack {
                                    Spacer()
                                    Image(.logoFC)
                                        .resizable()
                                        .scaledToFit()
                                    
                                    Spacer()
                                }
                                
                                
                                VStack {
                                    Spacer()
                                    Button {
                                        showGames = true
                                    } label: {
                                        Image(.startBtnFC)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 70)
                                    }.offset(y: 20)
                                }
                            }.frame(height: 230)
                            Spacer()
                            VStack(spacing: 0) {
                                Text("max score")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundStyle(.white)
                                    .textCase(.uppercase)
                                
                                Text("xxxx")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundStyle(.white)
                                    .textCase(.uppercase)
                                
                            }.offset(y: 10)
                            
                        }
                        
                        
                        VStack {
                            HStack {
                                ZStack {
                                    Image(.eggsBgFC)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 50)
                                    
                                    Text("15")
                                        .font(.system(size: 20, weight: .black))
                                        .foregroundStyle(.white)
                                        .textCase(.uppercase)
                                        .offset(x: 7)
                                }
                                
                                Spacer()
                                Button {
                                    showSettings = true
                                } label: {
                                    Image(.settingsIconFC)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 70)
                                }
                                
                            }
                            Spacer()
                            HStack {
                                
                                Button {
                                    showShop = true
                                } label: {
                                    Image(.shopIconFC)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 70)
                                }
                                
                                Spacer()
                                
                                Button {
                                    showInfo = true
                                } label: {
                                    Image(.rulesIconFC)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 70)
                                }
                                
                            }
                            
                        }
                            
                        
                    }
                
            }.padding()
            .background(
                Image(.bgFC)
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                    .blur(radius: 4)
                
            )
//            .onAppear {
//                if settingsVM.musicEnabled {
//                    SongsManager.shared.playBackgroundMusic()
//                }
//            }
//            .onChange(of: settingsVM.musicEnabled) { enabled in
//                if enabled {
//                    SongsManager.shared.playBackgroundMusic()
//                } else {
//                    SongsManager.shared.stopBackgroundMusic()
//                }
//            }
            .fullScreenCover(isPresented: $showGames) {
                FCTrapSweeperGameView()
            }
            .fullScreenCover(isPresented: $showInfo) {
                FCRulesView()
            }
            
            .fullScreenCover(isPresented: $showSettings) {
                FCSettingsView(settings: settingsVM)
                
            }
            
        }
    }
}

#Preview {
    FCMainView()
}
