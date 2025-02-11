import SwiftUI

struct TLButton: View {
    let title: String
    let background: Color
    let action: () -> Void
    
    init(
        title: String,
        background: Color = .blue,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.background = background
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(background)
                .cornerRadius(10)
        }
    }
}

#Preview {
    TLButton(title: "Value", action: {})
} 