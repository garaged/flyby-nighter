import Foundation
import FlybyNighterCore

public protocol LocalHighScoreStore: AnyObject {
    func bestScore(for routeID: RouteID) -> Int

    @discardableResult
    func record(score: Int, for routeID: RouteID) -> Bool

    func resetAll()
}

public final class UserDefaultsHighScoreStore: LocalHighScoreStore {
    public static let defaultSuiteName = "com.garaged.flyby-nighter.local-scores"

    private let userDefaults: UserDefaults
    private let keyPrefix: String

    public init(
        userDefaults: UserDefaults? = nil,
        keyPrefix: String = "flyby-nighter.best-score"
    ) {
        self.userDefaults = userDefaults
            ?? UserDefaults(suiteName: Self.defaultSuiteName)
            ?? .standard
        self.keyPrefix = keyPrefix

        if ProcessInfo.processInfo.arguments.contains("--reset-high-scores") {
            resetAll()
        }
    }

    public func bestScore(for routeID: RouteID) -> Int {
        max(0, userDefaults.integer(forKey: key(for: routeID)))
    }

    @discardableResult
    public func record(score: Int, for routeID: RouteID) -> Bool {
        let candidate = max(0, score)
        guard candidate > bestScore(for: routeID) else { return false }

        userDefaults.set(candidate, forKey: key(for: routeID))
        _ = userDefaults.synchronize()
        return true
    }

    public func resetAll() {
        for routeID in RouteID.allCases {
            userDefaults.removeObject(forKey: key(for: routeID))
        }
        _ = userDefaults.synchronize()
    }

    private func key(for routeID: RouteID) -> String {
        "\(keyPrefix).\(routeID.rawValue)"
    }
}
