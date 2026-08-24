import Foundation
import FlybyNighterCore

public struct PlaytestGuide: Equatable, Sendable {
    public var title: String
    public var routeSelection: String
    public var controls: [String]
    public var scoring: [String]
    public var bestScores: String
    public var debugReset: String
    public var releaseIdentity: ReleaseIdentity
    public var visualIdentity: VisualIdentity

    public init(
        title: String,
        routeSelection: String,
        controls: [String],
        scoring: [String],
        bestScores: String,
        debugReset: String,
        releaseIdentity: ReleaseIdentity = .firstTester,
        visualIdentity: VisualIdentity = .current
    ) {
        self.title = title
        self.routeSelection = routeSelection
        self.controls = controls
        self.scoring = scoring
        self.bestScores = bestScores
        self.debugReset = debugReset
        self.releaseIdentity = releaseIdentity
        self.visualIdentity = visualIdentity
    }

    public static let current = PlaytestGuide(
        title: "How to play",
        routeSelection: "Routes: ROUTE 1/2 or ROUTE 2/2. macOS: 1/2 or arrows; iPhone/iPad: side taps.",
        controls: [
            "Start/replay: center tap/click or Return.",
            "Move: WASD/arrows on macOS, drag on touch.",
            "Fire: Space on macOS, hold to fire on touch."
        ],
        scoring: [
            "Score: enemies + gifts + clear bonus + remaining HP.",
            "Glass Tide includes the yellow Glass Shear gate pattern."
        ],
        bestScores: "Best score is saved separately per route.",
        debugReset: "Reset scores: --reset-high-scores. Quiet test: --mute-audio."
    )

    public func titleScreenSummary(for route: RouteDefinition) -> String {
        var lines = [visualIdentity.tagline]
        lines.append(releaseIdentity.displayText)
        lines.append(routeSelection)
        lines.append(controls.joined(separator: " "))
        lines.append(scoring.joined(separator: " "))
        lines.append(bestScores)
        return lines.joined(separator: "\n")
    }

    public var fullText: String {
        ([visualIdentity.titleLine, title, releaseIdentity.displayText, routeSelection] + controls + scoring + [bestScores, debugReset]).joined(separator: "\n")
    }
}
