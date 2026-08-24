import Foundation

public struct VisualIdentity: Equatable, Sendable {
    public var appTitle: String
    public var tagline: String
    public var moodWords: [String]
    public var palette: [VisualPaletteToken]

    public init(
        appTitle: String,
        tagline: String,
        moodWords: [String],
        palette: [VisualPaletteToken]
    ) {
        self.appTitle = appTitle
        self.tagline = tagline
        self.moodWords = moodWords
        self.palette = palette
    }

    public static let current = VisualIdentity(
        appTitle: "Flyby Nighter",
        tagline: "Arcade night flight, rebuilt for first-testers.",
        moodWords: [
            "neon",
            "night-flight",
            "readable",
            "focused",
            "original"
        ],
        palette: [
            VisualPaletteToken(name: "void", hex: "#050812", role: "deep space background"),
            VisualPaletteToken(name: "rift-cyan", hex: "#4DEBFF", role: "primary title and player energy"),
            VisualPaletteToken(name: "tide-gold", hex: "#FFD166", role: "route selector and Glass Shear accent"),
            VisualPaletteToken(name: "alert-red", hex: "#FF4D6D", role: "damage, failed runs, and danger pulses"),
            VisualPaletteToken(name: "signal-green", hex: "#6BFF95", role: "gifts, completion, and successful feedback")
        ]
    )

    public var titleLine: String {
        "\(appTitle) — \(tagline)"
    }

    public func colorToken(named name: String) -> VisualPaletteToken? {
        palette.first { $0.name == name }
    }
}

public struct VisualPaletteToken: Equatable, Sendable {
    public var name: String
    public var hex: String
    public var role: String

    public init(name: String, hex: String, role: String) {
        self.name = name
        self.hex = hex
        self.role = role
    }

    public var isValidHexRGB: Bool {
        guard hex.count == 7, hex.first == "#" else { return false }
        return hex.dropFirst().allSatisfy { character in
            character.isNumber || ("A"..."F").contains(String(character))
        }
    }
}
