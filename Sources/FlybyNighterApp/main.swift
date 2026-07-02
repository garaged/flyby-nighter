#if os(macOS)
import AppKit
import SpriteKit
import FlybyNighterSpriteKit

final class FlybyNighterAppDelegate: NSObject, NSApplicationDelegate {
    private var window: NSWindow?

    func applicationDidFinishLaunching(_ notification: Notification) {
        let sceneSize = CGSize(width: 640, height: 600)
        let scene = FlybyNighterScene(size: sceneSize)
        let gameView = MacKeyboardGameView(frame: CGRect(origin: .zero, size: sceneSize))

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
        window.makeFirstResponder(gameView)

        self.window = window
        NSApplication.shared.activate(ignoringOtherApps: true)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}

let application = NSApplication.shared
let delegate = FlybyNighterAppDelegate()
application.delegate = delegate
application.setActivationPolicy(.regular)
application.activate(ignoringOtherApps: true)
application.run()
#else
import Foundation
print("FlybyNighterApp is only supported on macOS in this slice.")
#endif
