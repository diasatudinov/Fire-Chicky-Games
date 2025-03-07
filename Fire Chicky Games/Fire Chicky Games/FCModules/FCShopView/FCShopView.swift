//
//  FCShopView.swift
//  Fire Chicky Games
//
//  Created by Dias Atudinov on 07.03.2025.
//

import SwiftUI

struct FCShopView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var shopVM: FCShopViewModel
    
    @State private var showSkins = false
    @State private var showFlags = false
    
    var body: some View {
        ZStack {
            
            VStack {
                HStack(spacing: 40) {
                    Button {
                        showSkins = true
                    } label: {
                        Image(.chickensIconFC)
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIScreen.main.bounds.height / 1.7)
                    }
                    
                    Button {
                        showFlags = true
                    } label: {
                        Image(.flagsIconFC)
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIScreen.main.bounds.height / 1.7)
                    }
                }
            }
            
            
            
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
                        
                        FCCoinsView()
                        
                    }.padding()
                }
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $showSkins) {
            ChickensShopView(shopVM: shopVM)
        }
        .fullScreenCover(isPresented: $showFlags) {
            FlagsShopView(shopVM: shopVM)
        }
        .background(
            Image(.bgFC)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .blur(radius: 4)
            
        )
    }
}

#Preview {
    FCShopView(shopVM: FCShopViewModel())
}
