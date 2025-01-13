import SwiftUI

struct MessageItemModel: Identifiable {
    let id = UUID()
    let text: LocalizedStringKey
    let color: Color
}
