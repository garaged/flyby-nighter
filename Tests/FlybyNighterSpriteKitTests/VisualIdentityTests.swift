import XCTest
@testable import FlybyNighterSpriteKit

final class VisualIdentityTests: XCTestCase {
    func testDefaultIdentityNamesTheGameAndTagline() {
        let identity = VisualIdentity.current

        XCTAssertEqual(identity.appTitle, "Flyby Nighter")
        XCTAssertTrue(identity.tagline.contains("Arcade night flight"))
        XCTAssertTrue(identity.titleLine.contains(identity.appTitle))
        XCTAssertTrue(identity.titleLine.contains(identity.tagline))
    }

    func testDefaultIdentityDocumentsOriginalMoodWords() {
        let identity = VisualIdentity.current

        XCTAssertTrue(identity.moodWords.contains("original"))
        XCTAssertTrue(identity.moodWords.contains("readable"))
        XCTAssertGreaterThanOrEqual(identity.moodWords.count, 4)
    }

    func testPaletteTokensHaveStableNamesAndValidHexValues() throws {
        let identity = VisualIdentity.current
        let names = identity.palette.map(\.name)

        XCTAssertEqual(names, ["void", "rift-cyan", "tide-gold", "alert-red", "signal-green"])
        XCTAssertTrue(identity.palette.allSatisfy(\.isValidHexRGB))
        XCTAssertTrue(identity.palette.allSatisfy { !$0.role.isEmpty })

        let gold = try XCTUnwrap(identity.colorToken(named: "tide-gold"))
        XCTAssertEqual(gold.hex, "#FFD166")
    }

    func testInvalidHexValuesAreRejected() {
        XCTAssertFalse(VisualPaletteToken(name: "bad", hex: "FFD166", role: "missing prefix").isValidHexRGB)
        XCTAssertFalse(VisualPaletteToken(name: "bad", hex: "#GGGGGG", role: "invalid letters").isValidHexRGB)
        XCTAssertFalse(VisualPaletteToken(name: "bad", hex: "#FFF", role: "short form not allowed").isValidHexRGB)
    }
}
