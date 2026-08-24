import XCTest
@testable import FlybyNighterCore

final class ReleaseIdentityTests: XCTestCase {
    func testFirstTesterIdentityIsValidAndVisible() {
        let identity = ReleaseIdentity.firstTester

        XCTAssertEqual(identity.appName, "Flyby Nighter")
        XCTAssertEqual(identity.channel, "first-tester")
        XCTAssertTrue(identity.isValid)
        XCTAssertTrue(identity.displayText.contains("Flyby Nighter"))
        XCTAssertTrue(identity.displayText.contains("0.8.0"))
        XCTAssertTrue(identity.displayText.contains("m8-dev"))
        XCTAssertTrue(identity.displayText.contains("first-tester"))
    }

    func testFeedbackTokenContainsEveryField() {
        let token = ReleaseIdentity.firstTester.feedbackToken

        XCTAssertTrue(token.contains("app=Flyby Nighter"))
        XCTAssertTrue(token.contains("version=0.8.0"))
        XCTAssertTrue(token.contains("build=m8-dev"))
        XCTAssertTrue(token.contains("channel=first-tester"))
    }

    func testWhitespaceIsTrimmedAndEmptyValuesAreInvalid() {
        let identity = ReleaseIdentity(
            appName: " Flyby Nighter ",
            version: " ",
            build: " 1 ",
            channel: " first-tester "
        )

        XCTAssertEqual(identity.appName, "Flyby Nighter")
        XCTAssertEqual(identity.version, "")
        XCTAssertEqual(identity.build, "1")
        XCTAssertEqual(identity.channel, "first-tester")
        XCTAssertFalse(identity.isValid)
    }
}
