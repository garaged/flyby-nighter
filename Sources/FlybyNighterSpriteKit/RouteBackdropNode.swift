#if canImport(SpriteKit)
import SpriteKit

@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
final class RouteBackdropNode: SKNode {
    func render(routeProgress: Double, routeLength: Double, sceneSize: CGSize, visible: Bool) {
        removeAllChildren()
        isHidden = !visible
        guard visible else { return }

        let progress = routeLength > 0 ? min(max(routeProgress / routeLength, 0), 1) : 0
        let phase = CGFloat(routeProgress.truncatingRemainder(dividingBy: 120))
        let sector = min(6, Int(progress * 7.0))

        addSectorWash(sector: sector, sceneSize: sceneSize)
        addRails(sceneSize: sceneSize)
        addFlowLines(sceneSize: sceneSize, phase: phase)
        addStars(sceneSize: sceneSize, phase: phase)
        addExitCue(progress: progress, sceneSize: sceneSize)
    }

    private func addSectorWash(sector: Int, sceneSize: CGSize) {
        let tint: SKColor
        switch sector {
        case 0:
            tint = SKColor(red: 0.00, green: 0.08, blue: 0.12, alpha: 0.42)
        case 1:
            tint = SKColor(red: 0.04, green: 0.04, blue: 0.13, alpha: 0.42)
        case 2:
            tint = SKColor(red: 0.06, green: 0.02, blue: 0.12, alpha: 0.42)
        case 3:
            tint = SKColor(red: 0.02, green: 0.07, blue: 0.10, alpha: 0.42)
        case 4:
            tint = SKColor(red: 0.05, green: 0.08, blue: 0.03, alpha: 0.42)
        case 5:
            tint = SKColor(red: 0.08, green: 0.04, blue: 0.08, alpha: 0.42)
        default:
            tint = SKColor(red: 0.09, green: 0.07, blue: 0.02, alpha: 0.42)
        }

        let node = SKShapeNode(rect: CGRect(origin: .zero, size: sceneSize))
        node.fillColor = tint
        node.strokeColor = .clear
        node.zPosition = -30
        addChild(node)
    }

    private func addRails(sceneSize: CGSize) {
        addLine(from: CGPoint(x: 0, y: 52), to: CGPoint(x: sceneSize.width, y: 52), color: .cyan, alpha: 0.35, width: 2)
        addLine(from: CGPoint(x: 0, y: sceneSize.height - 52), to: CGPoint(x: sceneSize.width, y: sceneSize.height - 52), color: .cyan, alpha: 0.35, width: 2)
        addLine(from: CGPoint(x: 0, y: sceneSize.height / 2), to: CGPoint(x: sceneSize.width, y: sceneSize.height / 2), color: .cyan, alpha: 0.12, width: 1)
    }

    private func addFlowLines(sceneSize: CGSize, phase: CGFloat) {
        let spacing: CGFloat = 120
        for index in -1...8 {
            let x = CGFloat(index) * spacing - phase
            addLine(
                from: CGPoint(x: x, y: 52),
                to: CGPoint(x: x + 42, y: sceneSize.height - 52),
                color: .cyan,
                alpha: 0.12,
                width: 1
            )
        }
    }

    private func addStars(sceneSize: CGSize, phase: CGFloat) {
        let points: [(CGFloat, CGFloat, CGFloat)] = [
            (0.12, 0.18, 0.8), (0.24, 0.72, 1.2), (0.37, 0.34, 0.7),
            (0.49, 0.84, 1.0), (0.58, 0.22, 0.9), (0.68, 0.62, 1.4),
            (0.78, 0.44, 0.8), (0.88, 0.76, 1.1), (0.95, 0.28, 0.7)
        ]

        for (xRatio, yRatio, radius) in points {
            let wrappedX = (xRatio * sceneSize.width - phase * 1.7).truncatingRemainder(dividingBy: sceneSize.width)
            let x = wrappedX >= 0 ? wrappedX : wrappedX + sceneSize.width
            let y = yRatio * sceneSize.height
            let dot = SKShapeNode(circleOfRadius: radius)
            dot.fillColor = SKColor(red: 0.75, green: 0.95, blue: 1.0, alpha: 0.38)
            dot.strokeColor = .clear
            dot.position = CGPoint(x: x, y: y)
            dot.zPosition = -20
            addChild(dot)
        }
    }

    private func addExitCue(progress: Double, sceneSize: CGSize) {
        guard progress > 0.90 else { return }
        let alpha = CGFloat(min(0.65, 0.15 + (progress - 0.90) * 5.0))
        addLine(
            from: CGPoint(x: sceneSize.width - 56, y: 52),
            to: CGPoint(x: sceneSize.width - 56, y: sceneSize.height - 52),
            color: .white,
            alpha: alpha,
            width: 3
        )
    }

    private func addLine(from start: CGPoint, to end: CGPoint, color: SKColor, alpha: CGFloat, width: CGFloat) {
        let path = CGMutablePath()
        path.move(to: start)
        path.addLine(to: end)

        let line = SKShapeNode(path: path)
        line.strokeColor = color.withAlphaComponent(alpha)
        line.lineWidth = width
        line.zPosition = -10
        addChild(line)
    }
}
#endif
