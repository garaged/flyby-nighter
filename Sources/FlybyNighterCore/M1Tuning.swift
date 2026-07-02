import Foundation

public extension GameContent {
    static let m1NeonRift = GameContent(
        enemies: [
            EnemyState(
                id: 1,
                kind: .drifter,
                spawnProgress: 360,
                position: Vector2(x: 368, y: 420),
                velocity: Vector2(x: -58, y: -8),
                hp: 1,
                collisionRadius: 18,
                fireCooldownRemaining: 1.2,
                fireInterval: 2.1
            ),
            EnemyState(
                id: 2,
                kind: .needler,
                spawnProgress: 980,
                position: Vector2(x: 374, y: 145),
                velocity: Vector2(x: -225, y: 70),
                hp: 1,
                collisionRadius: 14,
                fireInterval: nil
            ),
            EnemyState(
                id: 3,
                kind: .drifter,
                spawnProgress: 1_560,
                position: Vector2(x: 368, y: 225),
                velocity: Vector2(x: -62, y: 12),
                hp: 1,
                collisionRadius: 18,
                fireCooldownRemaining: 1.0,
                fireInterval: 2.0
            ),
            EnemyState(
                id: 4,
                kind: .sentry,
                spawnProgress: 2_220,
                position: Vector2(x: 374, y: 330),
                velocity: Vector2(x: -100, y: 0),
                hp: 2,
                collisionRadius: 20,
                fireCooldownRemaining: 0.9,
                fireInterval: 1.55
            ),
            EnemyState(
                id: 5,
                kind: .needler,
                spawnProgress: 2_920,
                position: Vector2(x: 374, y: 455),
                velocity: Vector2(x: -245, y: -72),
                hp: 1,
                collisionRadius: 14,
                fireInterval: nil
            )
        ],
        gifts: [
            GiftState(id: 1, kind: .rapid, spawnProgress: 620, position: Vector2(x: 368, y: 260)),
            GiftState(id: 2, kind: .spread, spawnProgress: 1_760, position: Vector2(x: 368, y: 440)),
            GiftState(id: 3, kind: .shield, spawnProgress: 2_680, position: Vector2(x: 368, y: 190))
        ],
        obstacles: [
            ObstacleState(
                id: 1,
                kind: .staticObstacle,
                spawnProgress: 820,
                position: Vector2(x: 376, y: 520),
                velocity: Vector2(x: -110, y: 0),
                collisionBox: CollisionBox(halfWidth: 30, halfHeight: 38)
            ),
            ObstacleState(
                id: 2,
                kind: .pulseGate,
                spawnProgress: 1_360,
                position: Vector2(x: 376, y: 300),
                velocity: Vector2(x: -105, y: 0),
                collisionBox: CollisionBox(halfWidth: 12, halfHeight: 205),
                pulsePeriod: 2.4,
                pulseDangerDuration: 0.75,
                pulsePhaseOffset: 1.1
            ),
            ObstacleState(
                id: 3,
                kind: .staticObstacle,
                spawnProgress: 2_080,
                position: Vector2(x: 376, y: 86),
                velocity: Vector2(x: -110, y: 0),
                collisionBox: CollisionBox(halfWidth: 34, halfHeight: 44)
            ),
            ObstacleState(
                id: 4,
                kind: .pulseGate,
                spawnProgress: 3_260,
                position: Vector2(x: 376, y: 300),
                velocity: Vector2(x: -110, y: 0),
                collisionBox: CollisionBox(halfWidth: 12, halfHeight: 212),
                pulsePeriod: 2.2,
                pulseDangerDuration: 0.70,
                pulsePhaseOffset: 0.8
            )
        ]
    )
}

public extension GameConfig {
    static let m1 = GameConfig(
        playerSpeed: 280,
        routeLength: 5_400,
        routeSpeed: 100,
        baseFireCooldown: 0.22,
        rapidFireCooldown: 0.085,
        giftDuration: 9,
        postHitInvulnerability: 1.15,
        bulletSpeed: 560,
        enemyBulletSpeed: 175,
        initialContent: .m1NeonRift
    )
}
