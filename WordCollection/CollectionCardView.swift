import SwiftUI

struct CollectionCardView: View {
    var body: some View {
        NavigationLink {
            CollectionView()
        } label: {
            VStack(alignment: .leading, spacing: 0) {
                Text("Английский язык")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Text("10 слов")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundStyle(.white.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .padding(.horizontal)
        }
    }
}

#Preview {
    CollectionCardView()
}
