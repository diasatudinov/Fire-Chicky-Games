import SwiftUI

@main
struct Fire_Chicky_GamesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            FirstView()
        }
    }
}
