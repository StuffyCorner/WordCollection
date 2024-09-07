import SwiftUI
import Combine

struct AddWordView: View {
    @ObservedObject var viewModel = WordListViewModel.shared
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.addingStage == .word {
                    AddWordViewForm()
                        .transition(.move(edge: .leading))
                } else if viewModel.addingStage == .translation {
                    AddTranslationViewForm()
                        .transition(.move(edge: .leading))
                }
            }
            .animation(.easeInOut, value: viewModel.addingStage)
            .navigationTitle("Добавить слово")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.gray.opacity(0.5))
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
            .onDisappear {
                viewModel.wordTerm = ""
                viewModel.translationTerm = ""
                viewModel.addingStage = .word
            }
        }
    }
}

struct AddWordViewForm: View {
    @ObservedObject var viewModel = WordListViewModel.shared

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                TextField("Введите слово", text: $viewModel.wordTerm, axis: .vertical)
                    .font(.system(size: 30, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.indigo)
                    .padding(30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .bottom) {
                VStack {
                    if !viewModel.wordTerm.isEmpty {
                        Button {
                            viewModel.addingStage = .translation
                        } label: {
                            HStack(spacing: 10) {
                                Text("Далее")
                                Image(systemName: "arrow.right")
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
                .animation(.easeInOut(duration: 0.2), value: viewModel.wordTerm)
            }
        }
    }
}

struct AddTranslationViewForm: View {
    @ObservedObject var viewModel = WordListViewModel.shared
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.translationSuggestion)
                .font(.headline)
                .padding()

            TextField("Введите перевод", text: $viewModel.translationTerm, axis: .vertical)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundStyle(.indigo)
                .padding(30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            Task {
                await viewModel.performTranslation()
            }
        }
        .overlay(alignment: .bottom) {
            HStack(spacing: 20) {
                Button {
                    viewModel.addingStage = .word
                } label: {
                    HStack(spacing: 10) {
                        Text("Назад")
                    }
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 30)
                    .background(.indigo.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                
                if !viewModel.translationTerm.isEmpty {
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.words.append(Word(
                                word: viewModel.wordTerm,
                                translate: viewModel.translationTerm,
                                collectionId: "1"))
                        }
                        dismiss()
                    } label: {
                        HStack(spacing: 10) {
                            Text("Добавить")
                            Image(systemName: "arrow.right")
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
            .animation(.easeInOut(duration: 0.2), value: viewModel.translationTerm)
        }
    }
}

#Preview {
    AddWordView()
}
