import XCTest
import FlybyNighterCore
@testable import FlybyNighterSpriteKit

final class LocalHighScoreStoreTests: XCTestCase {
    private var suiteName: String!
    private var userDefaults: UserDefaults!
    private var store: UserDefaultsHighScoreStore!

    override func setUp() {
        super.setUp()
        suiteName = "LocalHighScoreStoreTests.\(UUID().uuidString)"
        userDefaults = UserDefaults(suiteName: suiteName)
        userDefaults.removePersistentDomain(forName: suiteName)
        store = UserDefaultsHighScoreStore(
            userDefaults: userDefaults,
            keyPrefix: "test.best-score"
        )
    }

    override func tearDown() {
        userDefaults.removePersistentDomain(forName: suiteName)
        store = nil
        userDefaults = nil
        suiteName = nil
        super.tearDown()
    }

    func testScoresAreStoredSeparatelyPerRoute() {
        XCTAssertTrue(store.record(score: 1_200, for: .neonRift))
        XCTAssertTrue(store.record(score: 1_650, for: .glassTide))

        XCTAssertEqual(store.bestScore(for: .neonRift), 1_200)
        XCTAssertEqual(store.bestScore(for: .glassTide), 1_650)
    }

    func testLowerOrEqualScoreDoesNotReplaceBest() {
        XCTAssertTrue(store.record(score: 1_400, for: .neonRift))
        XCTAssertFalse(store.record(score: 1_399, for: .neonRift))
        XCTAssertFalse(store.record(score: 1_400, for: .neonRift))

        XCTAssertEqual(store.bestScore(for: .neonRift), 1_400)
    }

    func testScorePersistsAcrossStoreInstances() {
        XCTAssertTrue(store.record(score: 2_100, for: .glassTide))

        let secondStore = UserDefaultsHighScoreStore(
            userDefaults: userDefaults,
            keyPrefix: "test.best-score"
        )

        XCTAssertEqual(secondStore.bestScore(for: .glassTide), 2_100)
    }

    func testResetClearsEveryRoute() {
        _ = store.record(score: 900, for: .neonRift)
        _ = store.record(score: 1_100, for: .glassTide)

        store.resetAll()

        XCTAssertEqual(store.bestScore(for: .neonRift), 0)
        XCTAssertEqual(store.bestScore(for: .glassTide), 0)
    }

    func testNegativeScoresAreSafeAndDoNotCreateABest() {
        XCTAssertFalse(store.record(score: -100, for: .neonRift))
        XCTAssertEqual(store.bestScore(for: .neonRift), 0)
    }
}
