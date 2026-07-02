import XCTest
@testable import FlybyNighterCore

final class M1TuningTests: XCTestCase {
    func testM1RouteDurationTargetIsInsideSpecRange() {
        let config = GameConfig.m1
        let duration = config.routeLength / config.routeSpeed

        XCTAssertGreaterThanOrEqual(duration, 45)
        XCTAssertLessThanOrEqual(duration, 75)
    }

    func testM1ContentHasReadableRouteOrder() {
        let content = GameContent.m1NeonRift

        XCTAssertEqual(content.enemies.map(\.kind), [.drifter, .needler, .drifter, .sentry, .needler])
        XCTAssertEqual(content.gifts.map(\.kind), [.rapid, .spread, .shield])
        XCTAssertEqual(content.obstacles.map(\.kind), [.staticObstacle, .pulseGate, .staticObstacle, .pulseGate])

        XCTAssertEqual(content.enemies.map(\.spawnProgress), content.enemies.map(\.spawnProgress).sorted())
        XCTAssertEqual(content.gifts.map(\.spawnProgress), content.gifts.map(\.spawnProgress).sorted())
        XCTAssertEqual(content.obstacles.map(\.spawnProgress), content.obstacles.map(\.spawnProgress).sorted())
    }

    func testM1GiftsAreAvailableBeforeFinalRouteQuarter() {
        let config = GameConfig.m1
        let finalQuarterStart = config.routeLength * 0.75

        XCTAssertEqual(config.initialContent.gifts.count, 3)
        XCTAssertTrue(config.initialContent.gifts.allSatisfy { $0.spawnProgress < finalQuarterStart })
    }

    func testM1OpeningGivesPlayerSetupTimeBeforeFirstSpawn() {
        let config = GameConfig.m1
        let firstEnemySpawn = config.initialContent.enemies.map(\.spawnProgress).min() ?? 0
        let firstGiftSpawn = config.initialContent.gifts.map(\.spawnProgress).min() ?? 0
        let firstObstacleSpawn = config.initialContent.obstacles.map(\.spawnProgress).min() ?? 0

        XCTAssertGreaterThanOrEqual(firstEnemySpawn / config.routeSpeed, 3.0)
        XCTAssertGreaterThan(firstGiftSpawn, firstEnemySpawn)
        XCTAssertGreaterThan(firstObstacleSpawn, firstEnemySpawn)
    }

    func testM1ConfigUsesM1ContentWithoutChangingM0Default() {
        XCTAssertEqual(GameConfig.m1.initialContent, .m1NeonRift)
        XCTAssertEqual(GameConfig.m0.initialContent, .neonRift)
    }
}
