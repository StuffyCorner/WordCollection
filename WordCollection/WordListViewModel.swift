import Foundation
import SwiftUI
import Combine
import LibreTranslate

struct Word: Identifiable {
    let id = UUID().uuidString
    var word: String
    var translate: String
    let collectionId: String
}

class WordListViewModel: ObservableObject {
    static let shared = WordListViewModel()
    
    @Published var words: [Word] = [Word(word: "Привет", translate: "Hello", collectionId: "1"), Word(word: "Я тебя не понимаю", translate: "I don't understand you", collectionId: "1")]
    
    @Published var redactedWords: Set<String> = []
    @Published var chosenWords: [Word] = []
    
    @Published var wordTerm: String = ""
    @Published var translationTerm: String = ""
    @Published var translationSuggestion: String = ""
    
    @State private var cancellable: AnyCancellable?
    
    enum AddingStage: CaseIterable {
        case word, translation, success
    }
    @Published var addingStage: AddingStage = .word
    
    func toggleChoice(_ word: Word) {
        if chosenWords.contains(where: { word.id == $0.id }) {
            if let index = chosenWords.firstIndex(where: { word.id == $0.id }) {
                chosenWords.remove(at: index)
            }
        } else {
            chosenWords.append(word)
        }
    }
    
    func deleteChosenWords() {
        words.removeAll { word in
            chosenWords.contains(where: { $0.id == word.id })
        }
        chosenWords.removeAll()
    }
    
    func hideAllTranslations() {
        redactedWords = Set(words.map { $0.id })
    }
    
    func unhideAllTranslations() {
        redactedWords.removeAll()
    }
    
    @Published var translator = Translator("https://libretranslate.com")
    
    func performTranslation() async {
        do {
            // Use the wordTerm to translate into the desired language
            let translationResult = try await translator.translate(wordTerm, from: "ru", to: "en")
            DispatchQueue.main.async {
                self.translationSuggestion = translationResult // Update the suggestion with the result
            }
        } catch {
            print("Translation failed with error: \(error.localizedDescription)")
            // Handle error appropriately, e.g., show an error message
        }
    }
}
