import FlybyNighterCore

struct RouteSelectionState: Equatable {
    private(set) var selectedRouteID: RouteID

    init(selectedRouteID: RouteID = .neonRift) {
        self.selectedRouteID = selectedRouteID
    }

    var selectedRoute: RouteDefinition {
        RouteCatalog.definition(for: selectedRouteID)
    }

    mutating func selectNext() {
        moveSelection(by: 1)
    }

    mutating func selectPrevious() {
        moveSelection(by: -1)
    }

    func segmentName(at progressFraction: Double) -> String {
        let names = selectedRoute.segmentNames
        guard !names.isEmpty else { return selectedRoute.displayName }

        let progress = min(max(progressFraction, 0), 1)
        let index: Int
        switch progress {
        case 0..<0.15:
            index = 0
        case 0.15..<0.30:
            index = 1
        case 0.30..<0.45:
            index = 2
        case 0.45..<0.62:
            index = 3
        case 0.62..<0.75:
            index = 4
        case 0.75..<0.90:
            index = 5
        default:
            index = 6
        }

        return names[min(index, names.count - 1)]
    }

    private mutating func moveSelection(by offset: Int) {
        let routeIDs = RouteID.allCases
        guard let currentIndex = routeIDs.firstIndex(of: selectedRouteID), !routeIDs.isEmpty else {
            selectedRouteID = .neonRift
            return
        }

        let nextIndex = (currentIndex + offset + routeIDs.count) % routeIDs.count
        selectedRouteID = routeIDs[nextIndex]
    }
}
