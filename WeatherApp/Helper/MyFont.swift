import SwiftUI

enum MyFont: String {
    case futura = "Futura"
    func size(_ size: CGFloat) -> Font {
        .custom(self.rawValue, size: size)
    }
}
