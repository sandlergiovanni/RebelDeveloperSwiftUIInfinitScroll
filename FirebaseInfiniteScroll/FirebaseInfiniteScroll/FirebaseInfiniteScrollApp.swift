import SwiftUI

@main
struct FirebaseInfiniteScrollApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var textSearch = ""
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .tint(.white)
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
