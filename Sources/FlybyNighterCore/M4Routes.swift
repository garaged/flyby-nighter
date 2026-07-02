import Foundation

public enum RouteID: String, CaseIterable, Equatable, Sendable {
    case neonRift = "neon-rift"
    case glassTide = "glass-tide"
}

public struct RouteDefinition: Equatable, Sendable {
    public var id: RouteID
    public var displayName: String
    public var summary: String
    public var segmentNames: [String]
    public var config: GameConfig

    public init(
        id: RouteID,
        displayName: String,
        summary: String,
        segmentNames: [String],
        config: GameConfig
    ) {
        self.id = id
        self.displayName = displayName
        self.summary = summary
        self.segmentNames = segmentNames
        self.config = config
    }
}

public enum RouteCatalog {
    public static let all: [RouteDefinition] = RouteID.allCases.map { $0.definition }

    public static func definition(for routeID: RouteID) -> RouteDefinition {
        routeID.definition
    }
}

public extension RouteID {
    var definition: RouteDefinition {
        switch self {
        case .neonRift:
            return RouteDefinition(
                id: self,
                displayName: "The Neon Rift",
                summary: "A balanced entry route with readable gates and a steady pressure ramp.",
                segmentNames: [
                    "Sector 01 Entry",
                    "Sector 02 Narrow",
                    "Sector 03 Gates",
                    "Sector 04 Midway",
                    "Sector 05 Cache",
                    "Sector 06 Spine",
                    "Sector 07 Exit"
                ],
                config: .m1
            )
        case .glassTide:
            return RouteDefinition(
                id: self,
                displayName: "The Glass Tide",
                summary: "A rhythm-first route with early gates, cross-lane pressure, and a faster final push.",
                segmentNames: [
                    "Tide 01 Threshold",
                    "Tide 02 Shards",
                    "Tide 03 Undertow",
                    "Tide 04 Crosscurrent",
                    "Tide 05 Stillwater",
                    "Tide 06 Breakline",
                    "Tide 07 Whiteout"
                ],
                config: .m4GlassTide
            )
        }
    }
}

public extension GameContent {
    static let glassTide = GameContent(
        enemies: [
            EnemyState(
                id: 101,
                kind: .sentry,
                spawnProgress: 520,
                position: Vector2(x: 376, y: 470),
                velocity: Vector2(x: -88, y: 0),
                hp: 2,
                collisionRadius: 20,
                fireCooldownRemaining: 1.25,
                fireInterval: 1.75
            ),
            EnemyState(
                id: 102,
                kind: .drifter,
                spawnProgress: 1_060,
                position: Vector2(x: 370, y: 170),
                velocity: Vector2(x: -56, y: 10),
                hp: 1,
                collisionRadius: 18,
                fireCooldownRemaining: 1.0,
                fireInterval: 2.0
            ),
            EnemyState(
                id: 103,
                kind: .needler,
                spawnProgress: 1_680,
                position: Vector2(x: 378, y: 500),
                velocity: Vector2(x: -232, y: -82),
                hp: 1,
                collisionRadius: 14,
                fireInterval: nil
            ),
            EnemyState(
                id: 104,
                kind: .sentry,
                spawnProgress: 2_480,
                position: Vector2(x: 378, y: 285),
                velocity: Vector2(x: -96, y: 0),
                hp: 2,
                collisionRadius: 20,
                fireCooldownRemaining: 0.8,
                fireInterval: 1.45
            ),
            EnemyState(
                id: 105,
                kind: .drifter,
                spawnProgress: 3_360,
                position: Vector2(x: 372, y: 420),
                velocity: Vector2(x: -64, y: -12),
                hp: 1,
                collisionRadius: 18,
                fireCooldownRemaining: 0.9,
                fireInterval: 1.8
            ),
            EnemyState(
                id: 106,
                kind: .needler,
                spawnProgress: 4_340,
                position: Vector2(x: 380, y: 125),
                velocity: Vector2(x: -250, y: 86),
                hp: 1,
                collisionRadius: 14,
                fireInterval: nil
            )
        ],
        gifts: [
            GiftState(id: 101, kind: .shield, spawnProgress: 780, position: Vector2(x: 370, y: 290)),
            GiftState(id: 102, kind: .rapid, spawnProgress: 2_180, position: Vector2(x: 370, y: 455)),
            GiftState(id: 103, kind: .spread, spawnProgress: 3_820, position: Vector2(x: 370, y: 205))
        ],
        obstacles: [
            ObstacleState(
                id: 101,
                kind: .pulseGate,
                spawnProgress: 360,
                position: Vector2(x: 378, y: 300),
                velocity: Vector2(x: -104, y: 0),
                collisionBox: CollisionBox(halfWidth: 12, halfHeight: 182),
                pulsePeriod: 2.6,
                pulseDangerDuration: 0.65,
                pulsePhaseOffset: 1.25
            ),
            ObstacleState(
                id: 102,
                kind: .staticObstacle,
                spawnProgress: 1_340,
                position: Vector2(x: 380, y: 82),
                velocity: Vector2(x: -112, y: 0),
                collisionBox: CollisionBox(halfWidth: 42, halfHeight: 50)
            ),
            ObstacleState(
                id: 103,
                kind: .pulseGate,
                spawnProgress: 1_940,
                position: Vector2(x: 380, y: 300),
                velocity: Vector2(x: -108, y: 0),
                collisionBox: CollisionBox(halfWidth: 12, halfHeight: 198),
                pulsePeriod: 2.2,
                pulseDangerDuration: 0.62,
                pulsePhaseOffset: 0.9
            ),
            ObstacleState(
                id: 104,
                kind: .staticObstacle,
                spawnProgress: 2_940,
                position: Vector2(x: 380, y: 518),
                velocity: Vector2(x: -112, y: 0),
                collisionBox: CollisionBox(halfWidth: 38, halfHeight: 46)
            ),
            ObstacleState(
                id: 105,
                kind: .pulseGate,
                spawnProgress: 4_080,
                position: Vector2(x: 380, y: 300),
                velocity: Vector2(x: -112, y: 0),
                collisionBox: CollisionBox(halfWidth: 12, halfHeight: 205),
                pulsePeriod: 2.0,
                pulseDangerDuration: 0.58,
                pulsePhaseOffset: 1.15
            )
        ]
    )
}

public extension GameConfig {
    static let m4GlassTide = GameConfig(
        playerSpeed: 286,
        routeLength: 6_000,
        routeSpeed: 105,
        baseFireCooldown: 0.21,
        rapidFireCooldown: 0.08,
        giftDuration: 9.5,
        postHitInvulnerability: 1.15,
        bulletSpeed: 570,
        enemyBulletSpeed: 180,
        initialContent: .glassTide
    )
}
