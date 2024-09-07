import SwiftUI

struct EditWordView: View {
    @ObservedObject var viewModel = WordListViewModel.shared
    @Environment(\.dismiss) var dismiss
    var word: Word

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                VStack(spacing: 8) {
                    Text("Отредактируйте слово")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .fontWeight(.medium)
                        .padding(.leading, 10)
                    TextField("Отредактируйте слово", text: $viewModel.wordTerm)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 14)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                
                VStack(spacing: 8) {
                    Text("Отредактируйте перевод")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .fontWeight(.medium)
                        .padding(.leading, 10)
                    TextField("Отредактируйте перевод", text: $viewModel.translationTerm)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 14)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal)
            .background(Color(UIColor.systemGray6))
            .onAppear {
                viewModel.wordTerm = word.word
                viewModel.translationTerm = word.translate
            }
            .onDisappear {
                viewModel.wordTerm = ""
                viewModel.translationTerm = ""
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Готово") {
                        if let index = viewModel.words.firstIndex(where: { $0.id == word.id }) {
                            viewModel.words[index] = Word(
                                word: viewModel.wordTerm,
                                translate: viewModel.translationTerm,
                                collectionId: word.collectionId
                            )
                        }
                        dismiss()
                    }
                }
            }
        }
    }
}
