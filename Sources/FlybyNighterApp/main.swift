#if os(macOS)
import AppKit
import SpriteKit
import SwiftUI
import FlybyNighterCore
import FlybyNighterSpriteKit

@main
struct FlybyNighterApp: App {
    var body: some Scene {
        WindowGroup("Flyby Nighter") {
            FlybyNighterSceneHost()
                .frame(minWidth: 640, minHeight: 600)
        }
    }
}

struct FlybyNighterSceneHost: NSViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeNSView(context: Context) -> MacKeyboardGameView {
        let sceneSize = CGSize(width: 640, height: 600)
        let scene = FlybyNighterScene(size: sceneSize)
        let view = MacKeyboardGameView(frame: CGRect(origin: .zero, size: sceneSize))
        view.ignoresSiblingOrder = true
        view.preferredFramesPerSecond = 60
        view.gameScene = scene
        view.presentScene(scene)
        context.coordinator.attach(scene: scene, view: view)
        return view
    }

    func updateNSView(_ nsView: MacKeyboardGameView, context: Context) {
        context.coordinator.updateView(nsView)
    }

    final class Coordinator {
        private weak var scene: FlybyNighterScene?
        private weak var view: NSView?
        private var keyMonitor: Any?
        private var pressedKeyCodes = Set<UInt16>()

        deinit {
            if let keyMonitor {
                NSEvent.removeMonitor(keyMonitor)
            }
        }

        func attach(scene: FlybyNighterScene, view: NSView) {
            self.scene = scene
            self.view = view
            installKeyMonitorIfNeeded()
        }

        func updateView(_ view: NSView) {
            self.view = view
        }

        private func installKeyMonitorIfNeeded() {
            guard keyMonitor == nil else { return }

            keyMonitor = NSEvent.addLocalMonitorForEvents(matching: [.keyDown, .keyUp]) { [weak self] event in
                guard let self,
                      let window = self.view?.window,
                      window.isKeyWindow else {
                    return event
                }

                return self.handle(event) ? nil : event
            }
        }

        private func handle(_ event: NSEvent) -> Bool {
            switch event.type {
            case .keyDown:
                return handleKeyDown(event)
            case .keyUp:
                return handleKeyUp(event)
            default:
                return false
            }
        }

        private func handleKeyDown(_ event: NSEvent) -> Bool {
            guard !event.isARepeat else {
                return isGameKey(event.keyCode)
            }

            if event.keyCode == KeyCode.space {
                scene?.setFiring(true)
                return true
            }

            if event.keyCode == KeyCode.returnKey || event.keyCode == KeyCode.keypadEnter {
                scene?.startOrRestartRun()
                return true
            }

            guard isMovementKey(event.keyCode) else { return false }
            pressedKeyCodes.insert(event.keyCode)
            applyMovement()
            return true
        }

        private func handleKeyUp(_ event: NSEvent) -> Bool {
            if event.keyCode == KeyCode.space {
                scene?.setFiring(false)
                return true
            }

            guard isMovementKey(event.keyCode) else { return false }
            pressedKeyCodes.remove(event.keyCode)
            applyMovement()
            return true
        }

        private func applyMovement() {
            var x = 0.0
            var y = 0.0

            if pressedKeyCodes.contains(KeyCode.a) || pressedKeyCodes.contains(KeyCode.leftArrow) {
                x -= 1
            }
            if pressedKeyCodes.contains(KeyCode.d) || pressedKeyCodes.contains(KeyCode.rightArrow) {
                x += 1
            }
            if pressedKeyCodes.contains(KeyCode.s) || pressedKeyCodes.contains(KeyCode.downArrow) {
                y -= 1
            }
            if pressedKeyCodes.contains(KeyCode.w) || pressedKeyCodes.contains(KeyCode.upArrow) {
                y += 1
            }

            scene?.setMovement(Vector2(x: x, y: y))
        }

        private func isMovementKey(_ keyCode: UInt16) -> Bool {
            keyCode == KeyCode.a ||
            keyCode == KeyCode.s ||
            keyCode == KeyCode.d ||
            keyCode == KeyCode.w ||
            keyCode == KeyCode.leftArrow ||
            keyCode == KeyCode.rightArrow ||
            keyCode == KeyCode.downArrow ||
            keyCode == KeyCode.upArrow
        }

        private func isGameKey(_ keyCode: UInt16) -> Bool {
            isMovementKey(keyCode) ||
            keyCode == KeyCode.space ||
            keyCode == KeyCode.returnKey ||
            keyCode == KeyCode.keypadEnter
        }
    }
}

private enum KeyCode {
    static let a: UInt16 = 0
    static let s: UInt16 = 1
    static let d: UInt16 = 2
    static let w: UInt16 = 13
    static let space: UInt16 = 49
    static let returnKey: UInt16 = 36
    static let keypadEnter: UInt16 = 76
    static let leftArrow: UInt16 = 123
    static let rightArrow: UInt16 = 124
    static let downArrow: UInt16 = 125
    static let upArrow: UInt16 = 126
}
#else
import Foundation

@main
enum FlybyNighterAppUnavailable {
    static func main() {
        print("FlybyNighterApp is available on macOS in this slice.")
    }
}
#endif
