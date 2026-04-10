import SwiftUI

enum AppColors {
    // 背景色：宣纸色 #F5F0E8
    static let paperBackground = Color(hex: "#F5F0E8")

    // 主文字色：墨色 #1A1A1A
    static let inkPrimary = Color(hex: "#1A1A1A")

    // 次要文字：#8A7F72
    static let inkSecondary = Color(hex: "#8A7F72")

    // 强调色：朱砂红 #C0392B
    static let vermilion = Color(hex: "#C0392B")
static let vermillion = vermilion
    // 已访问标记色：青色 #2E86AB
    static let visitedCyan = Color(hex: "#2E86AB")

    // 边框色
    static let borderGray = Color(hex: "#E0DAD2")

    // 进度条背景
    static let progressBackground = Color(hex: "#EEE9E1")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = ((int >> 24) & 0xFF, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// 字体扩展
extension Font {
    static func serifTitle() -> Font {
        .system(.title, design: .serif).weight(.medium)
    }

    static func serifHeadline() -> Font {
        .system(.headline, design: .serif)
    }

    static func serifBody() -> Font {
        .system(.body, design: .serif)
    }
}

// 视图修饰器
struct PaperBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(AppColors.paperBackground)
    }
}

extension View {
    func paperBackground() -> some View {
        self.modifier(PaperBackgroundModifier())
    }
}

// 胶囊形标签样式
struct CapsuleTag: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(color.opacity(0.1))
            .foregroundColor(color)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(color.opacity(0.3), lineWidth: 1)
            )
    }
}

// 进度条视图
struct VisitProgressBar: View {
    let progress: Double // 0.0 到 1.0
    let height: CGFloat = 4

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(AppColors.progressBackground)
                    .frame(height: height)
                    .clipShape(Capsule())

                Rectangle()
                    .fill(AppColors.visitedCyan)
                    .frame(width: geometry.size.width * progress, height: height)
                    .clipShape(Capsule())
            }
        }
        .frame(height: height)
    }
}
