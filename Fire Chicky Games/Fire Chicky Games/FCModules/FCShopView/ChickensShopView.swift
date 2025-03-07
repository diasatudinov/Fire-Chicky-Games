import SwiftUI

struct ChickensShopView: View {
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
                        if let item = shopVM.currentChicken {
                            Image("\(item.design)_gameChichenFC")
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
                            ForEach(0..<8, id: \.self) { index in
                                
                                Button(action: {
//                                        DispatchQueue.main.async {
//                                            currentLevel = viewModel.levels[startIndex + index]
//                                       }
                                        
//                                        openLevel = true
                                }) {
                                    Button {
                                        if index < shopVM.shopItems.filter({ $0.type == .chicken}).count {
                                            if shopVM.boughtItems.contains(shopVM.shopItems[index].name) {
                                                shopVM.currentChicken = shopVM.shopItems[index]
                                            } else {
                                                if FCUserCoins.shared.coins >= shopVM.shopItems[index].price {
                                                    shopVM.boughtItems.append(shopVM.shopItems[index].name)
                                                    FCUserCoins.shared.minusUserCoins(for: shopVM.shopItems[index].price)
                                                }
                                            }
                                            
                                        }
                                    } label: {
                                        ZStack {
                                            
                                            Image(.cellBgFC)
                                                .resizable()
                                                .scaledToFit()
                                            if index < shopVM.shopItems.filter({ $0.type == .chicken}).count {
                                                Image("\(shopVM.shopItems[index].design)_gameChichenFC")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .padding(24)
                                            }
                                            
                                            VStack {
                                                Spacer()
                                                if shopVM.boughtItems.contains(shopVM.shopItems[index].name) {
                                                    if let item = shopVM.currentChicken, item.name == shopVM.shopItems[index].name {
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
    ChickensShopView(shopVM: FCShopViewModel())
}
