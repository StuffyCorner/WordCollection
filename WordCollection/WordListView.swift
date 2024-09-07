import SwiftUI

struct WordListView: View {
    @ObservedObject var viewModel = WordListViewModel.shared
    @Binding var changePlace: Bool
    @Binding var addWord: Bool
    @Binding var isChoosing: Bool
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 0) {
                Text("Слово")
                    .padding(.leading, 10)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Перевод")
                    .padding(.leading, 20)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            VStack(spacing: 8) {
                ForEach(viewModel.words, id: \.id) { word in
                    WordCardView(changePlace: $changePlace, isChoosing: $isChoosing, word: word)
                }
            }
            
            if !isChoosing {
                Button {
                    addWord.toggle()
                } label: {
                    Label("Добавить", systemImage: "plus")
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .layoutPriority(1)
                        .background(.indigo)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            }
        }
        .animation(.spring(duration: 0.2), value: isChoosing)
        .padding(.horizontal)
        .padding(.top, 30)
        .padding(.bottom, 70)
    }
}
