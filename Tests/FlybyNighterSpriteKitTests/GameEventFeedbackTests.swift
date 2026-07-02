import XCTest
import FlybyNighterCore
@testable import FlybyNighterSpriteKit

final class GameEventFeedbackTests: XCTestCase {
    func testMajorGameplayEventsMapToExpectedAudioAndVisualCues() {
        XCTAssertEqual(
            GameEventFeedbackMapper.feedback(for: .playerFired(projectileCount: 1)),
            GameEventFeedback(audioCue: .playerShot, visualCue: .playerShot)
        )
        XCTAssertEqual(
            GameEventFeedbackMapper.feedback(for: .enemyRemoved(score: 100)),
            GameEventFeedback(audioCue: .enemyRemoved, visualCue: .enemyRemoved)
        )
        XCTAssertEqual(
            GameEventFeedbackMapper.feedback(for: .playerDamaged(remainingHP: 2)),
            GameEventFeedback(audioCue: .playerDamaged, visualCue: .playerDamaged)
        )
        XCTAssertEqual(
            GameEventFeedbackMapper.feedback(for: .giftCollected(.rapid)),
            GameEventFeedback(audioCue: .giftCollected, visualCue: .giftCollected)
        )
        XCTAssertEqual(
            GameEventFeedbackMapper.feedback(for: .shieldUsed),
            GameEventFeedback(audioCue: .shieldUsed, visualCue: .shieldUsed)
        )
        XCTAssertEqual(
            GameEventFeedbackMapper.feedback(for: .routeCompleted(score: 500)),
            GameEventFeedback(audioCue: .runCompleted, visualCue: .runCompleted)
        )
        XCTAssertEqual(
            GameEventFeedbackMapper.feedback(for: .runFailed(score: 100)),
            GameEventFeedback(audioCue: .runFailed, visualCue: .runFailed)
        )
    }

    func testPowerExpirationIsVisualOnly() {
        XCTAssertEqual(
            GameEventFeedbackMapper.feedback(for: .powerExpired(.spread)),
            GameEventFeedback(audioCue: nil, visualCue: .powerExpired)
        )
    }

    func testRoutineEventsDoNotCreateFeedback() {
        XCTAssertNil(GameEventFeedbackMapper.feedback(for: .runStarted))
        XCTAssertNil(GameEventFeedbackMapper.feedback(for: .enemyFired(enemyID: 1)))
        XCTAssertNil(GameEventFeedbackMapper.feedback(for: .damageIgnored))
    }
}
