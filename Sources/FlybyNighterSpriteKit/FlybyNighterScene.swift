#if canImport(SpriteKit)
import Foundation
import SpriteKit
import FlybyNighterCore

@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class FlybyNighterScene: SKScene {
    private var game = FlybyNighterGame(config: .m1)
    private var input = GameInput()
    private var lastUpdateTime: TimeInterval?
    private var playerFlashRemaining: TimeInterval = 0
    private var hudPulseRemaining: TimeInterval = 0

    private let worldLayer = SKNode()
    private let obstacleLayer = SKNode()
    private let giftLayer = SKNode()
    private let enemyLayer = SKNode()
    private let projectileLayer = SKNode()
    private let playerNode = SKShapeNode(path: FlybyNighterScene.makePlayerPath())
    private let hudLabel = SKLabelNode(fontNamed: "Menlo")
    private let powerLabel = SKLabelNode(fontNamed: "Menlo")
    private let progressLabel = SKLabelNode(fontNamed: "Menlo")
    private let segmentLabel = SKLabelNode(fontNamed: "Menlo-Bold")
    private let progressTrackNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 220, height: 8), cornerRadius: 4)
    private let progressFillNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 2, height: 8), cornerRadius: 4)
    private let titleLabel = SKLabelNode(fontNamed: "Menlo-Bold")
    private let resultLabel = SKLabelNode(fontNamed: "Menlo-Bold")

    public override init(size: CGSize) {
        super.init(size: size)
        scaleMode = .resizeFill
        backgroundColor = .black
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        scaleMode = .resizeFill
        backgroundColor = .black
    }

    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        configureSceneGraphIfNeeded()
        render()
    }

    public override func update(_ currentTime: TimeInterval) {
        let deltaTime = lastUpdateTime.map { currentTime - $0 } ?? 0
        lastUpdateTime = currentTime

        let previousHP = game.state.player.hp
        let previousScore = game.state.score
        _ = game.update(deltaTime: deltaTime, input: input)

        if game.state.player.hp < previousHP {
            playerFlashRemaining = 0.22
        }
        if game.state.score > previousScore {
            hudPulseRemaining = 0.18
        }

        playerFlashRemaining = max(0, playerFlashRemaining - deltaTime)
        hudPulseRemaining = max(0, hudPulseRemaining - deltaTime)

        render()
    }

    public func setMovement(_ movement: Vector2) {
        input.movement = movement
    }

    public func setFiring(_ isFiring: Bool) {
        input.isFiring = isFiring
    }

    public func startOrRestartRun() {
        switch game.state.runState {
        case .title, .completed, .failed:
            _ = game.restartRun()
            playerFlashRemaining = 0
            hudPulseRemaining = 0
            lastUpdateTime = nil
        case .playing:
            break
        }
        render()
    }

    #if os(iOS) || os(tvOS)
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if game.state.runState != .playing {
            startOrRestartRun()
        }

        guard game.state.runState == .playing, let touch = touches.first else { return }
        setFiring(true)
        updateTouchMovement(touch)
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard game.state.runState == .playing, let touch = touches.first else { return }
        updateTouchMovement(touch)
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setMovement(Vector2())
        setFiring(false)
    }

    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        setMovement(Vector2())
        setFiring(false)
    }

    private func updateTouchMovement(_ touch: UITouch) {
        let location = touch.location(in: self)
        let playerPosition = game.state.player.position
        let dx = Double(location.x) - playerPosition.x
        let dy = Double(location.y) - playerPosition.y
        let deadzone = 18.0
        let scale = 120.0

        let x = abs(dx) < deadzone ? 0 : Swift.min(Swift.max(dx / scale, -1), 1)
        let y = abs(dy) < deadzone ? 0 : Swift.min(Swift.max(dy / scale, -1), 1)

        setMovement(Vector2(x: x, y: y))
    }
    #endif

    #if os(macOS)
    public override func mouseUp(with event: NSEvent) {
        startOrRestartRun()
    }
    #endif

    private func configureSceneGraphIfNeeded() {
        guard children.isEmpty else { return }

        addChild(worldLayer)
        worldLayer.addChild(obstacleLayer)
        worldLayer.addChild(giftLayer)
        worldLayer.addChild(enemyLayer)
        worldLayer.addChild(projectileLayer)

        playerNode.fillColor = .cyan
        playerNode.strokeColor = .white
        playerNode.lineWidth = 1.5
        worldLayer.addChild(playerNode)

        configureHUDLabel(hudLabel, fontSize: 14, position: CGPoint(x: 16, y: size.height - 16))
        configureHUDLabel(powerLabel, fontSize: 13, position: CGPoint(x: 16, y: size.height - 36))
        configureHUDLabel(progressLabel, fontSize: 12, position: CGPoint(x: 246, y: size.height - 36))
        configureHUDLabel(segmentLabel, fontSize: 13, position: CGPoint(x: 246, y: size.height - 16))
        segmentLabel.fontColor = .cyan

        progressTrackNode.fillColor = .darkGray
        progressTrackNode.strokeColor = .white
        progressTrackNode.lineWidth = 1
        progressTrackNode.position = CGPoint(x: 16, y: size.height - 62)
        addChild(progressTrackNode)

        progressFillNode.fillColor = .cyan
        progressFillNode.strokeColor = .clear
        progressFillNode.position = progressTrackNode.position
        addChild(progressFillNode)

        titleLabel.fontSize = 28
        titleLabel.horizontalAlignmentMode = .center
        titleLabel.verticalAlignmentMode = .center
        titleLabel.fontColor = .cyan
        titleLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(titleLabel)

        resultLabel.fontSize = 22
        resultLabel.horizontalAlignmentMode = .center
        resultLabel.verticalAlignmentMode = .center
        resultLabel.fontColor = .white
        resultLabel.position = CGPoint(x: size.width / 2, y: size.height / 2 - 48)
        addChild(resultLabel)
    }

    private func configureHUDLabel(_ label: SKLabelNode, fontSize: CGFloat, position: CGPoint) {
        label.fontSize = fontSize
        label.horizontalAlignmentMode = .left
        label.verticalAlignmentMode = .top
        label.fontColor = .white
        label.position = position
        addChild(label)
    }

    private func render() {
        guard playerNode.parent != nil else { return }

        renderHUD()
        renderPlayer()
        worldLayer.isHidden = game.state.runState == .title

        renderObstacles()
        renderGifts()
        renderEnemies()
        renderProjectiles()
        renderOverlay()
    }

    private func renderHUD() {
        hudLabel.text = "HP \(game.state.player.hp)/\(game.config.maxHP)   Score \(game.state.score)"
        hudLabel.setScale(hudPulseRemaining > 0 ? 1.08 : 1.0)
        powerLabel.text = powerDisplayText

        let progress = routeProgressFraction
        let progressWidth = max(2, 220 * CGFloat(progress))
        progressFillNode.path = CGPath(
            roundedRect: CGRect(x: 0, y: 0, width: progressWidth, height: 8),
            cornerWidth: 4,
            cornerHeight: 4,
            transform: nil
        )
        progressFillNode.isHidden = game.state.runState == .title
        progressTrackNode.isHidden = game.state.runState == .title
        progressLabel.text = "Route \(Int(progress * 100))%"
        progressLabel.isHidden = game.state.runState == .title
        segmentLabel.text = routeSegmentName
        segmentLabel.isHidden = game.state.runState == .title
    }

    private func renderPlayer() {
        playerNode.position = Self.cgPoint(game.state.player.position)
        playerNode.fillColor = playerFlashRemaining > 0 ? .white : .cyan
        playerNode.setScale(playerFlashRemaining > 0 ? 1.15 : 1.0)
    }

    private var powerDisplayText: String {
        var parts: [String] = []
        if game.state.player.shieldCharges > 0 {
            parts.append("Shield")
        }
        if let activePower = game.state.player.activePower {
            let seconds = max(0, activePower.remainingTime)
            switch activePower.kind {
            case .rapid:
                parts.append(String(format: "Rapid %.1fs", seconds))
            case .spread:
                parts.append(String(format: "Spread %.1fs", seconds))
            }
        }
        if parts.isEmpty {
            return "Power: None"
        }
        return "Power: " + parts.joined(separator: " + ")
    }

    private var routeProgressFraction: Double {
        guard game.config.routeLength > 0 else { return 0 }
        return min(max(game.state.routeProgress / game.config.routeLength, 0), 1)
    }

    private var routeSegmentName: String {
        switch routeProgressFraction {
        case 0..<0.15:
            return "Sector 01 Entry"
        case 0.15..<0.30:
            return "Sector 02 Narrow"
        case 0.30..<0.45:
            return "Sector 03 Gates"
        case 0.45..<0.62:
            return "Sector 04 Midway"
        case 0.62..<0.75:
            return "Sector 05 Cache"
        case 0.75..<0.90:
            return "Sector 06 Spine"
        default:
            return "Sector 07 Exit"
        }
    }

    private func renderEnemies() {
        enemyLayer.removeAllChildren()
        for enemy in game.state.enemies where enemy.isActive && !enemy.isRemoved {
            let node: SKShapeNode
            switch enemy.kind {
            case .drifter:
                node = SKShapeNode(circleOfRadius: CGFloat(enemy.collisionRadius))
                node.fillColor = .magenta
            case .needler:
                node = SKShapeNode(path: Self.makeNeedlerPath(radius: enemy.collisionRadius))
                node.fillColor = .orange
            case .sentry:
                let diameter = CGFloat(enemy.collisionRadius * 2)
                node = SKShapeNode(rectOf: CGSize(width: diameter, height: diameter))
                node.fillColor = .purple
            }
            node.strokeColor = .white
            node.lineWidth = 1
            node.position = Self.cgPoint(enemy.position)
            enemyLayer.addChild(node)
        }
    }

    private func renderGifts() {
        giftLayer.removeAllChildren()
        for gift in game.state.gifts where gift.isActive && !gift.isCollected {
            let node = SKShapeNode(circleOfRadius: CGFloat(gift.collisionRadius))
            switch gift.kind {
            case .rapid:
                node.fillColor = .green
            case .spread:
                node.fillColor = .blue
            case .shield:
                node.fillColor = .cyan
            }
            node.strokeColor = .white
            node.lineWidth = 1.5
            node.position = Self.cgPoint(gift.position)
            giftLayer.addChild(node)
        }
    }

    private func renderObstacles() {
        obstacleLayer.removeAllChildren()
        for obstacle in game.state.obstacles where obstacle.isActive {
            let size = CGSize(
                width: CGFloat(obstacle.collisionBox.halfWidth * 2),
                height: CGFloat(obstacle.collisionBox.halfHeight * 2)
            )
            let node = SKShapeNode(rectOf: size)
            switch obstacle.kind {
            case .staticObstacle:
                node.fillColor = .darkGray
                node.strokeColor = .red
            case .pulseGate:
                node.fillColor = obstacle.isDangerous(elapsedTime: game.state.elapsedTime) ? .red : .clear
                node.strokeColor = .cyan
            }
            node.lineWidth = 2
            node.position = Self.cgPoint(obstacle.position)
            obstacleLayer.addChild(node)
        }
    }

    private func renderProjectiles() {
        projectileLayer.removeAllChildren()
        for projectile in game.state.projectiles {
            let radius: CGFloat = projectile.owner == .player ? 3 : 4
            let node = SKShapeNode(circleOfRadius: radius)
            node.fillColor = projectile.owner == .player ? .yellow : .red
            node.strokeColor = .clear
            node.position = Self.cgPoint(projectile.position)
            projectileLayer.addChild(node)
        }
    }

    private func renderOverlay() {
        switch game.state.runState {
        case .title:
            titleLabel.isHidden = false
            resultLabel.isHidden = false
            titleLabel.text = "Flyby Nighter"
            resultLabel.text = "Tap/click to start"
        case .playing:
            titleLabel.isHidden = true
            resultLabel.isHidden = true
        case .completed:
            titleLabel.isHidden = false
            resultLabel.isHidden = false
            titleLabel.text = "Route Complete"
            resultLabel.text = "Score \(game.state.score) — Tap/click to restart"
        case .failed:
            titleLabel.isHidden = false
            resultLabel.isHidden = false
            titleLabel.text = "Run Failed"
            resultLabel.text = "Score \(game.state.score) — Tap/click to restart"
        }
    }

    private static func cgPoint(_ vector: Vector2) -> CGPoint {
        CGPoint(x: CGFloat(vector.x), y: CGFloat(vector.y))
    }

    private static func makePlayerPath() -> CGPath {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 18, y: 0))
        path.addLine(to: CGPoint(x: -14, y: 12))
        path.addLine(to: CGPoint(x: -8, y: 0))
        path.addLine(to: CGPoint(x: -14, y: -12))
        path.closeSubpath()
        return path
    }

    private static func makeNeedlerPath(radius: Double) -> CGPath {
        let r = CGFloat(radius)
        let path = CGMutablePath()
        path.move(to: CGPoint(x: -r, y: r * 0.7))
        path.addLine(to: CGPoint(x: r, y: 0))
        path.addLine(to: CGPoint(x: -r, y: -r * 0.7))
        path.closeSubpath()
        return path
    }
}
#else
public enum FlybyNighterSpriteKitUnavailable {}
#endif
