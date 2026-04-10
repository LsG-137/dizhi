import SwiftUI

struct ThemeRouteView: View {
    @StateObject private var dataProvider = DataProvider.shared
    @State private var expandedRoute: String? = nil

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // 标题和描述
                    VStack(alignment: .leading, spacing: 12) {
                        Text("专题路线")
                            .font(.serifTitle())
                            .foregroundColor(AppColors.inkPrimary)

                        Text("把跨省的同类地点串成专题，探索更深的文化脉络")
                            .font(.serifBody())
                            .foregroundColor(AppColors.inkSecondary)
                            .multilineTextAlignment(.leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 20)

                    // 路线卡片列表
                    ForEach(dataProvider.themeRoutes(), id: \.title) { route in
                        RouteCard(route: route, expandedRoute: $expandedRoute)
                    }

                    Spacer(minLength: 40)
                }
            }
            .paperBackground()
            .navigationTitle("专题")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct RouteCard: View {
    let route: DataProvider.ThemeRoute
    @Binding var expandedRoute: String?
    @StateObject private var dataProvider = DataProvider.shared

    var isExpanded: Bool {
        expandedRoute == route.title
    }

    // 计算路线统计
    private var routeStats: (total: Int, visited: Int) {
        let allPlaces = dataProvider.places
        var total = 0
        var visited = 0

        for placeName in route.placeNames {
            if let place = allPlaces.first(where: { $0.name == placeName }) {
                total += 1
                if place.isVisited {
                    visited += 1
                }
            }
        }

        return (total, visited)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 卡片头部
            HStack {
                HStack(spacing: 10) {
                    Text(route.emoji)
                        .font(.title2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(route.title)
                            .font(.serifHeadline())
                            .foregroundColor(AppColors.inkPrimary)

                        Text("已走过 \(routeStats.visited) 个 / 共 \(routeStats.total) 个")
                            .font(.caption)
                            .foregroundColor(AppColors.inkSecondary)
                    }
                }

                Spacer()

                // 展开/收起按钮
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        if isExpanded {
                            expandedRoute = nil
                        } else {
                            expandedRoute = route.title
                        }
                    }
                }) {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(AppColors.inkSecondary)
                        .font(.headline)
                        .padding(8)
                        .background(AppColors.borderGray.opacity(0.3))
                        .clipShape(Circle())
                }
                .buttonStyle(PlainButtonStyle())
            }

            // 进度条
            if routeStats.total > 0 {
                VisitProgressBar(progress: Double(routeStats.visited) / Double(routeStats.total))
                    .frame(height: 6)
            }

            // 展开的内容
            if isExpanded {
                VStack(alignment: .leading, spacing: 12) {
                    Divider()

                    Text("路线地点")
                        .font(.headline)
                        .foregroundColor(AppColors.inkSecondary)

                    ForEach(route.placeNames, id: \.self) { placeName in
                        if let place = dataProvider.places.first(where: { $0.name == placeName }) {
                            RoutePlaceRow(place: place)
                        } else {
                            RoutePlaceRow(place: Place(
                                name: placeName,
                                province: "",
                                category: .nature,
                                description: "",
                                isVisited: false,
                                isOwn: false
                            ))
                        }
                    }
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding()
        .background(Color.white.opacity(0.7))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(AppColors.borderGray.opacity(0.5), lineWidth: 1)
        )
        .padding(.horizontal)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

struct RoutePlaceRow: View {
    let place: Place

    var body: some View {
        HStack(spacing: 12) {
            // 访问状态指示器
            if place.isVisited {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(AppColors.visitedCyan)
                    .font(.callout)
            } else {
                Circle()
                    .fill(AppColors.inkSecondary.opacity(0.3))
                    .frame(width: 16, height: 16)
            }

            // 地点信息
            VStack(alignment: .leading, spacing: 2) {
                Text(place.name)
                    .font(.subheadline)
                    .foregroundColor(AppColors.inkPrimary)
                    .lineLimit(1)

                if !place.province.isEmpty {
                    Text(place.province)
                        .font(.caption)
                        .foregroundColor(AppColors.inkSecondary)
                }
            }

            Spacer()

            // 类型标签
            if !place.province.isEmpty {
                CapsuleTag(text: place.category.rawValue, color: Color(hex: place.category.colorHex))
            }
        }
        .padding(.vertical, 4)
    }
}

struct ThemeRouteView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeRouteView()
    }
}