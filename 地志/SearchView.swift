import SwiftUI

struct SearchView: View {
    @StateObject private var dataProvider = DataProvider.shared
    @State private var searchText = ""
    @State private var searchResults: [Place] = []

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 搜索框
                SearchBar(text: $searchText, onSearch: performSearch)
                    .padding(.horizontal)
                    .padding(.top, 16)
                    .padding(.bottom, 20)

                if searchText.isEmpty {
                    // 空状态
                    VStack(spacing: 20) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 60))
                            .foregroundColor(AppColors.inkSecondary.opacity(0.3))
                            .padding(.top, 80)

                        Text("搜索地点")
                            .font(.serifHeadline())
                            .foregroundColor(AppColors.inkSecondary)

                        Text("输入地点名、省份或类型进行搜索")
                            .font(.caption)
                            .foregroundColor(AppColors.inkSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        // 搜索提示
                        VStack(alignment: .leading, spacing: 12) {
                            Text("试试搜索：")
                                .font(.caption)
                                .foregroundColor(AppColors.inkSecondary)
                                .padding(.top, 20)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(["石窟", "寺庙", "云南", "博物馆"], id: \.self) { hint in
                                        Button(action: {
                                            searchText = hint
                                            performSearch()
                                        }) {
                                            Text(hint)
                                                .font(.caption)
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 6)
                                                .background(AppColors.borderGray.opacity(0.3))
                                                .foregroundColor(AppColors.inkSecondary)
                                                .clipShape(Capsule())
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.horizontal, 4)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                    }
                } else if searchResults.isEmpty {
                    // 无结果状态
                    VStack(spacing: 20) {
                        Image(systemName: "map")
                            .font(.system(size: 60))
                            .foregroundColor(AppColors.inkSecondary.opacity(0.3))
                            .padding(.top, 80)

                        Text("未找到相关地点")
                            .font(.serifHeadline())
                            .foregroundColor(AppColors.inkSecondary)

                        Text("尝试其他关键词")
                            .font(.caption)
                            .foregroundColor(AppColors.inkSecondary)
                    }
                } else {
                    // 搜索结果列表
                    List {
                        Section(header: Text("找到 \(searchResults.count) 个结果").font(.serifHeadline())) {
                            ForEach(searchResults) { place in
                                NavigationLink(destination: PlaceDetailView(place: place)) {
                                    SearchResultRow(place: place)
                                }
                                .listRowBackground(AppColors.paperBackground)
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }

                Spacer()
            }
            .paperBackground()
            .navigationTitle("搜索")
            .navigationBarTitleDisplayMode(.large)
            .onChange(of: searchText) { _ in
                performSearch()
            }
        }
    }

    private func performSearch() {
        if searchText.isEmpty {
            searchResults = []
            return
        }

        let query = searchText.lowercased()
        searchResults = dataProvider.places.filter { place in
            place.name.lowercased().contains(query) ||
            place.province.lowercased().contains(query) ||
            place.category.rawValue.lowercased().contains(query) ||
            place.description.lowercased().contains(query)
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    let onSearch: () -> Void

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(AppColors.inkSecondary)
                .padding(.leading, 12)

            TextField("搜索地点名、省份、类型...", text: $text)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.vertical, 12)
                .onSubmit(onSearch)

            if !text.isEmpty {
                Button(action: {
                    text = ""
                    onSearch()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(AppColors.inkSecondary)
                        .padding(.trailing, 12)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .background(Color.white.opacity(0.8))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(AppColors.borderGray.opacity(0.5), lineWidth: 1)
        )
    }
}

struct SearchResultRow: View {
    let place: Place

    var body: some View {
        HStack(spacing: 12) {
            // 类型emoji
            Text(place.category.emoji)
                .font(.title3)
                .frame(width: 30)

            // 地点信息
            VStack(alignment: .leading, spacing: 4) {
                Text(place.name)
                    .font(.headline)
                    .foregroundColor(AppColors.inkPrimary)
                    .lineLimit(1)

                HStack(spacing: 8) {
                    Text(place.province)
                        .font(.caption)
                        .foregroundColor(AppColors.inkSecondary)

                    Circle()
                        .fill(AppColors.inkSecondary.opacity(0.3))
                        .frame(width: 4, height: 4)

                    Text(place.category.rawValue)
                        .font(.caption)
                        .foregroundColor(AppColors.inkSecondary)
                }
            }

            Spacer()

            // 访问状态
            if place.isVisited {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(AppColors.visitedCyan)
                    .font(.callout)
            }
        }
        .padding(.vertical, 8)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}