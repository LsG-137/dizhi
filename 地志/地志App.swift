import SwiftUI

@main
struct 地志App: App {
    // 初始化数据提供器
    init() {
        // 预加载数据
        _ = DataProvider.shared
    }

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(.light) // 固定为亮色模式，保持宣纸质感
                .onAppear {
                    // 设置全局外观
                    setupAppearance()
                }
        }
    }

    private func setupAppearance() {
        // 设置导航栏外观
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(AppColors.paperBackground)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(AppColors.inkPrimary),
            .font: UIFont.systemFont(ofSize: 18, weight: .medium)
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(AppColors.inkPrimary),
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance

        // 设置TabBar外观
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(AppColors.paperBackground)
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(AppColors.inkSecondary)
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(AppColors.inkSecondary)
        ]
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(AppColors.visitedCyan)
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(AppColors.visitedCyan)
        ]

        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}

struct MainTabView: View {
    var body: some View {
        TabView {
            // Tab 1: 省份总览
            HomeView()
                .tabItem {
                    Label("总览", systemImage: "map")
                }

            // Tab 2: 专题路线
            ThemeRouteView()
                .tabItem {
                    Label("专题", systemImage: "point.3.connected.trianglepath.dotted")
                }

            // Tab 3: 搜索
            SearchView()
                .tabItem {
                    Label("搜索", systemImage: "magnifyingglass")
                }
        }
        .accentColor(AppColors.visitedCyan)
        .paperBackground()
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}