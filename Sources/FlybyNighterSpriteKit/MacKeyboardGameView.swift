#if os(macOS)
import AppKit
import Dispatch
import SpriteKit
import FlybyNighterCore

@available(macOS 12.0, *)
public final class MacKeyboardGameView: SKView {
    public weak var gameScene: FlybyNighterScene? {
        didSet { applyInput() }
    }

    private var pressedKeyCodes = Set<UInt16>()

    public override var acceptsFirstResponder: Bool { true }

    public override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        requestKeyboardFocus()
    }

    public override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        true
    }

    public func requestKeyboardFocus() {
        DispatchQueue.main.async { [weak self] in
            guard let self, let window = self.window else { return }
            window.makeFirstResponder(self)
        }
    }

    public func resetInputState() {
        pressedKeyCodes.removeAll()
        gameScene?.setMovement(Vector2())
        gameScene?.setFiring(false)
    }

    public override func resignFirstResponder() -> Bool {
        resetInputState()
        return super.resignFirstResponder()
    }

    public override func viewWillMove(toWindow newWindow: NSWindow?) {
        if newWindow == nil {
            resetInputState()
        }
        super.viewWillMove(toWindow: newWindow)
    }

    public override func mouseDown(with event: NSEvent) {
        requestKeyboardFocus()
        super.mouseDown(with: event)
    }

    public override func keyDown(with event: NSEvent) {
        guard !event.isARepeat else { return }

        if event.keyCode == KeyCode.routeOne, selectRoute(.neonRift) {
            return
        }
        if event.keyCode == KeyCode.routeTwo, selectRoute(.glassTide) {
            return
        }
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

    public override func keyUp(with event: NSEvent) {
        pressedKeyCodes.remove(event.keyCode)

        if event.keyCode == KeyCode.space {
            gameScene?.setFiring(false)
        } else {
            applyInput()
        }
    }

    public override func mouseUp(with event: NSEvent) {
        requestKeyboardFocus()

        let location = convert(event.locationInWindow, from: nil)
        let normalizedX = bounds.width > 0 ? location.x / bounds.width : 0.5
        if gameScene?.handleRouteSelectionPointer(normalizedX: normalizedX) == true {
            return
        }

        gameScene?.startOrRestartRun()
    }

    private func selectRoute(_ routeID: RouteID) -> Bool {
        guard let gameScene, gameScene.isRouteSelectionAvailable else { return false }
        guard gameScene.selectedRouteID != routeID else { return true }

        _ = gameScene.selectNextRoute()
        return gameScene.selectedRouteID == routeID
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

private enum KeyCode {
    static let a: UInt16 = 0
    static let s: UInt16 = 1
    static let d: UInt16 = 2
    static let w: UInt16 = 13
    static let routeOne: UInt16 = 18
    static let routeTwo: UInt16 = 19
    static let space: UInt16 = 49
    static let returnKey: UInt16 = 36
    static let keypadEnter: UInt16 = 76
    static let leftArrow: UInt16 = 123
    static let rightArrow: UInt16 = 124
    static let downArrow: UInt16 = 125
    static let upArrow: UInt16 = 126
}
#endif
