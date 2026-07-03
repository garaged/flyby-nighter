import Foundation

public struct ScoreBreakdown: Equatable, Sendable {
    public var enemyPoints: Int
    public var giftPoints: Int
    public var completionBonus: Int
    public var remainingHPBonus: Int

    public init(
        enemyPoints: Int = 0,
        giftPoints: Int = 0,
        completionBonus: Int = 0,
        remainingHPBonus: Int = 0
    ) {
        self.enemyPoints = enemyPoints
        self.giftPoints = giftPoints
        self.completionBonus = completionBonus
        self.remainingHPBonus = remainingHPBonus
    }

    public var total: Int {
        enemyPoints + giftPoints + completionBonus + remainingHPBonus
    }
}

public struct ScoreLedger: Equatable, Sendable {
    public private(set) var enemyRemovals: Int
    public private(set) var giftsCollected: Int

    public init(enemyRemovals: Int = 0, giftsCollected: Int = 0) {
        self.enemyRemovals = max(0, enemyRemovals)
        self.giftsCollected = max(0, giftsCollected)
    }

    public mutating func reset() {
        enemyRemovals = 0
        giftsCollected = 0
    }

    public mutating func record(_ event: GameEvent) {
        switch event {
        case .enemyRemoved:
            enemyRemovals += 1
        case .giftCollected:
            giftsCollected += 1
        default:
            break
        }
    }

    public func breakdown(
        completed: Bool,
        remainingHP: Int,
        config: GameConfig
    ) -> ScoreBreakdown {
        ScoreBreakdown(
            enemyPoints: enemyRemovals * config.enemyScore,
            giftPoints: giftsCollected * config.giftScore,
            completionBonus: completed ? config.completionScore : 0,
            remainingHPBonus: completed ? max(0, remainingHP) * config.remainingHPBonus : 0
        )
    }
}

public enum M4ScorePolicy {
    public static let usesComboMultiplier = false
    public static let rationale = "M4 keeps scoring linear and readable; route mastery is expressed through enemy, gift, completion, and remaining-HP points."
}
