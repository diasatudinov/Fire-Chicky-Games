//
//  AppDelegate.swift
//  Fire Chicky Games
//
//  Created by Dias Atudinov on 06.03.2025.
//


import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var orientationLock: UIInterfaceOrientationMask = .all

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}