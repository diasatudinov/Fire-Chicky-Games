//
//  SettingsViewModel.swift
//  Fire Chicky Games
//
//  Created by Dias Atudinov on 06.03.2025.
//


import SwiftUI

class SettingsViewModel: ObservableObject {
    @AppStorage("soundEnabled") var soundEnabled: Bool = true
    @AppStorage("musicEnabled") var musicEnabled: Bool = true
}