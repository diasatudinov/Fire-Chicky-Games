//
//  FCSettingsViewModel.swift
//  Fire Chicky Games
//
//  Created by Dias Atudinov on 06.03.2025.
//


import SwiftUI

class FCSettingsViewModel: ObservableObject {
    @AppStorage("soundEnabled") var soundEnabled: Bool = true
    @AppStorage("vibraEnabled") var vibraEnabled: Bool = true
    @AppStorage("musicEnabled") var musicEnabled: Bool = true
}
