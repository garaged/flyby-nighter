import XCTest
import FlybyNighterCore
@testable import FlybyNighterSpriteKit

final class RouteSelectionStateTests: XCTestCase {
    func testSelectionStartsOnNeonRiftAndWrapsBothDirections() {
        var state = RouteSelectionState()

        XCTAssertEqual(state.selectedRouteID, .neonRift)

        state.selectNext()
        XCTAssertEqual(state.selectedRouteID, .glassTide)

        state.selectNext()
        XCTAssertEqual(state.selectedRouteID, .neonRift)

        state.selectPrevious()
        XCTAssertEqual(state.selectedRouteID, .glassTide)
    }

    func testSelectedRouteProvidesItsOwnGameConfiguration() {
        var state = RouteSelectionState()
        let neonConfig = state.selectedRoute.config

        state.selectNext()
        let glassConfig = state.selectedRoute.config

        XCTAssertEqual(state.selectedRoute.displayName, "The Glass Tide")
        XCTAssertNotEqual(glassConfig.routeLength, neonConfig.routeLength)
        XCTAssertEqual(glassConfig.initialContent, .glassTide)
    }

    func testSegmentNamesFollowSelectedRouteMetadata() {
        var state = RouteSelectionState(selectedRouteID: .neonRift)

        XCTAssertEqual(state.segmentName(at: 0), "Sector 01 Entry")
        XCTAssertEqual(state.segmentName(at: 0.5), "Sector 04 Midway")
        XCTAssertEqual(state.segmentName(at: 1), "Sector 07 Exit")

        state.selectNext()

        XCTAssertEqual(state.segmentName(at: 0), "Tide 01 Threshold")
        XCTAssertEqual(state.segmentName(at: 0.5), "Tide 04 Crosscurrent")
        XCTAssertEqual(state.segmentName(at: 1), "Tide 07 Whiteout")
    }

    func testSegmentProgressIsClamped() {
        let state = RouteSelectionState(selectedRouteID: .glassTide)

        XCTAssertEqual(state.segmentName(at: -1), "Tide 01 Threshold")
        XCTAssertEqual(state.segmentName(at: 2), "Tide 07 Whiteout")
    }
}
