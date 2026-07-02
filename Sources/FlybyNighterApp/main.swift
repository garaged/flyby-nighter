#if os(macOS)
import AppKit
import SpriteKit
import FlybyNighterSpriteKit

final class FlybyNighterAppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    private var window: NSWindow?
    private var gameView: MacKeyboardGameView?

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
        window.delegate = self
        window.center()
        window.makeKeyAndOrderFront(nil)
        window.makeFirstResponder(gameView)

        self.window = window
        self.gameView = gameView
        NSApplication.shared.activate(ignoringOtherApps: true)
    }

    func applicationWillResignActive(_ notification: Notification) {
        pauseGameplay()
    }

    func applicationDidBecomeActive(_ notification: Notification) {
        resumeGameplay()
    }

    func windowDidResignKey(_ notification: Notification) {
        pauseGameplay()
    }

    func windowDidBecomeKey(_ notification: Notification) {
        resumeGameplay()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }

    private func pauseGameplay() {
        gameView?.resetInputState()
        gameView?.isPaused = true
    }

    private func resumeGameplay() {
        guard let gameView else { return }
        gameView.resetInputState()
        gameView.isPaused = false
        gameView.requestKeyboardFocus()
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
