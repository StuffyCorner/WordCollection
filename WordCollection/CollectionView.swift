import SwiftUI

struct CollectionView: View {
    @ObservedObject var viewModel = WordListViewModel.shared
    @State private var addWord: Bool = false
    @State private var changePlace: Bool = false
    @State private var isChoosing: Bool = false
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if viewModel.words.isEmpty {
                    EmptyCollectionView(addWord: $addWord)
                } else {
                    VStack(spacing: 0) {
                        ZStack(alignment: .bottom) {
                            ScrollView(.vertical, showsIndicators: true) {
                                
                                WordListView(changePlace: $changePlace, addWord: $addWord, isChoosing: $isChoosing)
                            }
                            
                            CollectionInteractionView(isChoosing: $isChoosing)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemGray6))
            .navigationTitle("Английский язык")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $addWord) {
                AddWordView()
                    .presentationCornerRadius(25)
                    .presentationDetents([.large])
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if !isChoosing && !viewModel.words.isEmpty {
                        HStack {
                            Button {
                                withAnimation(.spring(duration: 0.2)) {
                                    changePlace.toggle()
                                }
                            } label: {
                                Image(systemName: "arrow.left.arrow.right")
                                    .fontWeight(.medium)
                                    .font(.caption)
                                    .foregroundStyle(.indigo)
                            }
                            
                            Menu {
                                Button {
                                    isChoosing.toggle()
                                } label: {
                                    Label("Выбрать", systemImage: "checkmark.circle")
                                }
                            } label: {
                                Image(systemName: "ellipsis.circle")
                                    .fontWeight(.medium)
                                    .font(.subheadline)
                                    .foregroundStyle(.indigo)
                            }
                        }
                    } else if isChoosing && !viewModel.words.isEmpty{
                        Button("Скрыть") {
                            isChoosing.toggle()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CollectionView()
}
