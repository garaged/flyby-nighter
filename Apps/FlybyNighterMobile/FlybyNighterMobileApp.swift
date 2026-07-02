import SpriteKit
import SwiftUI
import FlybyNighterSpriteKit

@main
struct FlybyNighterMobileApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var gameModel = MobileGameModel()

    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.black.ignoresSafeArea()
                MobileGameView(model: gameModel)
            }
            .onChange(of: scenePhase) { phase in
                gameModel.setActive(phase == .active)
            }
        }
    }
}

@MainActor
final class MobileGameModel: ObservableObject {
    let scene = FlybyNighterScene(size: CGSize(width: 844, height: 390))

    init() {
        scene.scaleMode = .resizeFill
        scene.setAudioEnabled(!ProcessInfo.processInfo.arguments.contains("--mute-audio"))
    }

    func resize(to size: CGSize) {
        guard size.width > 0, size.height > 0 else { return }
        scene.size = size
    }

    func setActive(_ active: Bool) {
        scene.setLifecyclePaused(!active)
    }
}

struct MobileGameView: View {
    @ObservedObject var model: MobileGameModel

    var body: some View {
        GeometryReader { proxy in
            SpriteView(
                scene: model.scene,
                options: [.ignoresSiblingOrder]
            )
            .background(Color.black)
            .onAppear {
                model.resize(to: proxy.size)
                model.setActive(true)
            }
            .onChange(of: proxy.size) { newSize in
                model.resize(to: newSize)
            }
        }
    }
}
