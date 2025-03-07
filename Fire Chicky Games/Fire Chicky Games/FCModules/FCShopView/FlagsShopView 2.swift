//
//  FlagsShopView.swift
//  Fire Chicky Games
//
//  Created by Dias Atudinov on 07.03.2025.
//

import SwiftUI

struct FlagsShopView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var shopVM: FCShopViewModel
    
    var body: some View {
        ZStack {
            
            VStack {
                HStack(spacing: 40) {
                    ZStack {
                        Image(.bigItemBgFC)
                            .resizable()
                            .scaledToFit()
                        if let item = shopVM.currentFlag {
                            Image("\(item.design)_flagFC")
                                .resizable()
                                .scaledToFit()
                                .padding(40)
                        }
                    }.frame(height: UIScreen.main.bounds.height / 2.4)
                    
                    ZStack {
                        Image(.itemsBgFC)
                            .resizable()
                            .scaledToFit()
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 4), spacing: 0) {
                            ForEach(2..<10, id: \.self) { index in
                                
                                    Button {
                                        if shopVM.boughtItems.contains(shopVM.shopItems[index].name) {
                                            shopVM.currentFlag = shopVM.shopItems[index]
                                        } else {
                                            if FCUserCoins.shared.coins >= shopVM.shopItems[index].price {
                                                shopVM.boughtItems.append(shopVM.shopItems[index].name)
                                                FCUserCoins.shared.minusUserCoins(for: shopVM.shopItems[index].price)
                                            }
                                        }
                                        
                                        
                                    } label: {
                                        ZStack {
                                            
                                            Image(.cellBgFC)
                                                .resizable()
                                                .scaledToFit()
                                            
                                            Image("\(shopVM.shopItems[index].design)_flagFC")
                                                .resizable()
                                                .scaledToFit()
                                                .padding(24)
                                            
                                            
                                            VStack {
                                                Spacer()
                                                if shopVM.boughtItems.contains(shopVM.shopItems[index].name) {
                                                    if let item = shopVM.currentFlag, item.name == shopVM.shopItems[index].name {
                                                        Image(.chooseIconBtn)
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(height: 25)
                                                    } else {
                                                        Image(.boughtIconFC)
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(height: 25)
                                                    }
                                                    
                                                    
                                                } else {
                                                    Image(.buyIconFC)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 25)
                                                }
                                            }
                                            
                                        }.frame(width: 80, height: 90)
                                    }
                                
                            }
                        }.frame(width: 320)
                        
                    }.frame(width: 350, height: UIScreen.main.bounds.height / 2)
                       
                    
                    
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
    FlagsShopView(shopVM: FCShopViewModel())
}
