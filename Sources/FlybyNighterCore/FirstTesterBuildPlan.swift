import Foundation

public struct FirstTesterCommand: Equatable, Sendable {
    public var name: String
    public var command: String
    public var purpose: String

    public init(name: String, command: String, purpose: String) {
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        self.command = command.trimmingCharacters(in: .whitespacesAndNewlines)
        self.purpose = purpose.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public var isValid: Bool {
        !name.isEmpty && !command.isEmpty && !purpose.isEmpty
    }
}

public struct FirstTesterBuildPlan: Equatable, Sendable {
    public var releaseIdentity: ReleaseIdentity
    public var validationCommands: [FirstTesterCommand]
    public var macOSCommands: [FirstTesterCommand]
    public var bundleDirectoryName: String
    public var manifestFileName: String
    public var handoffFileName: String
    public var distributionBoundary: String
    public var feedbackCategories: [String]

    public init(
        releaseIdentity: ReleaseIdentity,
        validationCommands: [FirstTesterCommand],
        macOSCommands: [FirstTesterCommand],
        bundleDirectoryName: String,
        manifestFileName: String,
        handoffFileName: String,
        distributionBoundary: String,
        feedbackCategories: [String]
    ) {
        self.releaseIdentity = releaseIdentity
        self.validationCommands = validationCommands
        self.macOSCommands = macOSCommands
        self.bundleDirectoryName = bundleDirectoryName.trimmingCharacters(in: .whitespacesAndNewlines)
        self.manifestFileName = manifestFileName.trimmingCharacters(in: .whitespacesAndNewlines)
        self.handoffFileName = handoffFileName.trimmingCharacters(in: .whitespacesAndNewlines)
        self.distributionBoundary = distributionBoundary.trimmingCharacters(in: .whitespacesAndNewlines)
        self.feedbackCategories = feedbackCategories.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    }

    public static let current = FirstTesterBuildPlan(
        releaseIdentity: .firstTester,
        validationCommands: [
            FirstTesterCommand(
                name: "Swift package build",
                command: "swift build",
                purpose: "Compile all SwiftPM products."
            ),
            FirstTesterCommand(
                name: "Swift package tests",
                command: "swift test",
                purpose: "Run deterministic core and adapter tests."
            ),
            FirstTesterCommand(
                name: "iPhone/iPad Simulator build",
                command: "xcodebuild -project Apps/FlybyNighterMobile/FlybyNighterMobile.xcodeproj -scheme FlybyNighterMobile -sdk iphonesimulator -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO build",
                purpose: "Compile the mobile app shell without requiring signing."
            )
        ],
        macOSCommands: [
            FirstTesterCommand(
                name: "Run macOS app",
                command: "swift run FlybyNighterApp",
                purpose: "Launch the first-tester macOS shell."
            ),
            FirstTesterCommand(
                name: "Run macOS app with reset scores",
                command: "swift run FlybyNighterApp -- --reset-high-scores",
                purpose: "Start a clean local high-score playtest."
            ),
            FirstTesterCommand(
                name: "Run macOS app muted",
                command: "swift run FlybyNighterApp -- --mute-audio",
                purpose: "Start a quiet playtest session."
            )
        ],
        bundleDirectoryName: "FlybyNighter-first-tester",
        manifestFileName: "MANIFEST.md",
        handoffFileName: "README-FIRST-TESTER.md",
        distributionBoundary: "M8 bundles are local development handoff artifacts only; they are not App Store, TestFlight, notarized, signed, telemetry-enabled, or public distribution artifacts.",
        feedbackCategories: ["blocker", "regression", "usability", "visual", "polish"]
    )

    public var isValid: Bool {
        releaseIdentity.isValid
            && !validationCommands.isEmpty
            && !macOSCommands.isEmpty
            && validationCommands.allSatisfy(\.isValid)
            && macOSCommands.allSatisfy(\.isValid)
            && !bundleDirectoryName.isEmpty
            && !manifestFileName.isEmpty
            && !handoffFileName.isEmpty
            && !distributionBoundary.isEmpty
            && feedbackCategories.allSatisfy { !$0.isEmpty }
    }

    public var allCommands: [FirstTesterCommand] {
        validationCommands + macOSCommands
    }

    public func manifest(
        commitSHA: String = "unknown",
        generatedAt: String = "unknown",
        validationStatus: String = "not-run"
    ) -> String {
        var lines: [String] = []
        lines.append("# Flyby Nighter First-Tester Manifest")
        lines.append("")
        lines.append("- Release identity: \(releaseIdentity.displayText)")
        lines.append("- Feedback token: \(releaseIdentity.feedbackToken)")
        lines.append("- Commit: \(commitSHA.trimmingCharacters(in: .whitespacesAndNewlines).nonEmptyOrUnknown)")
        lines.append("- Generated at: \(generatedAt.trimmingCharacters(in: .whitespacesAndNewlines).nonEmptyOrUnknown)")
        lines.append("- Validation status: \(validationStatus.trimmingCharacters(in: .whitespacesAndNewlines).nonEmptyOrUnknown)")
        lines.append("")
        lines.append("## Validation commands")
        for command in validationCommands {
            lines.append("- `\(command.command)`: \(command.purpose)")
        }
        lines.append("")
        lines.append("## macOS playtest commands")
        for command in macOSCommands {
            lines.append("- `\(command.command)`: \(command.purpose)")
        }
        lines.append("")
        lines.append("## Distribution boundary")
        lines.append(distributionBoundary)
        lines.append("")
        lines.append("## Feedback categories")
        lines.append(feedbackCategories.joined(separator: ", "))
        return lines.joined(separator: "\n")
    }
}

private extension String {
    var nonEmptyOrUnknown: String {
        isEmpty ? "unknown" : self
    }
}
