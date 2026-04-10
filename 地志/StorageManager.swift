import Foundation

class StorageManager {
    static let shared = StorageManager()

    private let visitedKey = "visitedPlaces"
    private let defaults = UserDefaults.standard

    private init() {}

    func loadVisitStatus(for placeId: UUID) -> Bool {
        let visitedIds = defaults.stringArray(forKey: visitedKey) ?? []
        return visitedIds.contains(placeId.uuidString)
    }

    func updateVisitStatus(for placeId: UUID, isVisited: Bool) {
        var visitedIds = defaults.stringArray(forKey: visitedKey) ?? []

        if isVisited {
            if !visitedIds.contains(placeId.uuidString) {
                visitedIds.append(placeId.uuidString)
            }
        } else {
            visitedIds.removeAll { $0 == placeId.uuidString }
        }

        defaults.set(visitedIds, forKey: visitedKey)
    }

    func syncWithDataProvider(places: inout [Place]) {
        let visitedIds = defaults.stringArray(forKey: visitedKey) ?? []

        for i in 0..<places.count {
            places[i].isVisited = visitedIds.contains(places[i].id.uuidString)
        }
    }
}