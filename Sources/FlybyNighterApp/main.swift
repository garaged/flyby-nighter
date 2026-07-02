#if os(macOS)
import SpriteKit
import SwiftUI
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
    func makeNSView(context: Context) -> MacKeyboardGameView {
        let sceneSize = CGSize(width: 640, height: 600)
        let scene = FlybyNighterScene(size: sceneSize)
        let view = MacKeyboardGameView(frame: CGRect(origin: .zero, size: sceneSize))
        view.ignoresSiblingOrder = true
        view.preferredFramesPerSecond = 60
        view.gameScene = scene
        view.presentScene(scene)
        view.requestKeyboardFocus()
        return view
    }

    func updateNSView(_ nsView: MacKeyboardGameView, context: Context) {
        nsView.requestKeyboardFocus()
    }
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
