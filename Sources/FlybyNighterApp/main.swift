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
    func makeNSView(context: Context) -> SKView {
        let sceneSize = CGSize(width: 640, height: 600)
        let scene = FlybyNighterScene(size: sceneSize)
        let view = SKView(frame: CGRect(origin: .zero, size: sceneSize))
        view.ignoresSiblingOrder = true
        view.preferredFramesPerSecond = 60
        view.presentScene(scene)
        return view
    }

    func updateNSView(_ nsView: SKView, context: Context) {}
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
