import Foundation

public struct Vector2: Equatable, Sendable {
    public var x: Double
    public var y: Double

    public init(x: Double = 0, y: Double = 0) {
        self.x = x
        self.y = y
    }

    public func clampedComponents(min minimum: Double, max maximum: Double) -> Vector2 {
        Vector2(
            x: Swift.min(Swift.max(x, minimum), maximum),
            y: Swift.min(Swift.max(y, minimum), maximum)
        )
    }

    public func distanceSquared(to other: Vector2) -> Double {
        let dx = x - other.x
        let dy = y - other.y
        return dx * dx + dy * dy
    }
}

public struct PlayableBounds: Equatable, Sendable {
    public var minX: Double
    public var maxX: Double
    public var minY: Double
    public var maxY: Double

    public init(minX: Double, maxX: Double, minY: Double, maxY: Double) {
        precondition(minX <= maxX, "minX must be <= maxX")
        precondition(minY <= maxY, "minY must be <= maxY")
        self.minX = minX
        self.maxX = maxX
        self.minY = minY
        self.maxY = maxY
    }

    public func clamp(_ point: Vector2) -> Vector2 {
        Vector2(
            x: Swift.min(Swift.max(point.x, minX), maxX),
            y: Swift.min(Swift.max(point.y, minY), maxY)
        )
    }
}

public struct CollisionBox: Equatable, Sendable {
    public var halfWidth: Double
    public var halfHeight: Double

    public init(halfWidth: Double, halfHeight: Double) {
        self.halfWidth = halfWidth
        self.halfHeight = halfHeight
    }

    public func contains(circleCenter: Vector2, circleRadius: Double, boxCenter: Vector2) -> Bool {
        let closestX = Swift.min(Swift.max(circleCenter.x, boxCenter.x - halfWidth), boxCenter.x + halfWidth)
        let closestY = Swift.min(Swift.max(circleCenter.y, boxCenter.y - halfHeight), boxCenter.y + halfHeight)
        let closestPoint = Vector2(x: closestX, y: closestY)
        return closestPoint.distanceSquared(to: circleCenter) <= circleRadius * circleRadius
    }
}

public enum RunState: Equatable, Sendable {
    case title
    case playing
    case completed
    case failed
}

public enum PowerKind: Equatable, Sendable {
    case rapid
    case spread
}

public enum GiftKind: Equatable, Sendable {
    case rapid
    case spread
    case shield
}

public enum ProjectileOwner: Equatable, Sendable {
    case player
    case enemy
}

public enum DamageSource: Equatable, Sendable {
    case enemyBullet
    case enemyCollision
    case staticObstacle
    case pulseGate
}

public enum EnemyKind: Equatable, Sendable {
    case drifter
    case needler
    case sentry
}

public enum ObstacleKind: Equatable, Sendable {
    case staticObstacle
    case pulseGate
}

public struct ActivePower: Equatable, Sendable {
    public var kind: PowerKind
    public var remainingTime: TimeInterval

    public init(kind: PowerKind, remainingTime: TimeInterval) {
        self.kind = kind
        self.remainingTime = remainingTime
    }
}

public struct PlayerState: Equatable, Sendable {
    public var position: Vector2
    public var hp: Int
    public var shieldCharges: Int
    public var invulnerabilityRemaining: TimeInterval
    public var activePower: ActivePower?

    public init(
        position: Vector2,
        hp: Int = 3,
        shieldCharges: Int = 0,
        invulnerabilityRemaining: TimeInterval = 0,
        activePower: ActivePower? = nil
    ) {
        self.position = position
        self.hp = hp
        self.shieldCharges = shieldCharges
        self.invulnerabilityRemaining = invulnerabilityRemaining
        self.activePower = activePower
    }
}

public struct ProjectileState: Equatable, Identifiable, Sendable {
    public var id: Int
    public var owner: ProjectileOwner
    public var position: Vector2
    public var velocity: Vector2
    public var damage: Int
    public var collisionRadius: Double

