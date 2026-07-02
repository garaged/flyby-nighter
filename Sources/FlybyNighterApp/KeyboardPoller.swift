#if os(macOS)
import AppKit
import CoreGraphics
import Foundation
import FlybyNighterCore
import FlybyNighterSpriteKit

final class KeyboardPoller {
    private weak var scene: FlybyNighterScene?
    private var timer: Timer?
    private var keyMonitor: Any?
    private var pressedCharacters = Set<String>()
    private var pressedKeyCodes = Set<UInt16>()
    private var previousStartPressed = false

    init(scene: FlybyNighterScene) {
        self.scene = scene

        keyMonitor = NSEvent.addLocalMonitorForEvents(matching: [.keyDown, .keyUp]) { [weak self] event in
            self?.handle(event)
            return event
        }

        let timer = Timer(timeInterval: 1.0 / 60.0, repeats: true) { [weak self] _ in
            self?.poll()
        }
        RunLoop.main.add(timer, forMode: .common)
        self.timer = timer
    }

    deinit {
        timer?.invalidate()
        if let keyMonitor {
            NSEvent.removeMonitor(keyMonitor)
        }
    }

    private func handle(_ event: NSEvent) {
        guard event.type == .keyDown || event.type == .keyUp else { return }

        let isDown = event.type == .keyDown
        let character = event.charactersIgnoringModifiers?.lowercased()

        if isDown {
            pressedKeyCodes.insert(event.keyCode)
            if let character, !character.isEmpty {
                pressedCharacters.insert(character)
            }
        } else {
            pressedKeyCodes.remove(event.keyCode)
            if let character, !character.isEmpty {
                pressedCharacters.remove(character)
            }
        }

        if isSpace(event, character: character) {
            scene?.setFiring(isDown)
        }

        if isStartKey(event, character: character), isDown, !event.isARepeat {
            scene?.startOrRestartRun()
        }

        applyMovement()
    }

    private func poll() {
        guard let scene else { return }

        applyMovement()

        let firing = isPressed(character: " ", keyCode: 49)
        scene.setFiring(firing)

        let startPressed =
            isPressed(character: "\r", keyCode: 36) ||
            pressedKeyCodes.contains(76) ||
            pressed(36) ||
            pressed(76)

        if startPressed && !previousStartPressed {
            scene.startOrRestartRun()
        }
        previousStartPressed = startPressed
    }

    private func applyMovement() {
        guard let scene else { return }

        var x = 0.0
        var y = 0.0

        if isPressed(character: "a", keyCode: 0) || pressed(123) { x -= 1 }
        if isPressed(character: "d", keyCode: 2) || pressed(124) { x += 1 }
        if isPressed(character: "s", keyCode: 1) || pressed(125) { y -= 1 }
        if isPressed(character: "w", keyCode: 13) || pressed(126) { y += 1 }

        scene.setMovement(Vector2(x: x, y: y))
    }

    private func isPressed(character: String, keyCode: UInt16) -> Bool {
        pressedCharacters.contains(character) ||
        pressedKeyCodes.contains(keyCode) ||
        pressed(CGKeyCode(keyCode))
    }

    private func isSpace(_ event: NSEvent, character: String?) -> Bool {
        event.keyCode == 49 || character == " "
    }

    private func isStartKey(_ event: NSEvent, character: String?) -> Bool {
        event.keyCode == 36 || event.keyCode == 76 || character == "\r" || character == "\n"
    }

    private func pressed(_ keyCode: CGKeyCode) -> Bool {
        CGEventSource.keyState(.combinedSessionState, key: keyCode) ||
        CGEventSource.keyState(.hidSystemState, key: keyCode)
    }
}
#endif
