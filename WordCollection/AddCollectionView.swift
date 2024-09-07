import SwiftUI

struct AddCollectionView: View {
    @ObservedObject var viewModel = CollectionViewModel.shared
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedLanguage = "Нет языка"
    
    let languages = ["Нет языка", "Английский язык"]

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack(spacing: 20) {
                    Picker("Выберите язык", selection: $selectedLanguage) {
                        ForEach(languages, id: \.self) { language in
                            Text(language)
                        }
                    }
                    .pickerStyle(.menu)
                    .padding(.horizontal)

                    VStack(spacing: 0) {
                        TextField("Введите название", text: $viewModel.collectionTerm, axis: .vertical)
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.indigo)
                            .padding(30)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .overlay(alignment: .bottom) {
                    VStack {
                        if !viewModel.collectionTerm.isEmpty {
                            Button {
                                dismiss()
                            } label: {
                                HStack(spacing: 10) {
                                    Label("Создать коллекцию", systemImage: "rectangle.stack.fill.badge.plus")
                                }
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .padding(.vertical, 16)
                                .padding(.horizontal, 30)
                                .background(.indigo)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            }
                        }
                    }
                    .padding(.bottom, 12)
                    .animation(.easeInOut(duration: 0.2), value: viewModel.collectionTerm)
                    .onDisappear {
                        viewModel.collectionTerm = ""
                    }
                }
            }
        }
    }
}

#Preview {
    AddCollectionView()
}
