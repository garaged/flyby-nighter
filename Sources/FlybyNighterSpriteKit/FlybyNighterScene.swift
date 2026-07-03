#if canImport(SpriteKit)
import Foundation
import SpriteKit
import FlybyNighterCore

@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class FlybyNighterScene: SKScene {
    private var routeSelection = RouteSelectionState()
    private var game = FlybyNighterGame(config: RouteCatalog.definition(for: .neonRift).config)
    private var scoreLedger = ScoreLedger()
    private var input = GameInput()
    private var lastUpdateTime: TimeInterval?
    private var playerFlashRemaining: TimeInterval = 0
    private var hudPulseRemaining: TimeInterval = 0
    private var didSetNewBest = false

    private let highScoreStore = UserDefaultsHighScoreStore()
    private let audioPlayer = PlaceholderAudioPlayer()
    private let routeBackdropNode = RouteBackdropNode()
    private let worldLayer = SKNode()
    private let feedbackLayer = SKNode()
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
    private let routeLabel = SKLabelNode(fontNamed: "Menlo-Bold")
    private let resultLabel = SKLabelNode(fontNamed: "Menlo")
    private let instructionLabel = SKLabelNode(fontNamed: "Menlo")

    public var selectedRouteID: RouteID {
        routeSelection.selectedRouteID
    }

    public var selectedRouteDisplayName: String {
        routeSelection.selectedRoute.displayName
    }

    public var selectedRouteBestScore: Int {
        highScoreStore.bestScore(for: selectedRouteID)
    }

    public var isRouteSelectionAvailable: Bool {
        game.state.runState != .playing
    }

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
        layoutScene()
        render()
    }

    public override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        layoutScene()
        render()
    }

    public override func update(_ currentTime: TimeInterval) {
        let deltaTime = lastUpdateTime.map { currentTime - $0 } ?? 0
        lastUpdateTime = currentTime

        let previousHP = game.state.player.hp
        let previousScore = game.state.score
        let events = game.update(deltaTime: deltaTime, input: input)
        handleGameEvents(events)

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

    public func setAudioEnabled(_ enabled: Bool) {
        audioPlayer.isEnabled = enabled
    }

    public func setLifecyclePaused(_ paused: Bool) {
        input = GameInput()
        lastUpdateTime = nil
        isPaused = paused
    }

    @discardableResult
    public func selectNextRoute() -> Bool {
        guard isRouteSelectionAvailable else { return false }
        routeSelection.selectNext()
        resetForSelectedRoute()
        return true
    }

    @discardableResult
    public func selectPreviousRoute() -> Bool {
        guard isRouteSelectionAvailable else { return false }
        routeSelection.selectPrevious()
        resetForSelectedRoute()
        return true
    }

    @discardableResult
    public func handleRouteSelectionPointer(normalizedX: CGFloat) -> Bool {
        guard isRouteSelectionAvailable else { return false }

        if normalizedX < 0.34 {
            return selectPreviousRoute()
        }
        if normalizedX > 0.66 {
            return selectNextRoute()
        }
        return false
    }

    public func startOrRestartRun() {
        switch game.state.runState {
        case .title, .completed, .failed:
            scoreLedger.reset()
            didSetNewBest = false
            let events = game.restartRun()
            handleGameEvents(events)
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
        guard let touch = touches.first else { return }

        if game.state.runState != .playing {
            let location = touch.location(in: self)
            let normalizedX = size.width > 0 ? location.x / size.width : 0.5
            if handleRouteSelectionPointer(normalizedX: normalizedX) {
                return
            }
            startOrRestartRun()
        }

        guard game.state.runState == .playing else { return }
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
        let normalizedX = size.width > 0 ? event.location(in: self).x / size.width : 0.5
        if !handleRouteSelectionPointer(normalizedX: normalizedX) {
            startOrRestartRun()
        }
    }
    #endif

    private func resetForSelectedRoute() {
        game = FlybyNighterGame(config: routeSelection.selectedRoute.config)
        scoreLedger.reset()
        didSetNewBest = false
        input = GameInput()
        lastUpdateTime = nil
        playerFlashRemaining = 0
        hudPulseRemaining = 0
        feedbackLayer.removeAllChildren()
        worldLayer.removeAction(forKey: "cameraImpulse")
        worldLayer.position = .zero
        render()
    }

    private func configureSceneGraphIfNeeded() {
        guard children.isEmpty else { return }

        addChild(routeBackdropNode)
        addChild(worldLayer)
        worldLayer.addChild(obstacleLayer)
        worldLayer.addChild(giftLayer)
        worldLayer.addChild(enemyLayer)
        worldLayer.addChild(projectileLayer)

        playerNode.fillColor = .cyan
        playerNode.strokeColor = .white
        playerNode.lineWidth = 1.5
        worldLayer.addChild(playerNode)

        addChild(feedbackLayer)

        configureHUDLabel(hudLabel, fontSize: 14)
        configureHUDLabel(powerLabel, fontSize: 13)
        configureHUDLabel(progressLabel, fontSize: 12)
        configureHUDLabel(segmentLabel, fontSize: 13)
        segmentLabel.fontColor = .cyan

        progressTrackNode.fillColor = .darkGray
        progressTrackNode.strokeColor = .white
        progressTrackNode.lineWidth = 1
        addChild(progressTrackNode)

        progressFillNode.fillColor = .cyan
        progressFillNode.strokeColor = .clear
        addChild(progressFillNode)

        titleLabel.fontSize = 28
        titleLabel.horizontalAlignmentMode = .center
        titleLabel.verticalAlignmentMode = .center
        titleLabel.fontColor = .cyan
        addChild(titleLabel)

        routeLabel.fontSize = 19
        routeLabel.horizontalAlignmentMode = .center
        routeLabel.verticalAlignmentMode = .center
        routeLabel.fontColor = .yellow
        addChild(routeLabel)

        resultLabel.fontSize = 13
        resultLabel.horizontalAlignmentMode = .center
        resultLabel.verticalAlignmentMode = .center
        resultLabel.fontColor = .white
        resultLabel.numberOfLines = 3
        addChild(resultLabel)

        instructionLabel.fontSize = 11
        instructionLabel.horizontalAlignmentMode = .center
        instructionLabel.verticalAlignmentMode = .center
        instructionLabel.fontColor = .lightGray
        addChild(instructionLabel)
    }

    private func configureHUDLabel(_ label: SKLabelNode, fontSize: CGFloat) {
        label.fontSize = fontSize
        label.horizontalAlignmentMode = .left
        label.verticalAlignmentMode = .top
        label.fontColor = .white
        addChild(label)
    }

    private func layoutScene() {
        guard !children.isEmpty else { return }

        let left: CGFloat = 16
        let top = size.height - 16
        let progressX = min(max(246, size.width * 0.42), max(16, size.width - 230))

        hudLabel.position = CGPoint(x: left, y: top)
        powerLabel.position = CGPoint(x: left, y: top - 20)
        segmentLabel.position = CGPoint(x: progressX, y: top)
        progressLabel.position = CGPoint(x: progressX, y: top - 20)
        progressTrackNode.position = CGPoint(x: left, y: top - 46)
        progressFillNode.position = progressTrackNode.position

        let centerX = size.width / 2
        let centerY = size.height / 2
        titleLabel.position = CGPoint(x: centerX, y: centerY + 62)
        routeLabel.position = CGPoint(x: centerX, y: centerY + 20)
        resultLabel.position = CGPoint(x: centerX, y: centerY - 24)
        resultLabel.preferredMaxLayoutWidth = max(220, min(size.width - 40, 600))
        instructionLabel.position = CGPoint(x: centerX, y: centerY - 88)
    }

    private func handleGameEvents(_ events: [GameEvent]) {
        for event in events {
            scoreLedger.record(event)

            switch event {
            case .routeCompleted(let score), .runFailed(let score):
                didSetNewBest = highScoreStore.record(score: score, for: selectedRouteID)
            default:
                break
            }

            guard let feedback = GameEventFeedbackMapper.feedback(for: event) else { continue }

            if let audioCue = feedback.audioCue {
                audioPlayer.play(audioCue)
            }
            if let visualCue = feedback.visualCue {
                applyVisualFeedback(visualCue)
            }
        }
    }

    private func applyVisualFeedback(_ cue: VisualFeedbackCue) {
        switch cue {
        case .playerShot:
            showPulse(
                at: CGPoint(x: playerNode.position.x + 22, y: playerNode.position.y),
                color: .yellow,
                radius: 5,
                duration: 0.08
            )
        case .enemyRemoved:
            flashOverlay(color: .orange, alpha: 0.07, duration: 0.12)
            runCameraImpulse(magnitude: 2)
        case .playerDamaged:
            flashOverlay(color: .red, alpha: 0.22, duration: 0.20)
            runCameraImpulse(magnitude: 7)
        case .giftCollected:
            flashOverlay(color: .green, alpha: 0.12, duration: 0.16)
            showPulse(at: playerNode.position, color: .green, radius: 18, duration: 0.20)
        case .shieldUsed:
            flashOverlay(color: .cyan, alpha: 0.15, duration: 0.18)
            showPulse(at: playerNode.position, color: .cyan, radius: 22, duration: 0.22)
        case .powerExpired:
            flashOverlay(color: .gray, alpha: 0.06, duration: 0.12)
        case .runCompleted:
            flashOverlay(color: .green, alpha: 0.18, duration: 0.36)
            runCameraImpulse(magnitude: 3)
        case .runFailed:
            flashOverlay(color: .red, alpha: 0.22, duration: 0.36)
            runCameraImpulse(magnitude: 5)
        }
    }

    private func flashOverlay(color: SKColor, alpha: CGFloat, duration: TimeInterval) {
        trimFeedbackNodes()
        let node = SKShapeNode(rectOf: size)
        node.position = CGPoint(x: size.width / 2, y: size.height / 2)
        node.fillColor = color
        node.strokeColor = .clear
        node.alpha = alpha
        feedbackLayer.addChild(node)
        node.run(.sequence([.fadeOut(withDuration: duration), .removeFromParent()]))
    }

    private func showPulse(
        at position: CGPoint,
        color: SKColor,
        radius: CGFloat,
        duration: TimeInterval
    ) {
        trimFeedbackNodes()
        let node = SKShapeNode(circleOfRadius: radius)
        node.position = position
        node.fillColor = .clear
        node.strokeColor = color
        node.lineWidth = 2
        feedbackLayer.addChild(node)
        node.run(
            .sequence([
                .group([
                    .scale(to: 1.8, duration: duration),
                    .fadeOut(withDuration: duration)
                ]),
                .removeFromParent()
            ])
        )
    }

    private func runCameraImpulse(magnitude: CGFloat) {
        worldLayer.removeAction(forKey: "cameraImpulse")
        worldLayer.position = .zero
        let half = magnitude * 0.5
        worldLayer.run(
            .sequence([
                .moveBy(x: magnitude, y: half, duration: 0.025),
                .moveBy(x: -magnitude * 1.7, y: -magnitude, duration: 0.035),
                .moveBy(x: magnitude * 0.7, y: half, duration: 0.035),
                .run { [weak self] in self?.worldLayer.position = .zero }
            ]),
            withKey: "cameraImpulse"
        )
    }

    private func trimFeedbackNodes() {
        while feedbackLayer.children.count >= 12 {
            feedbackLayer.children.first?.removeFromParent()
        }
    }

    private func render() {
        guard playerNode.parent != nil else { return }

        routeBackdropNode.render(
            routeProgress: game.state.routeProgress,
            routeLength: game.config.routeLength,
            sceneSize: size,
            visible: game.state.runState != .title
        )
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
        hudLabel.text = "HP \(game.state.player.hp)/\(game.config.maxHP)   Score \(game.state.score)   Best \(selectedRouteBestScore)"
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
        progressLabel.text = "\(selectedRouteDisplayName) \(Int(progress * 100))%"
        progressLabel.isHidden = game.state.runState == .title
        segmentLabel.text = routeSelection.segmentName(at: progress)
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

    private var scoreBreakdown: ScoreBreakdown {
        scoreLedger.breakdown(
            completed: game.state.runState == .completed,
            remainingHP: game.state.player.hp,
            config: game.config
        )
    }

    private var scoreBreakdownText: String {
        let breakdown = scoreBreakdown
        return "Enemies \(breakdown.enemyPoints)  •  Gifts \(breakdown.giftPoints)  •  Clear \(breakdown.completionBonus)  •  HP \(breakdown.remainingHPBonus)"
    }

    private var bestMarker: String {
        didSetNewBest ? "  •  NEW BEST" : ""
    }

    private var glassShearObstacleIDs: Set<Int> {
        Set(routeSelection.selectedRoute.hazardFamilies.flatMap(\.obstacleIDs))
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
        let shearIDs = glassShearObstacleIDs

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
                node.strokeColor = shearIDs.contains(obstacle.id) ? .yellow : .cyan
            }
            node.lineWidth = shearIDs.contains(obstacle.id) ? 3 : 2
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
            setOverlayHidden(false)
            titleLabel.text = "Flyby Nighter"
            routeLabel.text = "‹  \(selectedRouteDisplayName)  ›"
            resultLabel.text = "\(routeSelection.selectedRoute.summary)\nBest \(selectedRouteBestScore)"
            instructionLabel.text = "Side tap or ←/→: select   •   Center tap or Return: start"
        case .playing:
            setOverlayHidden(true)
        case .completed:
            setOverlayHidden(false)
            titleLabel.text = "Route Complete"
            routeLabel.text = "‹  \(selectedRouteDisplayName)  ›"
            resultLabel.text = "Score \(game.state.score)  •  Best \(selectedRouteBestScore)\(bestMarker)\n\(scoreBreakdownText)"
            instructionLabel.text = "Side tap or ←/→: change route   •   Center tap or Return: replay"
        case .failed:
            setOverlayHidden(false)
            titleLabel.text = "Run Failed"
            routeLabel.text = "‹  \(selectedRouteDisplayName)  ›"
            resultLabel.text = "Score \(game.state.score)  •  Best \(selectedRouteBestScore)\(bestMarker)\n\(scoreBreakdownText)"
            instructionLabel.text = "Side tap or ←/→: change route   •   Center tap or Return: retry"
        }
    }

    private func setOverlayHidden(_ hidden: Bool) {
        titleLabel.isHidden = hidden
        routeLabel.isHidden = hidden
        resultLabel.isHidden = hidden
        instructionLabel.isHidden = hidden
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
