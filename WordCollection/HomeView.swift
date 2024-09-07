import SwiftUI

struct HomeView: View {
    @State private var addWord: Bool = false
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true) {
                CollectionCardView()
                
                Button {
                    
                } label: {
                    HStack(alignment: .center, spacing: 10) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(.white)
                        Text("Добавить коллекцию")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(12)
                    .background(.gray.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Коллекции")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $addWord) {
                
            }
        }
    }
}

#Preview {
    HomeView()
}
