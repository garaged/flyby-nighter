#if os(macOS)
import CoreGraphics
import Foundation
import FlybyNighterCore
import FlybyNighterSpriteKit

final class KeyboardPoller {
    private weak var scene: FlybyNighterScene?
    private var timer: Timer?
    private var previousStartPressed = false

    init(scene: FlybyNighterScene) {
        self.scene = scene
        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { [weak self] _ in
            self?.poll()
        }
    }

    deinit {
        timer?.invalidate()
    }

    private func poll() {
        guard let scene else { return }

        var x = 0.0
        var y = 0.0

        if pressed(0) || pressed(123) { x -= 1 }
        if pressed(2) || pressed(124) { x += 1 }
        if pressed(1) || pressed(125) { y -= 1 }
        if pressed(13) || pressed(126) { y += 1 }

        scene.setMovement(Vector2(x: x, y: y))
        scene.setFiring(pressed(49))

        let startPressed = pressed(36) || pressed(76)
        if startPressed && !previousStartPressed {
            scene.startOrRestartRun()
        }
        previousStartPressed = startPressed
    }

    private func pressed(_ keyCode: CGKeyCode) -> Bool {
        CGEventSource.keyState(.combinedSessionState, key: keyCode)
    }
}
#endif
