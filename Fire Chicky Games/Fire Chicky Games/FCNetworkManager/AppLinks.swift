//
//  AppLinks.swift
//  Fire Chicky Games
//
//  Created by Dias Atudinov on 06.03.2025.
//


import SwiftUI

class AppLinks {
    
    static let shared = AppLinks()
    
    static let winStarData = "https://firechickygames.top/get"
    
    @AppStorage("finalUrl") var finalURL: URL?
    
    
}
