import SwiftUI

struct CollectionInteractionView: View {
    @ObservedObject var viewModel = WordListViewModel.shared
    @Binding var isChoosing: Bool
    var body: some View {
        HStack(spacing: 10) {
            if !isChoosing {
                Button {
                    withAnimation(.spring(duration: 0.2)) {
                        viewModel.words.shuffle()
                    }
                } label: {
                    Label("Перемешать", systemImage: "shuffle")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                        .frame(height: 50)
                        .background(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                
                Button {
                    if viewModel.redactedWords.count == viewModel.words.count {
                        viewModel.unhideAllTranslations()
                    } else {
                        viewModel.hideAllTranslations()
                    }
                } label: {
                    Label(viewModel.redactedWords.count == viewModel.words.count ? "Показать перевод" : "Скрыть перевод", systemImage: "sparkles")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(.indigo)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            } else {
                Button {
                    viewModel.deleteChosenWords()
                    isChoosing.toggle()
                } label: {
                    Label("Удалить", systemImage: "trash.fill")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(viewModel.chosenWords.isEmpty ? .gray : .red)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.vertical)
        .background(.ultraThinMaterial)
        .transition(.move(edge: .bottom))
        .animation(.easeInOut(duration: 0.2), value: isChoosing)
    }
}
