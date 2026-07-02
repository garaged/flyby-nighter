#if canImport(AVFoundation)
import AVFoundation
import Foundation

enum PlaceholderAudioCue: Equatable {
    case playerShot
    case enemyRemoved
    case playerDamaged
    case giftCollected
    case shieldUsed
    case runCompleted
    case runFailed
}

final class PlaceholderAudioPlayer {
    var isEnabled = true

    private let engine = AVAudioEngine()
    private let player = AVAudioPlayerNode()
    private let format = AVAudioFormat(standardFormatWithSampleRate: 44_100, channels: 1)!

    init() {
        #if os(iOS) || os(tvOS)
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.ambient, mode: .default, options: [.mixWithOthers])
        try? session.setActive(true)
        #endif

        engine.attach(player)
        engine.connect(player, to: engine.mainMixerNode, format: format)
        try? engine.start()
    }

    func play(_ cue: PlaceholderAudioCue) {
        guard isEnabled, let buffer = makeBuffer(for: cue) else { return }

        if !engine.isRunning {
            try? engine.start()
        }
        if !player.isPlaying {
            player.play()
        }

        player.scheduleBuffer(buffer, at: nil, options: [], completionHandler: nil)
    }

    private func makeBuffer(for cue: PlaceholderAudioCue) -> AVAudioPCMBuffer? {
        let spec = PlaceholderToneSpec(cue)
        let frameCount = AVAudioFrameCount(spec.duration * spec.sampleRate)
        guard let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount) else {
            return nil
        }
        buffer.frameLength = frameCount

        guard let samples = buffer.floatChannelData?[0] else {
            return nil
        }

        for frame in 0..<Int(frameCount) {
            let t = Double(frame) / spec.sampleRate
            let envelope = Self.envelope(time: t, duration: spec.duration)
            let primary = sin(2.0 * Double.pi * spec.frequency * t)
            let secondary = sin(2.0 * Double.pi * spec.frequency * spec.harmonicRatio * t) * 0.35
            samples[frame] = Float((primary + secondary) * spec.amplitude * envelope)
        }

        return buffer
    }

    private static func envelope(time: Double, duration: Double) -> Double {
        let attack = 0.01
        let release = 0.06

        if time < attack {
            return time / attack
        }

        let remaining = max(0, duration - time)
        if remaining < release {
            return remaining / release
        }

        let decayProgress = min(1, (time - attack) / max(0.001, duration - attack - release))
        return 1.0 - 0.45 * decayProgress
    }
}

private struct PlaceholderToneSpec {
    let frequency: Double
    let harmonicRatio: Double
    let duration: Double
    let amplitude: Double
    let sampleRate: Double = 44_100

    init(_ cue: PlaceholderAudioCue) {
        switch cue {
        case .playerShot:
            frequency = 880
            harmonicRatio = 1.5
            duration = 0.055
            amplitude = 0.18
        case .enemyRemoved:
            frequency = 260
            harmonicRatio = 2.0
            duration = 0.12
            amplitude = 0.22
        case .playerDamaged:
            frequency = 120
            harmonicRatio = 1.25
            duration = 0.18
            amplitude = 0.24
        case .giftCollected:
            frequency = 660
            harmonicRatio = 2.25
            duration = 0.14
            amplitude = 0.20
        case .shieldUsed:
            frequency = 420
            harmonicRatio = 3.0
            duration = 0.16
            amplitude = 0.19
        case .runCompleted:
            frequency = 740
            harmonicRatio = 1.333
            duration = 0.28
            amplitude = 0.22
        case .runFailed:
            frequency = 150
            harmonicRatio = 0.75
            duration = 0.30
            amplitude = 0.24
        }
    }
}
#else
enum PlaceholderAudioCue: Equatable {
    case playerShot
    case enemyRemoved
    case playerDamaged
    case giftCollected
    case shieldUsed
    case runCompleted
    case runFailed
}

final class PlaceholderAudioPlayer {
    var isEnabled = false
    func play(_ cue: PlaceholderAudioCue) {}
}
#endif