    public init(
        id: Int,
        owner: ProjectileOwner,
        position: Vector2,
        velocity: Vector2,
        damage: Int = 1,
        collisionRadius: Double = 4
    ) {
        self.id = id
        self.owner = owner
        self.position = position
        self.velocity = velocity
        self.damage = damage
        self.collisionRadius = collisionRadius
    }
}

public struct EnemyState: Equatable, Identifiable, Sendable {
    public var id: Int
    public var kind: EnemyKind
    public var spawnProgress: Double
    public var position: Vector2
    public var velocity: Vector2
    public var hp: Int
    public var collisionRadius: Double
    public var isActive: Bool
    public var isRemoved: Bool
    public var fireCooldownRemaining: TimeInterval
    public var fireInterval: TimeInterval?

    public init(
        id: Int,
        kind: EnemyKind,
        spawnProgress: Double,
        position: Vector2,
        velocity: Vector2,
        hp: Int,
        collisionRadius: Double,
        isActive: Bool = false,
        isRemoved: Bool = false,
        fireCooldownRemaining: TimeInterval = 0,
        fireInterval: TimeInterval? = nil
    ) {
        self.id = id
        self.kind = kind
        self.spawnProgress = spawnProgress
        self.position = position
        self.velocity = velocity
        self.hp = hp
        self.collisionRadius = collisionRadius
        self.isActive = isActive
        self.isRemoved = isRemoved
        self.fireCooldownRemaining = fireCooldownRemaining
        self.fireInterval = fireInterval
    }
}

public struct GiftState: Equatable, Identifiable, Sendable {
    public var id: Int
    public var kind: GiftKind
    public var spawnProgress: Double
    public var position: Vector2
    public var collisionRadius: Double
    public var isActive: Bool
    public var isCollected: Bool

    public init(
        id: Int,
        kind: GiftKind,
        spawnProgress: Double,
        position: Vector2,
        collisionRadius: Double = 16,
        isActive: Bool = false,
        isCollected: Bool = false
    ) {
        self.id = id
        self.kind = kind
        self.spawnProgress = spawnProgress
        self.position = position
        self.collisionRadius = collisionRadius
        self.isActive = isActive
        self.isCollected = isCollected
    }
}

public struct ObstacleState: Equatable, Identifiable, Sendable {
    public var id: Int
    public var kind: ObstacleKind
    public var spawnProgress: Double
    public var position: Vector2
    public var velocity: Vector2
    public var collisionBox: CollisionBox
    public var isActive: Bool
    public var pulsePeriod: TimeInterval
    public var pulseDangerDuration: TimeInterval
    public var pulsePhaseOffset: TimeInterval

    public init(
        id: Int,
        kind: ObstacleKind,
        spawnProgress: Double,
        position: Vector2,
        velocity: Vector2,
        collisionBox: CollisionBox,
        isActive: Bool = false,
        pulsePeriod: TimeInterval = 2.0,
        pulseDangerDuration: TimeInterval = 1.0,
        pulsePhaseOffset: TimeInterval = 0
    ) {
        self.id = id
        self.kind = kind
        self.spawnProgress = spawnProgress
        self.position = position
        self.velocity = velocity
        self.collisionBox = collisionBox
        self.isActive = isActive
        self.pulsePeriod = pulsePeriod
        self.pulseDangerDuration = pulseDangerDuration
        self.pulsePhaseOffset = pulsePhaseOffset
    }

    public func isDangerous(elapsedTime: TimeInterval) -> Bool {
        switch kind {
        case .staticObstacle:
            return true
        case .pulseGate:
            guard pulsePeriod > 0 else { return true }
            let phase = (elapsedTime + pulsePhaseOffset).truncatingRemainder(dividingBy: pulsePeriod)
            return phase >= 0 && phase < pulseDangerDuration
        }
    }
}

