import Foundation

public struct ReleaseIdentity: Equatable, Sendable {
    public var appName: String
    public var version: String
    public var build: String
    public var channel: String

    public init(
        appName: String,
        version: String,
        build: String,
        channel: String
    ) {
        self.appName = appName.trimmingCharacters(in: .whitespacesAndNewlines)
        self.version = version.trimmingCharacters(in: .whitespacesAndNewlines)
        self.build = build.trimmingCharacters(in: .whitespacesAndNewlines)
        self.channel = channel.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public static let firstTester = ReleaseIdentity(
        appName: "Flyby Nighter",
        version: "0.6.0",
        build: "m6-dev",
        channel: "first-tester"
    )

    public var isValid: Bool {
        !appName.isEmpty && !version.isEmpty && !build.isEmpty && !channel.isEmpty
    }

    public var displayText: String {
        "\(appName) v\(version) (\(build)) • \(channel)"
    }

    public var feedbackToken: String {
        "app=\(appName); version=\(version); build=\(build); channel=\(channel)"
    }
}
