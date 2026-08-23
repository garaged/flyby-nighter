import XCTest
@testable import FlybyNighterCore

final class M4ScoringTests: XCTestCase {
    func testScoreLedgerTracksEnemyAndGiftSources() {
        var ledger = ScoreLedger()

        ledger.record(.enemyRemoved(score: 100))
        ledger.record(.enemyRemoved(score: 200))
        ledger.record(.giftCollected(.shield))
        ledger.record(.playerFired(projectileCount: 1))

        let breakdown = ledger.breakdown(
            completed: false,
            remainingHP: 3,
            config: .m1
        )

        XCTAssertEqual(breakdown.enemyPoints, 2 * GameConfig.m1.enemyScore)
        XCTAssertEqual(breakdown.giftPoints, GameConfig.m1.giftScore)
        XCTAssertEqual(breakdown.completionBonus, 0)
        XCTAssertEqual(breakdown.remainingHPBonus, 0)
        XCTAssertEqual(breakdown.total, 2 * GameConfig.m1.enemyScore + GameConfig.m1.giftScore)
    }

    func testCompletedRunIncludesCompletionAndRemainingHPBonuses() {
        let ledger = ScoreLedger(enemyRemovals: 3, giftsCollected: 2)
        let config = GameConfig.m4GlassTide

        let breakdown = ledger.breakdown(
            completed: true,
            remainingHP: 2,
            config: config
        )

        XCTAssertEqual(breakdown.enemyPoints, 3 * config.enemyScore)
        XCTAssertEqual(breakdown.giftPoints, 2 * config.giftScore)
        XCTAssertEqual(breakdown.completionBonus, config.completionScore)
        XCTAssertEqual(breakdown.remainingHPBonus, 2 * config.remainingHPBonus)
        XCTAssertEqual(
            breakdown.total,
            3 * config.enemyScore + 2 * config.giftScore + config.completionScore + 2 * config.remainingHPBonus
        )
    }

    func testLedgerResetClearsRunSources() {
        var ledger = ScoreLedger(enemyRemovals: 4, giftsCollected: 3)

        ledger.reset()

        XCTAssertEqual(ledger, ScoreLedger())
    }

    func testM4ExplicitlyUsesLinearScoringWithoutComboMultiplier() {
        XCTAssertFalse(M4ScorePolicy.usesComboMultiplier)
        XCTAssertFalse(M4ScorePolicy.rationale.isEmpty)
    }
}
