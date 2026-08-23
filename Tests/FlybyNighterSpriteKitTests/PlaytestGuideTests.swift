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

    func testTitleScreenSummaryIncludesRouteSpecificContext() {
        let summary = PlaytestGuide.current.titleScreenSummary(for: RouteID.glassTide.definition)

        XCTAssertTrue(summary.contains("Glass Tide"))
        XCTAssertTrue(summary.contains("route"))
        XCTAssertTrue(summary.contains("Best scores"))
    }
}
