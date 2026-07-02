#if canImport(SpriteKit)
import FlybyNighterCore

public enum VisualFeedbackCue: Equatable, Sendable {
    case playerShot
    case enemyRemoved
    case playerDamaged
    case giftCollected
    case shieldUsed
    case powerExpired
    case runCompleted
    case runFailed
}

struct GameEventFeedback: Equatable {
    let audioCue: PlaceholderAudioCue?
    let visualCue: VisualFeedbackCue?
}

enum GameEventFeedbackMapper {
    static func feedback(for event: GameEvent) -> GameEventFeedback? {
        switch event {
        case .playerFired:
            return GameEventFeedback(audioCue: .playerShot, visualCue: .playerShot)
        case .enemyRemoved:
            return GameEventFeedback(audioCue: .enemyRemoved, visualCue: .enemyRemoved)
        case .playerDamaged:
            return GameEventFeedback(audioCue: .playerDamaged, visualCue: .playerDamaged)
        case .giftCollected:
            return GameEventFeedback(audioCue: .giftCollected, visualCue: .giftCollected)
        case .shieldUsed:
            return GameEventFeedback(audioCue: .shieldUsed, visualCue: .shieldUsed)
        case .powerExpired:
            return GameEventFeedback(audioCue: nil, visualCue: .powerExpired)
        case .routeCompleted:
            return GameEventFeedback(audioCue: .runCompleted, visualCue: .runCompleted)
        case .runFailed:
            return GameEventFeedback(audioCue: .runFailed, visualCue: .runFailed)
        case .runStarted,
             .enemyFired,
             .enemySpawned,
             .giftSpawned,
             .obstacleSpawned,
             .damageIgnored:
            return nil
        }
    }
}
#endif
