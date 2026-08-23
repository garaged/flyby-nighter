import Foundation
import FlybyNighterCore

public struct PlaytestGuide: Equatable, Sendable {
    public var title: String
    public var routeSelection: String
    public var controls: [String]
    public var scoring: [String]
    public var bestScores: String
    public var debugReset: String

    public init(
        title: String,
        routeSelection: String,
        controls: [String],
        scoring: [String],
        bestScores: String,
        debugReset: String
    ) {
        self.title = title
        self.routeSelection = routeSelection
        self.controls = controls
        self.scoring = scoring
        self.bestScores = bestScores
        self.debugReset = debugReset
    }

    public static let current = PlaytestGuide(
        title: "How to play",
        routeSelection: "Select ROUTE 1/2 Neon Rift or ROUTE 2/2 Glass Tide before a run. On macOS use 1/2, arrows, or side clicks; on iPhone/iPad tap the left or right side.",
        controls: [
            "macOS: WASD or arrows move, Space fires, Return starts or replays.",
            "iPhone/iPad: center tap starts, hold to fire, drag to steer."
        ],
        scoring: [
            "Enemy removals add enemy points.",
            "Gift pickups add gift points.",
            "Completing a route adds the clear bonus.",
            "Finishing with HP remaining adds an HP bonus."
        ],
        bestScores: "Best scores are stored separately per route and only improve when a run beats the current route best.",
        debugReset: "For a clean playtest, launch with --reset-high-scores. For quiet testing, launch with --mute-audio."
    )

    public func titleScreenSummary(for route: RouteDefinition) -> String {
        var lines = [route.summary]
        lines.append(routeSelection)
        lines.append(bestScores)
        return lines.joined(separator: "\n")
    }

    public var fullText: String {
        ([title, routeSelection] + controls + scoring + [bestScores, debugReset]).joined(separator: "\n")
    }
}
