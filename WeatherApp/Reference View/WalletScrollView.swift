import SwiftUI

struct WalletScrollView: View {
    var body: some View {
        ScrollView {
            ForEach(0...20, id: \.self) { item in
                Text("Card \(item)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 380, height: 100)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow]),
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
                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.9)
                                    .offset(y: phase == .bottomTrailing ? 40 : 0)
                                    .rotation3DEffect(
                                        .degrees(phase == .bottomTrailing ? -5 : 0),
                                        axis: (x: 1, y: 0, z: 0)
                                    )
                                    .opacity(phase == .bottomTrailing ? 0.7 : 1)
                                    
                            }
                        
                    
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 4)
            }
        }
    }
}

#Preview {
    WalletScrollView()
}
