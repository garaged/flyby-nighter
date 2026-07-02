#if os(macOS)
import AppKit
import SpriteKit
import FlybyNighterCore
import FlybyNighterSpriteKit

@main
enum FlybyNighterMacMain {
    static func main() {
        let application = NSApplication.shared
        let delegate = FlybyNighterMacAppDelegate()
        application.delegate = delegate
        application.setActivationPolicy(.regular)
        application.activate(ignoringOtherApps: true)
        application.run()
        _ = delegate
    }
}

final class FlybyNighterMacAppDelegate: NSObject, NSApplicationDelegate {
    private var window: NSWindow?

    func applicationDidFinishLaunching(_ notification: Notification) {
        let sceneSize = CGSize(width: 640, height: 600)
        let scene = FlybyNighterScene(size: sceneSize)

        let gameView = KeyboardGameView(frame: CGRect(origin: .zero, size: sceneSize))
        gameView.ignoresSiblingOrder = true
        gameView.preferredFramesPerSecond = 60
        gameView.gameScene = scene
        gameView.presentScene(scene)

        let window = NSWindow(
            contentRect: CGRect(origin: .zero, size: sceneSize),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )
        window.title = "Flyby Nighter"
        window.contentView = gameView
        window.center()
        window.makeKeyAndOrderFront(nil)
        window.orderFrontRegardless()
        window.makeFirstResponder(gameView)

        self.window = window
        NSApplication.shared.activate(ignoringOtherApps: true)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}

final class KeyboardGameView: SKView {
    weak var gameScene: FlybyNighterScene? {
        didSet { applyInput() }
    }

    private var pressedKeyCodes = Set<UInt16>()

    override var acceptsFirstResponder: Bool { true }

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        window?.makeFirstResponder(self)
    }

    override func keyDown(with event: NSEvent) {
        guard !event.isARepeat else { return }

        if event.keyCode == KeyCode.leftArrow, gameScene?.selectPreviousRoute() == true {
            return
        }
        if event.keyCode == KeyCode.rightArrow, gameScene?.selectNextRoute() == true {
            return
        }

        pressedKeyCodes.insert(event.keyCode)

        if event.keyCode == KeyCode.space {
            gameScene?.setFiring(true)
        } else if event.keyCode == KeyCode.returnKey || event.keyCode == KeyCode.keypadEnter {
            gameScene?.startOrRestartRun()
        } else {
            applyInput()
        }
    }

    override func keyUp(with event: NSEvent) {
        pressedKeyCodes.remove(event.keyCode)

        if event.keyCode == KeyCode.space {
            gameScene?.setFiring(false)
        } else {
            applyInput()
        }
    }

    override func mouseUp(with event: NSEvent) {
        let location = convert(event.locationInWindow, from: nil)
        let normalizedX = bounds.width > 0 ? location.x / bounds.width : 0.5
        if gameScene?.handleRouteSelectionPointer(normalizedX: normalizedX) == true {
            return
        }
        gameScene?.startOrRestartRun()
    }

    private func applyInput() {
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

        gameScene?.setMovement(Vector2(x: x, y: y))
    }
}

enum KeyCode {
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
enum UnsupportedPlatformApp {
    static func main() {
        print("FlybyNighterMac is only supported on macOS.")
    }
}
#endif
