import Foundation

struct Place: Identifiable, Codable {
    var id: UUID
    var name: String
    var province: String
    var category: PlaceCategory
    var description: String  // 一句话气质描述，不是攻略
    var isVisited: Bool
    var isOwn: Bool  // true = 自己收藏的，false = 推荐的
    var address: String?

    init(id: UUID = UUID(), name: String, province: String, category: PlaceCategory, description: String, isVisited: Bool = false, isOwn: Bool, address: String? = nil) {
        self.id = id
        self.name = name
        self.province = province
        self.category = category
        self.description = description
        self.isVisited = isVisited
        self.isOwn = isOwn
        self.address = address
    }
}

enum PlaceCategory: String, Codable, CaseIterable {
    case cave = "石窟"
    case temple = "寺庙"
    case ancient = "古城遗址"
    case nature = "山水自然"
    case museum = "博物馆"
    case heritage = "世界遗产"
    case overseas = "境外"

    var emoji: String {
        switch self {
        case .cave: "🪨"
        case .temple: "⛩"
        case .ancient: "🏯"
        case .nature: "🏔"
        case .museum: "🏛"
        case .heritage: "🌍"
        case .overseas: "✈️"
        }
    }

    var colorHex: String {
        switch self {
        case .cave: "#8A7F72"  // 灰色
        case .temple: "#C0392B" // 朱砂红
        case .ancient: "#1A1A1A" // 墨色
        case .nature: "#2E86AB" // 青色
        case .museum: "#8A7F72" // 灰色
        case .heritage: "#C0392B" // 朱砂红
        case .overseas: "#1A1A1A" // 墨色
        }
    }
}

extension PlaceCategory {
    static func from(rawValue: String) -> PlaceCategory {
        return PlaceCategory(rawValue: rawValue) ?? .nature
    }
}