public struct GameContent: Equatable, Sendable {
    public var enemies: [EnemyState]
    public var gifts: [GiftState]
    public var obstacles: [ObstacleState]

    public init(enemies: [EnemyState] = [], gifts: [GiftState] = [], obstacles: [ObstacleState] = []) {
        self.enemies = enemies
        self.gifts = gifts
        self.obstacles = obstacles
    }

    public static let empty = GameContent()

    public static let neonRift = GameContent(
        enemies: [
            EnemyState(
                id: 1,
                kind: .drifter,
                spawnProgress: 260,
                position: Vector2(x: 360, y: 420),
                velocity: Vector2(x: -65, y: -12),
                hp: 1,
                collisionRadius: 18,
                fireCooldownRemaining: 0.8,
                fireInterval: 1.8
            ),
            EnemyState(
                id: 2,
                kind: .needler,
                spawnProgress: 720,
                position: Vector2(x: 365, y: 145),
                velocity: Vector2(x: -260, y: 85),
                hp: 1,
                collisionRadius: 14,
                fireInterval: nil
            ),
            EnemyState(
                id: 3,
                kind: .sentry,
                spawnProgress: 1_280,
                position: Vector2(x: 365, y: 300),
                velocity: Vector2(x: -120, y: 0),
                hp: 2,
                collisionRadius: 20,
                fireCooldownRemaining: 0.4,
                fireInterval: 1.2
            )
        ],
        gifts: [
            GiftState(id: 1, kind: .rapid, spawnProgress: 430, position: Vector2(x: 360, y: 245)),
            GiftState(id: 2, kind: .spread, spawnProgress: 970, position: Vector2(x: 360, y: 470)),
            GiftState(id: 3, kind: .shield, spawnProgress: 1_520, position: Vector2(x: 360, y: 180))
        ],
        obstacles: [
            ObstacleState(
                id: 1,
                kind: .staticObstacle,
                spawnProgress: 520,
                position: Vector2(x: 370, y: 520),
                velocity: Vector2(x: -120, y: 0),
                collisionBox: CollisionBox(halfWidth: 32, halfHeight: 42)
            ),
            ObstacleState(
                id: 2,
                kind: .staticObstacle,
                spawnProgress: 1_050,
                position: Vector2(x: 370, y: 80),
                velocity: Vector2(x: -120, y: 0),
                collisionBox: CollisionBox(halfWidth: 38, halfHeight: 48)
            ),
            ObstacleState(
                id: 3,
                kind: .pulseGate,
                spawnProgress: 1_760,
                position: Vector2(x: 370, y: 300),
                velocity: Vector2(x: -120, y: 0),
                collisionBox: CollisionBox(halfWidth: 14, halfHeight: 225),
                pulsePeriod: 2.0,
                pulseDangerDuration: 1.0,
                pulsePhaseOffset: 0
            )
        ]
    )
}

public struct GameInput: Equatable, Sendable {
    public var movement: Vector2
    public var isFiring: Bool

    public init(movement: Vector2 = Vector2(), isFiring: Bool = false) {
        self.movement = movement
        self.isFiring = isFiring
    }
}

public struct GameConfig: Equatable, Sendable {
    public var maxHP: Int
    public var initialPlayerPosition: Vector2
    public var playableBounds: PlayableBounds
    public var playerSpeed: Double
    public var routeLength: Double
    public var routeSpeed: Double
    public var baseFireCooldown: TimeInterval
    public var rapidFireCooldown: TimeInterval
    public var giftDuration: TimeInterval
    public var postHitInvulnerability: TimeInterval
    public var bulletSpeed: Double
    public var enemyBulletSpeed: Double
    public var offscreenProjectilePadding: Double
    public var playerCollisionRadius: Double
    public var enemyScore: Int
    public var giftScore: Int
    public var completionScore: Int
    public var remainingHPBonus: Int
    public var initialContent: GameContent

