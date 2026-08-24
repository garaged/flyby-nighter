import XCTest
import FlybyNighterCore
@testable import FlybyNighterSpriteKit

final class PlaytestGuideTests: XCTestCase {
    func testGuideCoversRouteSelectionAcrossPlatforms() {
        let guide = PlaytestGuide.current

        XCTAssertTrue(guide.routeSelection.contains("ROUTE 1/2"))
        XCTAssertTrue(guide.routeSelection.contains("ROUTE 2/2"))
        XCTAssertTrue(guide.routeSelection.contains("macOS"))
        XCTAssertTrue(guide.routeSelection.contains("iPhone/iPad"))
    }

    func testGuideCoversMovementAndFiringControls() {
        let text = PlaytestGuide.current.fullText

        XCTAssertTrue(text.contains("WASD"))
        XCTAssertTrue(text.contains("Space"))
        XCTAssertTrue(text.contains("drag"))
        XCTAssertTrue(text.contains("hold to fire"))
    }

    func testGuideCoversEveryScoreSource() {
        let scoringText = PlaytestGuide.current.scoring.joined(separator: "\n")

        XCTAssertTrue(scoringText.contains("Enemy"))
        XCTAssertTrue(scoringText.contains("Gift"))
        XCTAssertTrue(scoringText.contains("clear bonus"))
        XCTAssertTrue(scoringText.contains("HP bonus"))
    }

    func testGuideCoversBestScoresAndDebugLaunchArguments() {
        let text = PlaytestGuide.current.fullText

        XCTAssertTrue(text.contains("Best scores"))
        XCTAssertTrue(text.contains("separately per route"))
        XCTAssertTrue(text.contains("--reset-high-scores"))
        XCTAssertTrue(text.contains("--mute-audio"))
    }

    func testGuideCoversReleaseIdentityForTesterFeedback() {
        let guide = PlaytestGuide.current
        let text = guide.fullText

        XCTAssertEqual(guide.releaseIdentity, .firstTester)
        XCTAssertTrue(text.contains("Flyby Nighter"))
        XCTAssertTrue(text.contains("0.6.0"))
        XCTAssertTrue(text.contains("m6-dev"))
        XCTAssertTrue(text.contains("first-tester"))
    }

    func testGuideCoversVisualIdentityForTitleSurface() {
        let guide = PlaytestGuide.current
        let text = guide.fullText

        XCTAssertEqual(guide.visualIdentity, .current)
        XCTAssertTrue(text.contains("Arcade night flight"))
        XCTAssertTrue(text.contains("Flyby Nighter —"))
    }

    func testTitleScreenSummaryIncludesRouteSpecificContextAndIdentity() {
        let summary = PlaytestGuide.current.titleScreenSummary(for: RouteID.glassTide.definition)

        XCTAssertTrue(summary.contains("Arcade night flight"))
        XCTAssertTrue(summary.contains("Glass Tide"))
        XCTAssertTrue(summary.contains("route"))
        XCTAssertTrue(summary.contains("Best scores"))
        XCTAssertTrue(summary.contains("first-tester"))
    }
}
