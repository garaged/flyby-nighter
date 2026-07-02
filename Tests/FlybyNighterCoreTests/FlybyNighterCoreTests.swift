import XCTest
@testable import FlybyNighterCore

final class FlybyNighterCoreTests: XCTestCase {
    func testInitialStateStartsAtTitle() {
        let game = FlybyNighterGame()

        XCTAssertEqual(game.state.runState, .title)
        XCTAssertEqual(game.state.player.hp, 3)
        XCTAssertEqual(game.state.score, 0)
        XCTAssertEqual(game.state.routeProgress, 0)
    }

    func testStartRunInitializesPlayableState() {
        var game = FlybyNighterGame()
        let events = game.startRun()

        XCTAssertEqual(events, [.runStarted])
        XCTAssertEqual(game.state.runState, .playing)
        XCTAssertEqual(game.state.player.hp, 3)
        XCTAssertEqual(game.state.score, 0)
    }

    func testRouteProgressCompletesRun() {
        let config = GameConfig(routeLength: 120, routeSpeed: 120)
        var game = FlybyNighterGame(config: config)
        _ = game.startRun()

        let events = game.update(deltaTime: 1.0)

        XCTAssertEqual(game.state.routeProgress, 120)
        XCTAssertEqual(game.state.runState, .completed)
        XCTAssertTrue(events.contains(.routeCompleted(score: 1_300)))
    }

    func testBaseFireCreatesOneForwardProjectile() {
        var game = FlybyNighterGame()
        _ = game.startRun()

        let events = game.update(deltaTime: 0.0, input: GameInput(isFiring: true))

        XCTAssertEqual(game.state.projectiles.count, 1)
        XCTAssertEqual(game.state.projectiles.first?.velocity.y, 0)
        XCTAssertEqual(game.state.projectiles.first?.velocity.x, game.config.bulletSpeed)
        XCTAssertEqual(events, [.playerFired(projectileCount: 1)])
    }

    func testRapidGiftReducesFireCooldownAndExpires() {
        var game = FlybyNighterGame()
        _ = game.startRun()
        _ = game.collectGift(.rapid)

        _ = game.update(deltaTime: 0.0, input: GameInput(isFiring: true))

        XCTAssertEqual(game.state.fireCooldownRemaining, game.config.rapidFireCooldown, accuracy: 0.0001)
        XCTAssertEqual(game.state.player.activePower?.kind, .rapid)

        let events = game.update(deltaTime: game.config.giftDuration)

        XCTAssertNil(game.state.player.activePower)
        XCTAssertTrue(events.contains(.powerExpired(.rapid)))
    }

    func testSpreadGiftCreatesThreeProjectilesAndExpires() {
        var game = FlybyNighterGame()
        _ = game.startRun()
        _ = game.collectGift(.spread)

        let events = game.update(deltaTime: 0.0, input: GameInput(isFiring: true))

        XCTAssertEqual(game.state.projectiles.count, 3)
        XCTAssertEqual(events, [.playerFired(projectileCount: 3)])
        XCTAssertEqual(game.state.projectiles.map(\.velocity.y), [0, game.config.bulletSpeed * 0.25, -game.config.bulletSpeed * 0.25])

        let expiryEvents = game.update(deltaTime: game.config.giftDuration)

        XCTAssertNil(game.state.player.activePower)
        XCTAssertTrue(expiryEvents.contains(.powerExpired(.spread)))
    }

    func testOffensiveGiftReplacesCurrentOffensivePower() {
        var game = FlybyNighterGame()
        _ = game.startRun()
        _ = game.collectGift(.rapid)
        _ = game.update(deltaTime: 2.0)

        _ = game.collectGift(.spread)

        XCTAssertEqual(game.state.player.activePower, ActivePower(kind: .spread, remainingTime: game.config.giftDuration))
    }

    func testShieldAbsorbsOneDamageEventBeforeHpLoss() {
        var game = FlybyNighterGame()
        _ = game.startRun()
        _ = game.collectGift(.shield)

        let events = game.applyDamage(from: .enemyBullet)

        XCTAssertEqual(events, [.shieldUsed])
        XCTAssertEqual(game.state.player.hp, 3)
        XCTAssertEqual(game.state.player.shieldCharges, 0)
    }

    func testInvulnerabilityPreventsImmediateRepeatedDamage() {
        var game = FlybyNighterGame()
        _ = game.startRun()

        let firstDamage = game.applyDamage(from: .enemyBullet)
        let repeatedDamage = game.applyDamage(from: .enemyBullet)

        XCTAssertEqual(firstDamage, [.playerDamaged(remainingHP: 2)])
        XCTAssertEqual(repeatedDamage, [.damageIgnored])
        XCTAssertEqual(game.state.player.hp, 2)
    }

    func testHpReachingZeroFailsRun() {
        var game = FlybyNighterGame()
        _ = game.startRun()

        _ = game.applyDamage(from: .enemyBullet)
        _ = game.update(deltaTime: game.config.postHitInvulnerability)
        _ = game.applyDamage(from: .enemyBullet)
        _ = game.update(deltaTime: game.config.postHitInvulnerability)
        let finalEvents = game.applyDamage(from: .enemyBullet)

        XCTAssertEqual(game.state.player.hp, 0)
        XCTAssertEqual(game.state.runState, .failed)
        XCTAssertTrue(finalEvents.contains(.playerDamaged(remainingHP: 0)))
        XCTAssertTrue(finalEvents.contains(.runFailed(score: 0)))
    }

    func testEnemyRemovalAwardsScore() {
        var game = FlybyNighterGame()
        _ = game.startRun()

        let events = game.recordEnemyRemoved()

        XCTAssertEqual(game.state.score, 100)
        XCTAssertEqual(events, [.enemyRemoved(score: 100)])
    }

    func testRestartResetsRunStateAndTransientGameplay() {
        var game = FlybyNighterGame()
        _ = game.startRun()
        _ = game.collectGift(.spread)
        _ = game.collectGift(.shield)
        _ = game.update(deltaTime: 0.0, input: GameInput(movement: Vector2(x: 1, y: 1), isFiring: true))
        _ = game.applyDamage(from: .enemyBullet)
        _ = game.recordEnemyRemoved()

        let restartEvents = game.restartRun()

        XCTAssertEqual(restartEvents, [.runStarted])
        XCTAssertEqual(game.state.runState, .playing)
        XCTAssertEqual(game.state.player.hp, 3)
        XCTAssertEqual(game.state.player.position, game.config.initialPlayerPosition)
        XCTAssertNil(game.state.player.activePower)
        XCTAssertEqual(game.state.player.shieldCharges, 0)
        XCTAssertEqual(game.state.player.invulnerabilityRemaining, 0)
        XCTAssertEqual(game.state.routeProgress, 0)
        XCTAssertEqual(game.state.score, 0)
        XCTAssertTrue(game.state.projectiles.isEmpty)
    }
}
