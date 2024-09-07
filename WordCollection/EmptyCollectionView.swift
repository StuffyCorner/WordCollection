import SwiftUI

struct EmptyCollectionView: View {
    @Binding var addWord: Bool
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "link.badge.plus")
                .font(.largeTitle)
            VStack(spacing: 5) {
                Text("Коллекция пуста")
                    .font(.headline)
                    .fontWeight(.medium)
                Text("Нажмите, чтобы добавить первое слово в коллекцию")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.horizontal, 40)
        .onTapGesture {
            addWord.toggle()
        }
    }
}
