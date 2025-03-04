//
//  LoaderView.swift
//  Fire Chicky Games
//
//  Created by Dias Atudinov on 04.03.2025.
//

import SwiftUI

struct LoaderView: View {
    @State private var progress: Double = 0.0
    @State private var timer: Timer?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                VStack {
                    Spacer()
                    ZStack {
                        VStack(spacing: 50) {
                            Image(.chickenFC)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                        VStack(spacing: 16) {
                            
                            Image(.loadingTextFC)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 25)
                            
                            HStack {
                                Spacer()
                                ZStack {
                                    ProgressView(value: progress, total: 100)
                                        .progressViewStyle(LinearProgressViewStyle())
                                        .accentColor(Color.yellowFC)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.black, lineWidth: 0.5)
                                        }
                                        .scaleEffect(y: 3.0, anchor: .center)
                                        .padding(8)
                                        .background(.purpleFC)
                                        .cornerRadius(5)
                                }.frame(width: UIScreen.main.bounds.width / 2.5)
                                
                                Spacer()
                            }
                        }
                    }
                    }
                    .foregroundColor(.black)
                    .padding(.bottom, 25)
                }
            }.background(
                Image(.bgFC)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .blur(radius: 4)
                
            )
            .onAppear {
                startTimer()
            }
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            if progress < 100 {
                progress += 1
            } else {
                timer.invalidate()
            }
        }
    }
}


#Preview {
    LoaderView()
}
