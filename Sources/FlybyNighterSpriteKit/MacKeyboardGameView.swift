#if os(macOS)
import AppKit
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
        window?.makeFirstResponder(self)
    }

    public override func keyDown(with event: NSEvent) {
        guard !event.isARepeat else { return }
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
#endif
