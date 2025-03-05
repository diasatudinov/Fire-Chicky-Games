//
//  FCRulesView.swift
//  Fire Chicky Games
//
//  Created by Dias Atudinov on 04.03.2025.
//

import SwiftUI

struct FCRulesView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            ZStack {
                VStack {
                    Image(.rulesDeskFC)
                        .resizable()
                        .scaledToFit()
                }
                
                VStack {
                    HStack {
                        Spacer()
                        Image(.xmarkFC)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                            .offset(x: 10, y: 20)
                    }
                    
                    Spacer()
                }
            }.frame(width: UIScreen.main.bounds.width / 2)
            .padding(.vertical, 32)
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
}

#Preview {
    FCRulesView()
}
