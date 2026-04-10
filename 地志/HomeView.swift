import SwiftUI

struct HomeView: View {
    @StateObject private var dataProvider = DataProvider.shared
    @State private var provinces: [String] = []

    var body: some View {
        NavigationView {
            List {
                // 全局统计
                Section {
                    VStack(alignment: .leading, spacing: 12) {
                        let stats = dataProvider.statistics()
                        Text("共 \(stats.total) 处 · 走过 \(stats.visited) 处 · 还有 \(stats.notVisited) 处在等你")
                            .font(.serifBody())
                            .foregroundColor(AppColors.inkPrimary)

                        HStack {
                            Text("你的旅行足迹")
                                .font(.headline)
                                .foregroundColor(AppColors.inkSecondary)

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

                // 省份列表
                Section(header: Text("所有省份").font(.serifHeadline())) {
                    ForEach(provinces, id: \.self) { province in
                        NavigationLink(destination: ProvinceDetailView(province: province)) {
                            ProvinceRow(province: province)
                        }
                        .listRowBackground(AppColors.paperBackground)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("地志")
            .navigationBarTitleDisplayMode(.large)
            .paperBackground()
            .onAppear {
                provinces = dataProvider.allProvinces()
            }
        }
    }
}

struct ProvinceRow: View {
    let province: String
    @StateObject private var dataProvider = DataProvider.shared

    var body: some View {
        let stats = dataProvider.provinceStatistics(for: province)

        VStack(alignment: .leading, spacing: 8) {
            // 省份名和统计
            HStack {
                Text(province)
                    .font(.serifHeadline())
                    .foregroundColor(AppColors.inkPrimary)

                Spacer()

                // 类型色点
                let categories = Set(dataProvider.places(for: province).map { $0.category })
                HStack(spacing: 4) {
                    ForEach(Array(categories.prefix(3)), id: \.self) { category in
                        Circle()
                            .fill(Color(hex: category.colorHex))
                            .frame(width: 8, height: 8)
                    }
                    if categories.count > 3 {
                        Text("+\(categories.count - 3)")
                            .font(.caption2)
                            .foregroundColor(AppColors.inkSecondary)
                    }
                }
            }

            // 统计信息
            HStack {
                Text("已收藏 \(stats.total) 个 · 去过 \(stats.visited) 个")
                    .font(.caption)
                    .foregroundColor(AppColors.inkSecondary)

                Spacer()

                if stats.total > 0 {
                    Text("\(Int(Double(stats.visited) / Double(stats.total) * 100))%")
                        .font(.caption)
                        .foregroundColor(AppColors.visitedCyan)
                }
            }

            // 进度条
            if stats.total > 0 {
                VisitProgressBar(progress: Double(stats.visited) / Double(stats.total))
                    .frame(height: 3)
            }
        }
        .padding(.vertical, 8)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}