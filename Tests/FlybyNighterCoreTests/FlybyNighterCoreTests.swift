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

    func testAuthoredContentSpawnsFromRouteProgress() {
        let enemy = EnemyState(
            id: 99,
            kind: .drifter,
            spawnProgress: 12,
            position: Vector2(x: 300, y: 300),
            velocity: Vector2(x: 0, y: 0),
            hp: 1,
            collisionRadius: 16
        )
        let gift = GiftState(id: 88, kind: .rapid, spawnProgress: 12, position: Vector2(x: 300, y: 260))
        let obstacle = ObstacleState(
            id: 77,
            kind: .staticObstacle,
            spawnProgress: 12,
            position: Vector2(x: 300, y: 340),
            velocity: Vector2(x: 0, y: 0),
            collisionBox: CollisionBox(halfWidth: 10, halfHeight: 10)
        )
        let config = GameConfig(routeSpeed: 12, initialContent: GameContent(enemies: [enemy], gifts: [gift], obstacles: [obstacle]))
        var game = FlybyNighterGame(config: config)
        _ = game.startRun()

        let events = game.update(deltaTime: 1.0)

        XCTAssertTrue(events.contains(.enemySpawned(.drifter)))
        XCTAssertTrue(events.contains(.giftSpawned(.rapid)))
        XCTAssertTrue(events.contains(.obstacleSpawned(.staticObstacle)))
        XCTAssertEqual(game.state.enemies.first?.isActive, true)
        XCTAssertEqual(game.state.gifts.first?.isActive, true)
        XCTAssertEqual(game.state.obstacles.first?.isActive, true)
    }

    func testPlayerProjectileCanRemoveSpawnedEnemyAndAwardScore() {
        let enemy = EnemyState(
            id: 1,
            kind: .drifter,
            spawnProgress: 0,
            position: Vector2(x: 190, y: 300),
            velocity: Vector2(x: 0, y: 0),
            hp: 1,
            collisionRadius: 18
        )
        let config = GameConfig(routeSpeed: 0, baseFireCooldown: 0.25, initialContent: GameContent(enemies: [enemy]))
        var game = FlybyNighterGame(config: config)
        _ = game.startRun()

        let events = game.update(deltaTime: 0.0, input: GameInput(isFiring: true))

        XCTAssertTrue(events.contains(.enemySpawned(.drifter)))
        XCTAssertTrue(events.contains(.playerFired(projectileCount: 1)))
        XCTAssertTrue(events.contains(.enemyRemoved(score: 100)))
        XCTAssertEqual(game.state.score, 100)
        XCTAssertEqual(game.state.enemies.first?.isRemoved, true)
        XCTAssertTrue(game.state.projectiles.isEmpty)
    }

    func testEnemyCanFireProjectile() {
        let enemy = EnemyState(
            id: 42,
            kind: .sentry,
            spawnProgress: 0,
            position: Vector2(x: 300, y: 300),
            velocity: Vector2(x: 0, y: 0),
            hp: 2,
            collisionRadius: 20,
            fireCooldownRemaining: 0,
            fireInterval: 1.2
        )
        let config = GameConfig(routeSpeed: 0, initialContent: GameContent(enemies: [enemy]))
        var game = FlybyNighterGame(config: config)
        _ = game.startRun()

        let events = game.update(deltaTime: 0.0)

        XCTAssertTrue(events.contains(.enemySpawned(.sentry)))
        XCTAssertTrue(events.contains(.enemyFired(enemyID: 42)))
        XCTAssertEqual(game.state.projectiles.count, 1)
        XCTAssertEqual(game.state.projectiles.first?.owner, .enemy)
    }

    func testEnemyProjectileCollisionDamagesPlayerThroughPublicUpdateLoop() {
        let enemy = EnemyState(
            id: 7,
            kind: .sentry,
            spawnProgress: 0,
            position: Vector2(x: 300, y: 300),
            velocity: Vector2(x: 0, y: 0),
            hp: 2,
            collisionRadius: 10,
            fireCooldownRemaining: 0,
            fireInterval: 5
        )
        let config = GameConfig(routeSpeed: 0, initialContent: GameContent(enemies: [enemy]))
        var game = FlybyNighterGame(config: config)
        _ = game.startRun()

        _ = game.update(deltaTime: 0.0)
        let events = game.update(deltaTime: 0.64)

        XCTAssertTrue(events.contains(.playerDamaged(remainingHP: 2)))
        XCTAssertEqual(game.state.player.hp, 2)
        XCTAssertTrue(game.state.projectiles.isEmpty)
    }

    func testGiftCollisionActivatesGiftAndAwardsScore() {
        let gift = GiftState(
            id: 1,
            kind: .spread,
            spawnProgress: 0,
            position: Vector2(x: 160, y: 300),
            collisionRadius: 16
        )
        let config = GameConfig(routeSpeed: 0, initialContent: GameContent(gifts: [gift]))
        var game = FlybyNighterGame(config: config)
        _ = game.startRun()

        let events = game.update(deltaTime: 0.0)

        XCTAssertTrue(events.contains(.giftSpawned(.spread)))
        XCTAssertTrue(events.contains(.giftCollected(.spread)))
        XCTAssertEqual(game.state.score, 50)
        XCTAssertEqual(game.state.player.activePower?.kind, .spread)
        XCTAssertEqual(game.state.gifts.first?.isCollected, true)
    }

    func testStaticObstacleCollisionDamagesPlayer() {
        let obstacle = ObstacleState(
            id: 1,
            kind: .staticObstacle,
            spawnProgress: 0,
            position: Vector2(x: 160, y: 300),
            velocity: Vector2(x: 0, y: 0),
            collisionBox: CollisionBox(halfWidth: 18, halfHeight: 18)
        )
        let config = GameConfig(routeSpeed: 0, initialContent: GameContent(obstacles: [obstacle]))
        var game = FlybyNighterGame(config: config)
        _ = game.startRun()

        let events = game.update(deltaTime: 0.0)

        XCTAssertTrue(events.contains(.obstacleSpawned(.staticObstacle)))
        XCTAssertTrue(events.contains(.playerDamaged(remainingHP: 2)))
        XCTAssertEqual(game.state.player.hp, 2)
    }

    func testPulseGateSafePhaseDoesNotDamagePlayer() {
        let gate = ObstacleState(
            id: 1,
            kind: .pulseGate,
            spawnProgress: 0,
            position: Vector2(x: 160, y: 300),
            velocity: Vector2(x: 0, y: 0),
            collisionBox: CollisionBox(halfWidth: 18, halfHeight: 18),
            pulsePeriod: 2.0,
            pulseDangerDuration: 0.5,
            pulsePhaseOffset: 1.0
        )
        let config = GameConfig(routeSpeed: 0, initialContent: GameContent(obstacles: [gate]))
        var game = FlybyNighterGame(config: config)
        _ = game.startRun()

        let events = game.update(deltaTime: 0.0)

        XCTAssertTrue(events.contains(.obstacleSpawned(.pulseGate)))
        XCTAssertFalse(events.contains(.playerDamaged(remainingHP: 2)))
        XCTAssertEqual(game.state.player.hp, 3)
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
