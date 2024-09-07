import SwiftUI

struct WordCardView: View {
    @ObservedObject var viewModel = WordListViewModel.shared
    @Binding var changePlace: Bool
    @Binding var isChoosing: Bool
    var word: Word
    @State private var wordPreferences: Bool = false
    @State private var editWord: Bool = false
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if isChoosing {
                Image(systemName: viewModel.chosenWords.contains(where: { word.id == $0.id }) ? "checkmark.circle.fill" : "circle")
                    .symbolEffect(.bounce, options: .speed(3), value: viewModel.chosenWords.contains(where: { word.id == $0.id }))
                    .foregroundStyle(viewModel.chosenWords.contains(where: { word.id == $0.id }) ? .indigo : .gray)
                    .font(.title)
            }
            Text(changePlace ? word.translate : word.word)
                .padding(.horizontal, 10)
                .padding(.vertical, 12)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            Text(changePlace ? word.word : word.translate)
                .padding(.horizontal, 10)
                .padding(.vertical, 12)
                .multilineTextAlignment(.leading)
                .redacted(reason: viewModel.redactedWords.contains(word.id) ? .placeholder : [])
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(UIColor.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .onTapGesture {
                    if viewModel.redactedWords.contains(word.id) {
                        viewModel.redactedWords.remove(word.id)
                    } else {
                        wordPreferences.toggle()
                    }
                }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .animation(.spring(duration: 0.1), value: viewModel.redactedWords)
        .animation(.spring(duration: 0.2), value: isChoosing)
        .onTapGesture {
            if isChoosing {
                viewModel.toggleChoice(word)
            }
        }
        .confirmationDialog("Что вы хоите сделать с этим переводом?", isPresented: $wordPreferences, titleVisibility: .visible) {
            Button("Редактировать") {
                editWord.toggle()
            }
            
            Button("Удалить", role: .destructive) {
                withAnimation(.spring(duration: 0.2)) {
                    if let index = viewModel.words.firstIndex(where: { $0.id == word.id }) {
                        viewModel.words.remove(at: index)
                    }
                }
            }
        }
        .sheet(isPresented: $editWord) {
            EditWordView(word: word)
                .presentationDetents([.medium])
                .presentationCornerRadius(25)
        }
    }
}
