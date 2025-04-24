import SwiftUI

struct CardStackView: View {
    var body: some View {
        ScrollView {
            ForEach(0...20, id: \.self) { item in
                Text("Card \(item)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 380, height: 100)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue]),
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                    )
                    .cornerRadius(12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    }
                    .padding(.horizontal)
                    .scrollTransition { content, phase in
                        content
                            .scaleEffect(phase.isIdentity ? 1 : 0.8)
                            .offset(x: offset(for: phase))
                    }
                    .shadow(color: .pink.opacity(0.2), radius: 5, x: 0, y: 4)
            }
        }
    }

    func offset(for phase: ScrollTransitionPhase) -> Double {
        switch phase {
        case .topLeading:
            return -200
        case .identity:
            return 0
        case .bottomTrailing:
            return 200
        }
    }
}

#Preview {
    CardStackView()
}
