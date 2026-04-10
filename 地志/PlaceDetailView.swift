import SwiftUI

struct PlaceDetailView: View {
    let place: Place
    @StateObject private var dataProvider = DataProvider.shared
    @State private var isVisited: Bool = false
    @State private var showFeedback = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // 大标题
                Text(place.name)
                    .font(.serifTitle())
                    .foregroundColor(AppColors.inkPrimary)
                    .padding(.horizontal)

                // 省份 + 类型标签
                HStack(spacing: 10) {
                    CapsuleTag(text: place.province, color: AppColors.inkSecondary)
                    CapsuleTag(text: place.category.rawValue, color: Color(hex: place.category.colorHex))
                    Spacer()
                }
                .padding(.horizontal)

                // 一句话描述
                Text(place.description)
                    .font(.serifBody())
                    .foregroundColor(AppColors.inkPrimary)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .padding(.top, 8)

                // 地址（如果有）
                if let address = place.address, !address.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("地址")
                            .font(.headline)
                            .foregroundColor(AppColors.inkSecondary)

                        Text(address)
                            .font(.subheadline)
                            .foregroundColor(AppColors.inkSecondary)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                }

                // 「已到过」toggle
                VStack(spacing: 16) {
                    Divider()
                        .padding(.horizontal)

                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("已到过")
                                .font(.headline)
                                .foregroundColor(AppColors.inkPrimary)

                            Text("标记这个地方为已访问")
                                .font(.caption)
                                .foregroundColor(AppColors.inkSecondary)
                        }

                        Spacer()

                        Toggle("", isOn: $isVisited)
                            .toggleStyle(SwitchToggleStyle(tint: AppColors.visitedCyan))
                            .labelsHidden()
                            .onChange(of: isVisited) { newValue in
                                // 触感反馈
                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                generator.impactOccurred()

                                // 更新数据
                                dataProvider.updateVisitStatus(for: place.id, isVisited: newValue)

                                // 显示反馈
                                withAnimation {
                                    showFeedback = true
                                }

                                // 2秒后隐藏反馈
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        showFeedback = false
                                    }
                                }
                            }
                            .scaleEffect(1.2)
                    }
                    .padding(.horizontal)

                    if showFeedback {
                        Text(isVisited ? "✓ 已添加到旅行足迹" : "已从旅行足迹中移除")
                            .font(.caption)
                            .foregroundColor(isVisited ? AppColors.visitedCyan : AppColors.inkSecondary)
                            .transition(.opacity)
                            .padding(.horizontal)
                    }
                }
                .padding(.top, 20)

                // 来源标注
                VStack(alignment: .leading, spacing: 8) {
                    Divider()
                        .padding(.horizontal)

                    HStack {
                        Image(systemName: place.isOwn ? "heart.fill" : "star.fill")
                            .foregroundColor(place.isOwn ? AppColors.visitedCyan : AppColors.vermillion)

                        Text(place.isOwn ? "你的收藏" : "推荐地点")
                            .font(.caption)
                            .foregroundColor(AppColors.inkSecondary)

                        Spacer()
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 20)

                Spacer(minLength: 40)
            }
            .padding(.vertical, 24)
        }
        .paperBackground()
        .navigationTitle("地点详情")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            isVisited = place.isVisited
        }
    }
}

struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlaceDetailView(place: Place(
                name: "崇圣寺三塔文化旅游区",
                province: "云南",
                category: .temple,
                description: "三座塔站了一千年，看着大理换了无数朝代",
                isVisited: true,
                isOwn: true
            ))
        }
    }
}