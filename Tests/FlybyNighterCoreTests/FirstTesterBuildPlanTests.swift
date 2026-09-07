import XCTest
@testable import FlybyNighterCore

final class FirstTesterBuildPlanTests: XCTestCase {
    func testCurrentPlanIsValidAndUsesReleaseIdentity() {
        let plan = FirstTesterBuildPlan.current

        XCTAssertTrue(plan.isValid)
        XCTAssertEqual(plan.releaseIdentity, .firstTester)
        XCTAssertEqual(plan.bundleDirectoryName, "FlybyNighter-first-tester")
        XCTAssertEqual(plan.manifestFileName, "MANIFEST.md")
        XCTAssertEqual(plan.handoffFileName, "README-FIRST-TESTER.md")
    }

    func testValidationCommandsCoverPackageAndMobileBuilds() {
        let commands = FirstTesterBuildPlan.current.validationCommands.map(\.command).joined(separator: "\n")

        XCTAssertTrue(commands.contains("swift build"))
        XCTAssertTrue(commands.contains("swift test"))
        XCTAssertTrue(commands.contains("xcodebuild"))
        XCTAssertTrue(commands.contains("FlybyNighterMobile.xcodeproj"))
        XCTAssertTrue(commands.contains("CODE_SIGNING_ALLOWED=NO"))
    }

    func testMacOSCommandsCoverRunResetAndMute() {
        let commands = FirstTesterBuildPlan.current.macOSCommands.map(\.command).joined(separator: "\n")

        XCTAssertTrue(commands.contains("swift run FlybyNighterApp"))
        XCTAssertTrue(commands.contains("--reset-high-scores"))
        XCTAssertTrue(commands.contains("--mute-audio"))
    }

    func testManifestIncludesEvidenceAndDistributionBoundary() {
        let manifest = FirstTesterBuildPlan.current.manifest(
            commitSHA: "abc123",
            generatedAt: "2026-08-23T19:08:00-06:00",
            validationStatus: "passed"
        )

        XCTAssertTrue(manifest.contains("Flyby Nighter"))
        XCTAssertTrue(manifest.contains("abc123"))
        XCTAssertTrue(manifest.contains("2026-08-23T19:08:00-06:00"))
        XCTAssertTrue(manifest.contains("passed"))
        XCTAssertTrue(manifest.contains("swift build"))
        XCTAssertTrue(manifest.contains("swift test"))
        XCTAssertTrue(manifest.contains("xcodebuild"))
        XCTAssertTrue(manifest.contains("local development handoff artifacts only"))
        XCTAssertTrue(manifest.contains("not App Store"))
        XCTAssertTrue(manifest.contains("notarized"))
        XCTAssertTrue(manifest.contains("telemetry-enabled"))
    }

    func testManifestNormalizesEmptyEvidence() {
        let manifest = FirstTesterBuildPlan.current.manifest(
            commitSHA: " ",
            generatedAt: " ",
            validationStatus: " "
        )

        XCTAssertTrue(manifest.contains("- Commit: unknown"))
        XCTAssertTrue(manifest.contains("- Generated at: unknown"))
        XCTAssertTrue(manifest.contains("- Validation status: unknown"))
    }

    func testFeedbackCategoriesCoverTriageBuckets() {
        let categories = Set(FirstTesterBuildPlan.current.feedbackCategories)

        XCTAssertTrue(categories.contains("blocker"))
        XCTAssertTrue(categories.contains("regression"))
        XCTAssertTrue(categories.contains("usability"))
        XCTAssertTrue(categories.contains("visual"))
        XCTAssertTrue(categories.contains("polish"))
    }
}
