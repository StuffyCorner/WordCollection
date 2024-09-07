import Foundation

struct Collection: Identifiable {
    var id = UUID().uuidString
    var words: [Word]
    var language: String
}

class CollectionViewModel: ObservableObject {
    static let shared = CollectionViewModel()
    
    @Published var collectionTerm: String = ""
}
