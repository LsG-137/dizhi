import SwiftUI

struct ProvinceDetailView: View {
    let province: String
    @StateObject private var dataProvider = DataProvider.shared
    @State private var selectedCategory: PlaceCategory? = nil
    @State private var places: [Place] = []

    var body: some View {
        List {
            // 省份统计
            Section {
                let stats = dataProvider.provinceStatistics(for: province)
                VStack(alignment: .leading, spacing: 12) {
                    Text("\(province) · 共 \(stats.total) 处")
                        .font(.serifTitle())
                        .foregroundColor(AppColors.inkPrimary)

                    HStack {
                        Text("已走过 \(stats.visited) 处")
                            .font(.subheadline)
                            .foregroundColor(AppColors.visitedCyan)

                        Spacer()

                        if stats.total > 0 {
                            Text("\(Int(Double(stats.visited) / Double(stats.total) * 100))%")
                                .font(.serifHeadline())
                                .foregroundColor(AppColors.visitedCyan)
                        }
                    }

                    if stats.total > 0 {
                        VisitProgressBar(progress: Double(stats.visited) / Double(stats.total))
                    }
                }
                .padding(.vertical, 8)
            }

            // 筛选器
            Section(header: Text("按类型筛选").font(.serifHeadline())) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        // 全部按钮
                        CategoryFilterButton(
                            category: nil,
                            emoji: "全部",
                            isSelected: selectedCategory == nil,
                            action: { selectedCategory = nil }
                        )

                        // 各个类别
                        ForEach(PlaceCategory.allCases, id: \.self) { category in
                            let placesInCategory = places.filter { $0.category == category }
                            if !placesInCategory.isEmpty {
                                CategoryFilterButton(
                                    category: category,
                                    emoji: category.emoji,
                                    isSelected: selectedCategory == category,
                                    action: { selectedCategory = category }
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 4)
                    .padding(.vertical, 8)
                }
                .listRowInsets(EdgeInsets())
            }

            // 地点列表（按类别分组）
            ForEach(groupedPlaces.keys.sorted { $0.rawValue < $1.rawValue }, id: \.self) { category in
                let placesInCategory = groupedPlaces[category] ?? []
                if !placesInCategory.isEmpty && (selectedCategory == nil || selectedCategory == category) {
                    Section(header: Text("\(category.emoji) \(category.rawValue)").font(.serifHeadline())) {
                        ForEach(placesInCategory) { place in
                            NavigationLink(destination: PlaceDetailView(place: place)) {
                                PlaceRow(place: place)
                            }
                            .listRowBackground(AppColors.paperBackground)
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(province)
        .navigationBarTitleDisplayMode(.inline)
        .paperBackground()
        .onAppear {
            places = dataProvider.places(for: province)
        }
    }

    private var groupedPlaces: [PlaceCategory: [Place]] {
        Dictionary(grouping: places) { $0.category }
    }
}

struct CategoryFilterButton: View {
    let category: PlaceCategory?
    let emoji: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Text(emoji)
                if let category = category {
                    Text(category.rawValue)
                        .font(.caption)
                } else {
                    Text("全部")
                        .font(.caption)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? AppColors.visitedCyan.opacity(0.2) : AppColors.borderGray.opacity(0.3))
            .foregroundColor(isSelected ? AppColors.visitedCyan : AppColors.inkSecondary)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(isSelected ? AppColors.visitedCyan.opacity(0.5) : Color.clear, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct PlaceRow: View {
    let place: Place

    var body: some View {
        HStack(spacing: 12) {
            // 左侧类型emoji和边框
            VStack {
                Text(place.category.emoji)
                    .font(.title3)
                Spacer()
            }
            .frame(width: 30)
            .overlay(
                Rectangle()
                    .fill(place.isOwn ? AppColors.visitedCyan : AppColors.inkSecondary)
                    .frame(width: 2)
                    .opacity(0.6),
                alignment: .leading
            )

            // 中间：名称和描述
            VStack(alignment: .leading, spacing: 4) {
                Text(place.name)
                    .font(.headline)
                    .foregroundColor(AppColors.inkPrimary)
                    .lineLimit(1)

                Text(place.description)
                    .font(.caption)
                    .foregroundColor(AppColors.inkSecondary)
                    .lineLimit(2)
            }

            Spacer()

            // 右侧：访问状态
            if place.isVisited {
                VStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(AppColors.visitedCyan)
                        .font(.title3)
                    Text("到过")
                        .font(.caption2)
                        .foregroundColor(AppColors.visitedCyan)
                }
            } else {
                Circle()
                    .fill(AppColors.vermillion)
                    .frame(width: 12, height: 12)
            }
        }
        .padding(.vertical, 8)
    }
}

struct ProvinceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProvinceDetailView(province: "云南")
        }
    }
}