    public init(
        maxHP: Int = 3,
        initialPlayerPosition: Vector2 = Vector2(x: 160, y: 300),
        playableBounds: PlayableBounds = PlayableBounds(minX: 48, maxX: 320, minY: 48, maxY: 552),
        playerSpeed: Double = 260,
        routeLength: Double = 4_000,
        routeSpeed: Double = 120,
        baseFireCooldown: TimeInterval = 0.25,
        rapidFireCooldown: TimeInterval = 0.10,
        giftDuration: TimeInterval = 8,
        postHitInvulnerability: TimeInterval = 1,
        bulletSpeed: Double = 520,
        enemyBulletSpeed: Double = 190,
        offscreenProjectilePadding: Double = 420,
        playerCollisionRadius: Double = 14,
        enemyScore: Int = 100,
        giftScore: Int = 50,
        completionScore: Int = 1_000,
        remainingHPBonus: Int = 100,
        initialContent: GameContent = .neonRift
    ) {
        self.maxHP = maxHP
        self.initialPlayerPosition = initialPlayerPosition
        self.playableBounds = playableBounds
        self.playerSpeed = playerSpeed
        self.routeLength = routeLength
        self.routeSpeed = routeSpeed
        self.baseFireCooldown = baseFireCooldown
        self.rapidFireCooldown = rapidFireCooldown
        self.giftDuration = giftDuration
        self.postHitInvulnerability = postHitInvulnerability
        self.bulletSpeed = bulletSpeed
        self.enemyBulletSpeed = enemyBulletSpeed
        self.offscreenProjectilePadding = offscreenProjectilePadding
        self.playerCollisionRadius = playerCollisionRadius
        self.enemyScore = enemyScore
        self.giftScore = giftScore
        self.completionScore = completionScore
        self.remainingHPBonus = remainingHPBonus
        self.initialContent = initialContent
    }

    public static let m0 = GameConfig()
}

public struct GameState: Equatable, Sendable {
    public var runState: RunState
    public var elapsedTime: TimeInterval
    public var routeProgress: Double
    public var score: Int
    public var player: PlayerState
    public var projectiles: [ProjectileState]
    public var enemies: [EnemyState]
    public var gifts: [GiftState]
    public var obstacles: [ObstacleState]
    public var fireCooldownRemaining: TimeInterval
    public var nextProjectileID: Int

    public init(
        runState: RunState,
        elapsedTime: TimeInterval = 0,
        routeProgress: Double,
        score: Int,
        player: PlayerState,
        projectiles: [ProjectileState] = [],
        enemies: [EnemyState] = [],
        gifts: [GiftState] = [],
        obstacles: [ObstacleState] = [],
        fireCooldownRemaining: TimeInterval = 0,
        nextProjectileID: Int = 1
    ) {
        self.runState = runState
        self.elapsedTime = elapsedTime
        self.routeProgress = routeProgress
        self.score = score
        self.player = player
        self.projectiles = projectiles
        self.enemies = enemies
        self.gifts = gifts
        self.obstacles = obstacles
        self.fireCooldownRemaining = fireCooldownRemaining
        self.nextProjectileID = nextProjectileID
    }

    public static func title(config: GameConfig = .m0) -> GameState {
        GameState(
            runState: .title,
            routeProgress: 0,
            score: 0,
            player: PlayerState(position: config.initialPlayerPosition, hp: config.maxHP),
            enemies: config.initialContent.enemies,
            gifts: config.initialContent.gifts,
            obstacles: config.initialContent.obstacles
        )
    }

    public static func freshRun(config: GameConfig = .m0) -> GameState {
        GameState(
            runState: .playing,
            routeProgress: 0,
            score: 0,
            player: PlayerState(position: config.initialPlayerPosition, hp: config.maxHP),
            enemies: config.initialContent.enemies,
            gifts: config.initialContent.gifts,
            obstacles: config.initialContent.obstacles
        )
    }
}

