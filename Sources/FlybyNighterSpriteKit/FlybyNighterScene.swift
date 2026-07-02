#if canImport(SpriteKit)
import Foundation
import SpriteKit
import FlybyNighterCore

@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class FlybyNighterScene: SKScene {
    private var game = FlybyNighterGame()
    private var input = GameInput()
    private var lastUpdateTime: TimeInterval?

    private let worldLayer = SKNode()
    private let obstacleLayer = SKNode()
    private let giftLayer = SKNode()
    private let enemyLayer = SKNode()
    private let projectileLayer = SKNode()
    private let playerNode = SKShapeNode(path: FlybyNighterScene.makePlayerPath())
    private let hudLabel = SKLabelNode(fontNamed: "Menlo")
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

        _ = game.update(deltaTime: deltaTime, input: input)
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
            lastUpdateTime = nil
        case .playing:
            break
        }
        render()
    }

    #if os(iOS) || os(tvOS)
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        startOrRestartRun()
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

        hudLabel.fontSize = 14
        hudLabel.horizontalAlignmentMode = .left
        hudLabel.verticalAlignmentMode = .top
        hudLabel.fontColor = .white
        hudLabel.position = CGPoint(x: 16, y: size.height - 16)
        addChild(hudLabel)

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

    private func render() {
        guard playerNode.parent != nil else { return }

        hudLabel.text = "HP \(game.state.player.hp)   Score \(game.state.score)   Power \(activePowerText)"
        playerNode.position = CGPoint(x: game.state.player.position.x, y: game.state.player.position.y)
        worldLayer.isHidden = game.state.runState == .title

        renderObstacles()
        renderGifts()
        renderEnemies()
        renderProjectiles()
        renderOverlay()
    }

    private var activePowerText: String {
        if game.state.player.shieldCharges > 0 {
            return "Shield"
        }
        guard let activePower = game.state.player.activePower else {
            return "None"
        }
        switch activePower.kind {
        case .rapid:
            return "Rapid"
        case .spread:
            return "Spread"
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
                node = SKShapeNode(rectOf: CGSize(width: enemy.collisionRadius * 2, height: enemy.collisionRadius * 2))
                node.fillColor = .purple
            }
            node.strokeColor = .white
            node.lineWidth = 1
            node.position = CGPoint(x: enemy.position.x, y: enemy.position.y)
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
            node.position = CGPoint(x: gift.position.x, y: gift.position.y)
            giftLayer.addChild(node)
        }
    }

    private func renderObstacles() {
        obstacleLayer.removeAllChildren()
        for obstacle in game.state.obstacles where obstacle.isActive {
            let size = CGSize(width: obstacle.collisionBox.halfWidth * 2, height: obstacle.collisionBox.halfHeight * 2)
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
            node.position = CGPoint(x: obstacle.position.x, y: obstacle.position.y)
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
            node.position = CGPoint(x: projectile.position.x, y: projectile.position.y)
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
