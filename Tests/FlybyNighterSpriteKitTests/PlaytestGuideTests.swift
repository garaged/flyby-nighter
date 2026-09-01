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

        XCTAssertTrue(scoringText.contains("enemies"))
        XCTAssertTrue(scoringText.contains("gifts"))
        XCTAssertTrue(scoringText.contains("clear bonus"))
        XCTAssertTrue(scoringText.contains("remaining HP"))
    }

    func testGuideCoversBestScoresAndDebugLaunchArguments() {
        let text = PlaytestGuide.current.fullText

        XCTAssertTrue(text.contains("Best score"))
        XCTAssertTrue(text.contains("separately per route"))
        XCTAssertTrue(text.contains("--reset-high-scores"))
        XCTAssertTrue(text.contains("--mute-audio"))
    }

    func testGuideCoversReleaseIdentityForTesterFeedback() {
        let guide = PlaytestGuide.current
        let text = guide.fullText

        XCTAssertEqual(guide.releaseIdentity, .firstTester)
        XCTAssertTrue(text.contains("Flyby Nighter"))
        XCTAssertTrue(text.contains("0.8.0"))
        XCTAssertTrue(text.contains("m8-dev"))
        XCTAssertTrue(text.contains("first-tester"))
    }

    func testGuideCoversVisualIdentityForTitleSurface() {
        let guide = PlaytestGuide.current
        let text = guide.fullText

        XCTAssertEqual(guide.visualIdentity, .current)
        XCTAssertTrue(text.contains("Arcade night flight"))
        XCTAssertTrue(text.contains("Flyby Nighter —"))
    }

    func testTitleScreenSummaryIsCompactAndIdentityFocused() {
        let summary = PlaytestGuide.current.titleScreenSummary(for: RouteID.glassTide.definition)
        let lines = summary.split(separator: "\n")

        XCTAssertLessThanOrEqual(lines.count, 6)
        XCTAssertTrue(summary.contains("Arcade night flight"))
        XCTAssertTrue(summary.contains("Routes:"))
        XCTAssertTrue(summary.contains("Best score"))
        XCTAssertTrue(summary.contains("first-tester"))
        XCTAssertFalse(summary.contains("Selected:"))
    }
}