public enum GameEvent: Equatable, Sendable {
    case runStarted
    case routeCompleted(score: Int)
    case runFailed(score: Int)
    case playerFired(projectileCount: Int)
    case enemyFired(enemyID: Int)
    case enemySpawned(EnemyKind)
    case giftSpawned(GiftKind)
    case obstacleSpawned(ObstacleKind)
    case giftCollected(GiftKind)
    case powerExpired(PowerKind)
    case shieldUsed
    case playerDamaged(remainingHP: Int)
    case damageIgnored
    case enemyRemoved(score: Int)
}

public struct FlybyNighterGame: Equatable, Sendable {
    public private(set) var state: GameState
    public var config: GameConfig

    public init(config: GameConfig = .m0) {
        self.config = config
        self.state = .title(config: config)
    }

    public mutating func startRun() -> [GameEvent] {
        state = .freshRun(config: config)
        return [.runStarted]
    }

    public mutating func restartRun() -> [GameEvent] {
        startRun()
    }

    @discardableResult
    public mutating func update(deltaTime rawDeltaTime: TimeInterval, input: GameInput = GameInput()) -> [GameEvent] {
        guard state.runState == .playing else { return [] }

        let deltaTime = Swift.max(0, rawDeltaTime)
        var events: [GameEvent] = []

        state.elapsedTime += deltaTime
        events.append(contentsOf: advanceTimers(deltaTime: deltaTime))
        applyMovement(deltaTime: deltaTime, movement: input.movement)
        state.routeProgress = Swift.min(config.routeLength, state.routeProgress + config.routeSpeed * deltaTime)
        events.append(contentsOf: spawnContent())
        advanceWorldContent(deltaTime: deltaTime)
        events.append(contentsOf: fireEnemies(deltaTime: deltaTime))

        if input.isFiring {
            events.append(contentsOf: fireIfReady())
        }

        advanceProjectiles(deltaTime: deltaTime)
        events.append(contentsOf: resolveCollisions())

        if state.routeProgress >= config.routeLength, state.runState == .playing {
            state.runState = .completed
            state.score += config.completionScore + state.player.hp * config.remainingHPBonus
            events.append(.routeCompleted(score: state.score))
        }

        return events
    }

    @discardableResult
    public mutating func collectGift(_ gift: GiftKind) -> [GameEvent] {
        guard state.runState == .playing else { return [] }
        applyGiftEffect(gift)
        state.score += config.giftScore
        return [.giftCollected(gift)]
    }

    @discardableResult
    public mutating func applyDamage(from source: DamageSource) -> [GameEvent] {
        guard state.runState == .playing else { return [.damageIgnored] }
        guard state.player.invulnerabilityRemaining <= 0 else { return [.damageIgnored] }

        if state.player.shieldCharges > 0 {
            state.player.shieldCharges -= 1
            state.player.invulnerabilityRemaining = config.postHitInvulnerability
            return [.shieldUsed]
        }

        state.player.hp = Swift.max(0, state.player.hp - 1)
        state.player.invulnerabilityRemaining = config.postHitInvulnerability

        var events: [GameEvent] = [.playerDamaged(remainingHP: state.player.hp)]
        if state.player.hp == 0 {
            state.runState = .failed
            events.append(.runFailed(score: state.score))
        }
        return events
    }

    @discardableResult
    public mutating func recordEnemyRemoved() -> [GameEvent] {
        guard state.runState == .playing else { return [] }
        state.score += config.enemyScore
        return [.enemyRemoved(score: state.score)]
    }

    private mutating func advanceTimers(deltaTime: TimeInterval) -> [GameEvent] {
        var events: [GameEvent] = []

        state.fireCooldownRemaining = Swift.max(0, state.fireCooldownRemaining - deltaTime)
        state.player.invulnerabilityRemaining = Swift.max(0, state.player.invulnerabilityRemaining - deltaTime)

        if var activePower = state.player.activePower {
            activePower.remainingTime -= deltaTime
            if activePower.remainingTime <= 0 {
                state.player.activePower = nil
                events.append(.powerExpired(activePower.kind))
            } else {
                state.player.activePower = activePower
            }
        }

        return events
    }

