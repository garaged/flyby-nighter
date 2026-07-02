import XCTest
@testable import FlybyNighterCore

final class M4RoutesTests: XCTestCase {
    func testRouteCatalogContainsTwoUniqueOriginalRoutes() {
        let routes = RouteCatalog.all

        XCTAssertEqual(routes.map(\.id), [.neonRift, .glassTide])
        XCTAssertEqual(Set(routes.map(\.id)).count, 2)
        XCTAssertEqual(Set(routes.map(\.displayName)).count, 2)
        XCTAssertTrue(routes.allSatisfy { !$0.summary.isEmpty })
        XCTAssertTrue(routes.allSatisfy { $0.segmentNames.count == 7 })
    }

    func testGlassTideHasDistinctPacingIdentity() {
        let neonRift = RouteCatalog.definition(for: .neonRift)
        let glassTide = RouteCatalog.definition(for: .glassTide)
        let duration = glassTide.config.routeLength / glassTide.config.routeSpeed

        XCTAssertNotEqual(glassTide.config.routeLength, neonRift.config.routeLength)
        XCTAssertNotEqual(glassTide.config.routeSpeed, neonRift.config.routeSpeed)
        XCTAssertNotEqual(glassTide.config.initialContent, neonRift.config.initialContent)
        XCTAssertGreaterThanOrEqual(duration, 45)
        XCTAssertLessThanOrEqual(duration, 75)
    }

    func testGlassTideContentIsOrderedAndInsideRouteBounds() {
        let config = RouteCatalog.definition(for: .glassTide).config
        let content = config.initialContent

        assertStrictlyOrdered(content.enemies.map(\.spawnProgress))
        assertStrictlyOrdered(content.gifts.map(\.spawnProgress))
        assertStrictlyOrdered(content.obstacles.map(\.spawnProgress))

        XCTAssertTrue(content.enemies.allSatisfy { $0.spawnProgress < config.routeLength })
        XCTAssertTrue(content.gifts.allSatisfy { $0.spawnProgress < config.routeLength })
        XCTAssertTrue(content.obstacles.allSatisfy { $0.spawnProgress < config.routeLength })
    }

    func testGlassTideIncludesEveryGiftWithDifferentTeachingOrder() {
        let gifts = RouteCatalog.definition(for: .glassTide).config.initialContent.gifts

        XCTAssertEqual(gifts.map(\.kind), [.shield, .rapid, .spread])
        XCTAssertEqual(Set(gifts.map(\.kind)).count, 3)
    }

    func testGlassTideRouteConfigurationCanReachCompletion() {
        var config = RouteCatalog.definition(for: .glassTide).config
        config.initialContent = .empty

        var game = FlybyNighterGame(config: config)
        _ = game.startRun()
        let events = game.update(deltaTime: config.routeLength / config.routeSpeed)

        XCTAssertEqual(game.state.runState, .completed)
        XCTAssertEqual(game.state.routeProgress, config.routeLength)
        XCTAssertTrue(events.contains { event in
            if case .routeCompleted = event {
                return true
            }
            return false
        })
    }

    private func assertStrictlyOrdered(_ values: [Double], file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(values, values.sorted(), file: file, line: line)
        XCTAssertEqual(Set(values).count, values.count, file: file, line: line)
    }
}
