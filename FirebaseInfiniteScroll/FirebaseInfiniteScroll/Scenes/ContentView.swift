import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    @State private var limit = 1
    
    @FirestoreQuery(collectionPath: "userTasks", predicates:[.limit(to: 1)])
    private var todoList: [UserTasks]
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