    private mutating func applyMovement(deltaTime: TimeInterval, movement rawMovement: Vector2) {
        let movement = rawMovement.clampedComponents(min: -1, max: 1)
        let nextPosition = Vector2(
            x: state.player.position.x + movement.x * config.playerSpeed * deltaTime,
            y: state.player.position.y + movement.y * config.playerSpeed * deltaTime
        )
        state.player.position = config.playableBounds.clamp(nextPosition)
    }

    private mutating func spawnContent() -> [GameEvent] {
        var events: [GameEvent] = []

        for index in state.enemies.indices where !state.enemies[index].isActive && !state.enemies[index].isRemoved {
            if state.routeProgress >= state.enemies[index].spawnProgress {
                state.enemies[index].isActive = true
                events.append(.enemySpawned(state.enemies[index].kind))
            }
        }

        for index in state.gifts.indices where !state.gifts[index].isActive && !state.gifts[index].isCollected {
            if state.routeProgress >= state.gifts[index].spawnProgress {
                state.gifts[index].isActive = true
                events.append(.giftSpawned(state.gifts[index].kind))
            }
        }

        for index in state.obstacles.indices where !state.obstacles[index].isActive {
            if state.routeProgress >= state.obstacles[index].spawnProgress {
                state.obstacles[index].isActive = true
                events.append(.obstacleSpawned(state.obstacles[index].kind))
            }
        }

        return events
    }

    private mutating func advanceWorldContent(deltaTime: TimeInterval) {
        for index in state.enemies.indices where state.enemies[index].isActive && !state.enemies[index].isRemoved {
            state.enemies[index].position.x += state.enemies[index].velocity.x * deltaTime
            state.enemies[index].position.y += state.enemies[index].velocity.y * deltaTime
        }

        for index in state.gifts.indices where state.gifts[index].isActive && !state.gifts[index].isCollected {
            state.gifts[index].position.x -= config.routeSpeed * deltaTime
        }

        for index in state.obstacles.indices where state.obstacles[index].isActive {
            state.obstacles[index].position.x += state.obstacles[index].velocity.x * deltaTime
            state.obstacles[index].position.y += state.obstacles[index].velocity.y * deltaTime
        }

        let minimumX = config.playableBounds.minX - config.offscreenProjectilePadding
        for index in state.enemies.indices where state.enemies[index].isActive && !state.enemies[index].isRemoved {
            if state.enemies[index].position.x < minimumX {
                state.enemies[index].isRemoved = true
            }
        }
        for index in state.gifts.indices where state.gifts[index].isActive && !state.gifts[index].isCollected {
            if state.gifts[index].position.x < minimumX {
                state.gifts[index].isCollected = true
            }
        }
    }

    private mutating func fireEnemies(deltaTime: TimeInterval) -> [GameEvent] {
        var events: [GameEvent] = []

        for index in state.enemies.indices where state.enemies[index].isActive && !state.enemies[index].isRemoved {
            guard let fireInterval = state.enemies[index].fireInterval else { continue }
            state.enemies[index].fireCooldownRemaining -= deltaTime
            guard state.enemies[index].fireCooldownRemaining <= 0 else { continue }

            state.enemies[index].fireCooldownRemaining = fireInterval
            let projectile = makeEnemyProjectile(from: state.enemies[index])
            state.projectiles.append(projectile)
            events.append(.enemyFired(enemyID: state.enemies[index].id))
        }

        return events
    }

