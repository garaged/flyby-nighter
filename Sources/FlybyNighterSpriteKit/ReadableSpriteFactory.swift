#if canImport(SpriteKit)
import SpriteKit
import FlybyNighterCore

@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
enum ReadableSpriteFactory {
    static func enemyNode(for enemy: EnemyState) -> SKNode {
        let node = SKNode()
        let radius = CGFloat(enemy.collisionRadius)

        let body: SKShapeNode
        switch enemy.kind {
        case .drifter:
            body = SKShapeNode(circleOfRadius: radius)
            body.fillColor = .magenta
            body.strokeColor = .white
        case .needler:
            body = SKShapeNode(path: needlerPath(radius: radius))
            body.fillColor = .orange
            body.strokeColor = .white
        case .sentry:
            body = SKShapeNode(rectOf: CGSize(width: radius * 2, height: radius * 2), cornerRadius: 4)
            body.fillColor = .purple
            body.strokeColor = .white
        }
        body.lineWidth = 1.5
        node.addChild(body)

        let ring = SKShapeNode(circleOfRadius: radius + 5)
        ring.fillColor = .clear
        ring.strokeColor = strokeColor(for: enemy.kind).withAlphaComponent(0.42)
        ring.lineWidth = enemy.fireInterval == nil ? 1 : 2
        node.addChild(ring)

        if let interval = enemy.fireInterval {
            let readiness = max(0, min(1, 1 - enemy.fireCooldownRemaining / max(interval, 0.001)))
            if readiness > 0.7 {
                let cue = SKShapeNode(circleOfRadius: radius + 10)
                cue.fillColor = .clear
                cue.strokeColor = SKColor.white.withAlphaComponent(0.35 + CGFloat(readiness - 0.7))
                cue.lineWidth = 1
                node.addChild(cue)
            }
        }

        return node
    }

    static func giftNode(for gift: GiftState) -> SKNode {
        let node = SKNode()
        let radius = CGFloat(gift.collisionRadius)
        let body = SKShapeNode(circleOfRadius: radius)

        switch gift.kind {
        case .rapid:
            body.fillColor = .green
        case .spread:
            body.fillColor = .blue
        case .shield:
            body.fillColor = .cyan
        }
        body.strokeColor = .white
        body.lineWidth = 1.5
        node.addChild(body)

        let label = SKLabelNode(fontNamed: "Menlo-Bold")
        label.fontSize = 11
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        label.fontColor = .black
        switch gift.kind {
        case .rapid:
            label.text = "R"
        case .spread:
            label.text = "S"
        case .shield:
            label.text = "H"
        }
        node.addChild(label)

        let ring = SKShapeNode(circleOfRadius: radius + 5)
        ring.fillColor = .clear
        ring.strokeColor = SKColor.white.withAlphaComponent(0.28)
        ring.lineWidth = 1
        node.addChild(ring)

        return node
    }

    static func obstacleNode(for obstacle: ObstacleState, dangerous: Bool) -> SKNode {
        let node = SKNode()
        let size = CGSize(
            width: CGFloat(obstacle.collisionBox.halfWidth * 2),
            height: CGFloat(obstacle.collisionBox.halfHeight * 2)
        )
        let body = SKShapeNode(rectOf: size, cornerRadius: obstacle.kind == .pulseGate ? 3 : 0)

        switch obstacle.kind {
        case .staticObstacle:
            body.fillColor = .darkGray
            body.strokeColor = .red
            body.lineWidth = 2
        case .pulseGate:
            body.fillColor = dangerous ? SKColor.red.withAlphaComponent(0.48) : SKColor.clear
            body.strokeColor = dangerous ? .red : .cyan
            body.lineWidth = dangerous ? 3 : 2

            let notch = SKShapeNode(rectOf: CGSize(width: size.width + 8, height: 12), cornerRadius: 3)
            notch.fillColor = dangerous ? SKColor.red.withAlphaComponent(0.35) : SKColor.cyan.withAlphaComponent(0.35)
            notch.strokeColor = .clear
            notch.position = CGPoint(x: 0, y: 0)
            node.addChild(notch)
        }

        node.addChild(body)
        return node
    }

    static func projectileNode(owner: ProjectileOwner) -> SKShapeNode {
        let radius: CGFloat = owner == .player ? 3 : 4
        let node = SKShapeNode(circleOfRadius: radius)
        node.fillColor = owner == .player ? .yellow : .red
        node.strokeColor = owner == .player ? .white : .orange
        node.lineWidth = owner == .player ? 0.5 : 1
        return node
    }

    private static func strokeColor(for kind: EnemyKind) -> SKColor {
        switch kind {
        case .drifter:
            return .magenta
        case .needler:
            return .orange
        case .sentry:
            return .purple
        }
    }

    private static func needlerPath(radius: CGFloat) -> CGPath {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: -radius, y: radius * 0.72))
        path.addLine(to: CGPoint(x: radius * 1.25, y: 0))
        path.addLine(to: CGPoint(x: -radius, y: -radius * 0.72))
        path.addLine(to: CGPoint(x: -radius * 0.45, y: 0))
        path.closeSubpath()
        return path
    }
}
#endif
