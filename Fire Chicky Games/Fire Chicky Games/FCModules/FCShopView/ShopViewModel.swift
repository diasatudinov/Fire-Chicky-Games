//
//  ShopViewModel.swift
//  Fire Chicky Games
//
//  Created by Dias Atudinov on 07.03.2025.
//

import SwiftUI

enum ItemType: Codable {
    case flag, chicken
}


class FCShopViewModel: ObservableObject {
    @Published var shopItems: [Item] = [
        Item(type: .chicken, name: "gameChichenFC1", design: "type1", price: 15),
        Item(type: .chicken, name: "gameChichenFC2", design: "type2", price: 15),

        Item(type: .flag, name: "flagFC1", design: "type1", price: 15),
        Item(type: .flag, name: "flagFC2", design: "type2", price: 15),
        Item(type: .flag, name: "flagFC3", design: "type3", price: 15),
        Item(type: .flag, name: "flagFC4", design: "type4", price: 15),
        Item(type: .flag, name: "flagFC5", design: "type5", price: 15),
        Item(type: .flag, name: "flagFC6", design: "type6", price: 15),
        Item(type: .flag, name: "flagFC7", design: "type7", price: 15),
        Item(type: .flag, name: "flagFC8", design: "type8", price: 15),
    ]
    
    @Published var boughtItems: [String] = ["gameChichenFC1", "flagFC1"] {
        didSet {
            saveItems()
        }
    }
    
    
    @Published var currentChicken: Item? {
        didSet {
            saveChicken()
        }
    }
    
    @Published var currentFlag: Item? {
        didSet {
            saveFlag()
        }
    }
    
    init() {
        loadChicken()
        loadItems()
        loadFlag()
    }
    
    private let userDefaultsTeamKey = "boughtItem"
    private let userDefaultsItemsKey = "boughtItemArray"
    private let userDefaultsFlagKey = "boughtFlag"
    
    func saveChicken() {
        if let currentItem = currentChicken {
            if let encodedData = try? JSONEncoder().encode(currentItem) {
                UserDefaults.standard.set(encodedData, forKey: userDefaultsTeamKey)
            }
        }
    }
    
    func loadChicken() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsTeamKey),
           let loadedItem = try? JSONDecoder().decode(Item.self, from: savedData) {
            currentChicken = loadedItem
        } else {
            currentChicken = shopItems[0]
            print("No saved data found")
        }
    }
    
    func saveFlag() {
        if let currentItem = currentFlag {
            if let encodedData = try? JSONEncoder().encode(currentItem) {
                UserDefaults.standard.set(encodedData, forKey: userDefaultsFlagKey)
            }
        }
    }
    
    func loadFlag() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsFlagKey),
           let loadedItem = try? JSONDecoder().decode(Item.self, from: savedData) {
            currentFlag = loadedItem
        } else {
            currentFlag = shopItems[2]
            print("No saved data found")
        }
    }
    
    func saveItems() {
        
        if let encodedData = try? JSONEncoder().encode(boughtItems) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsItemsKey)
        }
        
    }
    
    func loadItems() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsItemsKey),
           let loadedItem = try? JSONDecoder().decode([String].self, from: savedData) {
            boughtItems = loadedItem
        } else {
            print("No saved data found")
        }
    }
    
}

struct Item: Codable, Hashable {
    var id = UUID()
    var type: ItemType
    var name: String
    var design: String
    var price: Int
}