    private mutating func makeEnemyProjectile(from enemy: EnemyState) -> ProjectileState {
        let velocity: Vector2
        switch enemy.kind {
        case .drifter:
            let dx = state.player.position.x - enemy.position.x
            let dy = state.player.position.y - enemy.position.y
            let length = Swift.max(1, sqrt(dx * dx + dy * dy))
            velocity = Vector2(x: dx / length * config.enemyBulletSpeed, y: dy / length * config.enemyBulletSpeed)
        case .needler:
            velocity = Vector2(x: -config.enemyBulletSpeed, y: 0)
        case .sentry:
            velocity = Vector2(x: -config.enemyBulletSpeed * 1.15, y: 0)
        }

        let projectile = ProjectileState(
            id: state.nextProjectileID,
            owner: .enemy,
            position: enemy.position,
            velocity: velocity,
            collisionRadius: 5
        )
        state.nextProjectileID += 1
        return projectile
    }

    private mutating func fireIfReady() -> [GameEvent] {
        guard state.fireCooldownRemaining <= 0 else { return [] }

        let projectiles = makePlayerProjectiles()
        state.projectiles.append(contentsOf: projectiles)
        state.fireCooldownRemaining = currentFireCooldown
        return [.playerFired(projectileCount: projectiles.count)]
    }

    private var currentFireCooldown: TimeInterval {
        state.player.activePower?.kind == .rapid ? config.rapidFireCooldown : config.baseFireCooldown
    }

    private mutating func makePlayerProjectiles() -> [ProjectileState] {
        let origin = Vector2(x: state.player.position.x + 24, y: state.player.position.y)
        let spreadVerticalSpeed = config.bulletSpeed * 0.25

        let velocities: [Vector2]
        if state.player.activePower?.kind == .spread {
            velocities = [
                Vector2(x: config.bulletSpeed, y: 0),
                Vector2(x: config.bulletSpeed, y: spreadVerticalSpeed),
                Vector2(x: config.bulletSpeed, y: -spreadVerticalSpeed)
            ]
        } else {
            velocities = [Vector2(x: config.bulletSpeed, y: 0)]
        }

        return velocities.map { velocity in
            let projectile = ProjectileState(
                id: state.nextProjectileID,
                owner: .player,
                position: origin,
                velocity: velocity
            )
            state.nextProjectileID += 1
            return projectile
        }
    }

    private mutating func advanceProjectiles(deltaTime: TimeInterval) {
        for index in state.projectiles.indices {
            state.projectiles[index].position.x += state.projectiles[index].velocity.x * deltaTime
            state.projectiles[index].position.y += state.projectiles[index].velocity.y * deltaTime
        }

        let maxVisibleX = config.playableBounds.maxX + config.offscreenProjectilePadding
        let minVisibleX = config.playableBounds.minX - config.offscreenProjectilePadding
        let maxVisibleY = config.playableBounds.maxY + config.offscreenProjectilePadding
        let minVisibleY = config.playableBounds.minY - config.offscreenProjectilePadding

        state.projectiles.removeAll { projectile in
            projectile.position.x < minVisibleX ||
            projectile.position.x > maxVisibleX ||
            projectile.position.y < minVisibleY ||
            projectile.position.y > maxVisibleY
        }
    }

    private mutating func resolveCollisions() -> [GameEvent] {
        guard state.runState == .playing else { return [] }

        var events: [GameEvent] = []
        events.append(contentsOf: resolvePlayerProjectileHits())
        guard state.runState == .playing else { return events }
        events.append(contentsOf: resolveEnemyProjectileHits())
        guard state.runState == .playing else { return events }
        events.append(contentsOf: resolveEnemyBodyHits())
        guard state.runState == .playing else { return events }
        events.append(contentsOf: resolveGiftPickups())
        guard state.runState == .playing else { return events }
        events.append(contentsOf: resolveObstacleHits())
        return events
    }

