//
//  FCSettingsView.swift
//  Fire Chicky Games
//
//  Created by Dias Atudinov on 06.03.2025.
//

import SwiftUI
import StoreKit

struct FCSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var settings: FCSettingsViewModel
    
    var body: some View {
        ZStack {
            
            ZStack {
                Image(.settingsBgFC)
                    .resizable()
                    .scaledToFit()
                HStack(spacing: 0) {
                    VStack {
                        HStack {
                            Image(.soundIconFC)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                            
                            VStack {
                                Button {
                                    withAnimation {
                                        settings.soundEnabled.toggle()
                                    }
                                } label: {
                                    if settings.soundEnabled {
                                        Image(.onIconFC)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 54)
                                    } else {
                                        Image(.offIconFC)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 54)
                                    }
                                }
                            }
                            
                            
                        }
                        
                        HStack {
                            Image(.vibraIconFC)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                            
                            VStack {
                                Button {
                                    withAnimation {
                                        settings.vibraEnabled.toggle()
                                    }
                                } label: {
                                    if settings.vibraEnabled {
                                        Image(.onIconFC)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 54)
                                    } else {
                                        Image(.offIconFC)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 54)
                                    }
                                }
                            }
                            
                            
                        }
                        
                        HStack {
                            Image(.musicIconFC)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                            
                            VStack {
                                Button {
                                    withAnimation {
                                        settings.musicEnabled.toggle()
                                    }
                                } label: {
                                    if settings.musicEnabled {
                                        Image(.onIconFC)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 54)
                                    } else {
                                        Image(.offIconFC)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 54)
                                    }
                                }
                            }
                            
                            
                        }
                    }.padding(.leading)
                    Spacer()
                    VStack {
                        Image(.xmarkFC)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 70)
                            .offset(x: 50, y: -20)
                        Spacer()
                        Button {
                            rateUs()
                        } label: {
                            
                            Image(.rateUsIconFC)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 120)
                                
                        }.offset(x: 50, y: -20)
                        Spacer()
                        
                    }
                }
                
            }.frame(width: 300, height: 300)
            
            
            VStack {
                ZStack {
                    
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            ZStack {
                                Image(.backIconFC)
                                    .resizable()
                                    .scaledToFit()
                                
                            }.frame(height: 75)
                            
                        }
                        Spacer()
                        
                    }.padding()
                }
                Spacer()
            }
        }.background(
            Image(.bgFC)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .blur(radius: 4)
            
        )
    }
    
    func rateUs() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}

#Preview {
    FCSettingsView(settings: FCSettingsViewModel())
}
