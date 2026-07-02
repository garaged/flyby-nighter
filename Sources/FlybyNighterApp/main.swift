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
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeNSView(context: Context) -> SKView {
        let sceneSize = CGSize(width: 640, height: 600)
        let scene = FlybyNighterScene(size: sceneSize)
        let view = SKView(frame: CGRect(origin: .zero, size: sceneSize))
        view.ignoresSiblingOrder = true
        view.preferredFramesPerSecond = 60
        view.presentScene(scene)
        context.coordinator.start(scene: scene)
        return view
    }

    func updateNSView(_ nsView: SKView, context: Context) {}

    final class Coordinator {
        private var keyboardPoller: KeyboardPoller?

        func start(scene: FlybyNighterScene) {
            keyboardPoller = KeyboardPoller(scene: scene)
        }
    }
}
#else
import Foundation

@main
enum FlybyNighterAppUnavailable {
    static func main() {
        print("FlybyNighterApp is only supported on macOS in this slice.")
    }
}
#endif