    private mutating func resolvePlayerProjectileHits() -> [GameEvent] {
        var events: [GameEvent] = []
        var projectileIDsToRemove = Set<Int>()

        for projectile in state.projectiles where projectile.owner == .player {
            guard let enemyIndex = state.enemies.firstIndex(where: { enemy in
                enemy.isActive &&
                !enemy.isRemoved &&
                projectile.position.distanceSquared(to: enemy.position) <= pow(projectile.collisionRadius + enemy.collisionRadius, 2)
            }) else { continue }

            projectileIDsToRemove.insert(projectile.id)
            state.enemies[enemyIndex].hp -= projectile.damage
            if state.enemies[enemyIndex].hp <= 0 {
                state.enemies[enemyIndex].isRemoved = true
                state.score += config.enemyScore
                events.append(.enemyRemoved(score: state.score))
            }
        }

        if !projectileIDsToRemove.isEmpty {
            state.projectiles.removeAll { projectileIDsToRemove.contains($0.id) }
        }

        return events
    }

    private mutating func resolveEnemyProjectileHits() -> [GameEvent] {
        var events: [GameEvent] = []
        var projectileIDsToRemove = Set<Int>()

        for projectile in state.projectiles where projectile.owner == .enemy {
            let hitPlayer = projectile.position.distanceSquared(to: state.player.position) <= pow(projectile.collisionRadius + config.playerCollisionRadius, 2)
            guard hitPlayer else { continue }
            projectileIDsToRemove.insert(projectile.id)
            events.append(contentsOf: applyDamage(from: .enemyBullet))
            if state.runState != .playing { break }
        }

        if !projectileIDsToRemove.isEmpty {
            state.projectiles.removeAll { projectileIDsToRemove.contains($0.id) }
        }

        return events
    }

    private mutating func resolveEnemyBodyHits() -> [GameEvent] {
        var events: [GameEvent] = []

        for index in state.enemies.indices where state.enemies[index].isActive && !state.enemies[index].isRemoved {
            let hitPlayer = state.enemies[index].position.distanceSquared(to: state.player.position) <= pow(state.enemies[index].collisionRadius + config.playerCollisionRadius, 2)
            guard hitPlayer else { continue }
            state.enemies[index].isRemoved = true
            events.append(contentsOf: applyDamage(from: .enemyCollision))
            if state.runState != .playing { break }
        }

        return events
    }

    private mutating func resolveGiftPickups() -> [GameEvent] {
        var events: [GameEvent] = []

        for index in state.gifts.indices where state.gifts[index].isActive && !state.gifts[index].isCollected {
            let hitPlayer = state.gifts[index].position.distanceSquared(to: state.player.position) <= pow(state.gifts[index].collisionRadius + config.playerCollisionRadius, 2)
            guard hitPlayer else { continue }
            state.gifts[index].isCollected = true
            applyGiftEffect(state.gifts[index].kind)
            state.score += config.giftScore
            events.append(.giftCollected(state.gifts[index].kind))
        }

        return events
    }

    private mutating func resolveObstacleHits() -> [GameEvent] {
        var events: [GameEvent] = []

        for obstacle in state.obstacles where obstacle.isActive {
            let hitPlayer = obstacle.collisionBox.contains(
                circleCenter: state.player.position,
                circleRadius: config.playerCollisionRadius,
                boxCenter: obstacle.position
            )
            guard hitPlayer else { continue }
            guard obstacle.isDangerous(elapsedTime: state.elapsedTime) else { continue }

            switch obstacle.kind {
            case .staticObstacle:
                events.append(contentsOf: applyDamage(from: .staticObstacle))
            case .pulseGate:
                events.append(contentsOf: applyDamage(from: .pulseGate))
            }

            if state.runState != .playing { break }
        }

        return events
    }

    private mutating func applyGiftEffect(_ gift: GiftKind) {
        switch gift {
        case .rapid:
            state.player.activePower = ActivePower(kind: .rapid, remainingTime: config.giftDuration)
        case .spread:
            state.player.activePower = ActivePower(kind: .spread, remainingTime: config.giftDuration)
        case .shield:
            state.player.shieldCharges = Swift.max(1, state.player.shieldCharges)
        }
    }
}
