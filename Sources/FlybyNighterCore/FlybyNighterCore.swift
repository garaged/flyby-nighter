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

    public init(id: Int, owner: ProjectileOwner, position: Vector2, velocity: Vector2, damage: Int = 1) {
        self.id = id
        self.owner = owner
        self.position = position
        self.velocity = velocity
        self.damage = damage
    }
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
    public var offscreenProjectilePadding: Double
    public var enemyScore: Int
    public var giftScore: Int
    public var completionScore: Int
    public var remainingHPBonus: Int

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
        offscreenProjectilePadding: Double = 420,
        enemyScore: Int = 100,
        giftScore: Int = 50,
        completionScore: Int = 1_000,
        remainingHPBonus: Int = 100
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
        self.offscreenProjectilePadding = offscreenProjectilePadding
        self.enemyScore = enemyScore
        self.giftScore = giftScore
        self.completionScore = completionScore
        self.remainingHPBonus = remainingHPBonus
    }

    public static let m0 = GameConfig()
}

public struct GameState: Equatable, Sendable {
    public var runState: RunState
    public var routeProgress: Double
    public var score: Int
    public var player: PlayerState
    public var projectiles: [ProjectileState]
    public var fireCooldownRemaining: TimeInterval
    public var nextProjectileID: Int

    public init(
        runState: RunState,
        routeProgress: Double,
        score: Int,
        player: PlayerState,
        projectiles: [ProjectileState] = [],
        fireCooldownRemaining: TimeInterval = 0,
        nextProjectileID: Int = 1
    ) {
        self.runState = runState
        self.routeProgress = routeProgress
        self.score = score
        self.player = player
        self.projectiles = projectiles
        self.fireCooldownRemaining = fireCooldownRemaining
        self.nextProjectileID = nextProjectileID
    }

    public static func title(config: GameConfig = .m0) -> GameState {
        GameState(
            runState: .title,
            routeProgress: 0,
            score: 0,
            player: PlayerState(position: config.initialPlayerPosition, hp: config.maxHP)
        )
    }

    public static func freshRun(config: GameConfig = .m0) -> GameState {
        GameState(
            runState: .playing,
            routeProgress: 0,
            score: 0,
            player: PlayerState(position: config.initialPlayerPosition, hp: config.maxHP)
        )
    }
}

public enum GameEvent: Equatable, Sendable {
    case runStarted
    case routeCompleted(score: Int)
    case runFailed(score: Int)
    case playerFired(projectileCount: Int)
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

        events.append(contentsOf: advanceTimers(deltaTime: deltaTime))
        applyMovement(deltaTime: deltaTime, movement: input.movement)
        state.routeProgress = Swift.min(config.routeLength, state.routeProgress + config.routeSpeed * deltaTime)

        if input.isFiring {
            events.append(contentsOf: fireIfReady())
        }

        advanceProjectiles(deltaTime: deltaTime)

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

        switch gift {
        case .rapid:
            state.player.activePower = ActivePower(kind: .rapid, remainingTime: config.giftDuration)
        case .spread:
            state.player.activePower = ActivePower(kind: .spread, remainingTime: config.giftDuration)
        case .shield:
            state.player.shieldCharges = Swift.max(1, state.player.shieldCharges)
        }

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
}
