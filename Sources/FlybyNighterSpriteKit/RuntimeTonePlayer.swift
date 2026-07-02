#if canImport(AVFoundation)
import AVFoundation
import Foundation

enum RuntimeToneCue: Equatable {
    case a
    case b
    case c
    case d
    case e
    case f
    case g
}

final class RuntimeTonePlayer {
    private let engine = AVAudioEngine()
    private let node = AVAudioPlayerNode()
    private let format = AVAudioFormat(standardFormatWithSampleRate: 44_100, channels: 1)!

    init() {
        engine.attach(node)
        engine.connect(node, to: engine.mainMixerNode, format: format)
        try? engine.start()
    }

    func play(_ cue: RuntimeToneCue) {
        guard let buffer = makeBuffer(for: cue) else { return }
        if !engine.isRunning {
            try? engine.start()
        }
        if !node.isPlaying {
            node.play()
        }
        node.scheduleBuffer(buffer, at: nil, options: [], completionHandler: nil)
    }

    private func makeBuffer(for cue: RuntimeToneCue) -> AVAudioPCMBuffer? {
        let spec = RuntimeToneSpec(cue)
        let frameCount = AVAudioFrameCount(spec.duration * spec.sampleRate)
        guard let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount) else { return nil }
        buffer.frameLength = frameCount
        guard let samples = buffer.floatChannelData?[0] else { return nil }

        for frame in 0..<Int(frameCount) {
            let t = Double(frame) / spec.sampleRate
            let fadeIn = min(1.0, t / 0.01)
            let fadeOut = min(1.0, max(0, spec.duration - t) / 0.05)
            let envelope = fadeIn * fadeOut
            let wave = sin(2.0 * Double.pi * spec.frequency * t)
            samples[frame] = Float(wave * spec.amplitude * envelope)
        }

        return buffer
    }
}

private struct RuntimeToneSpec {
    let frequency: Double
    let duration: Double
    let amplitude: Double
    let sampleRate: Double = 44_100

    init(_ cue: RuntimeToneCue) {
        switch cue {
        case .a:
            frequency = 880
            duration = 0.055
            amplitude = 0.18
        case .b:
            frequency = 260
            duration = 0.12
            amplitude = 0.22
        case .c:
            frequency = 120
            duration = 0.18
            amplitude = 0.24
        case .d:
            frequency = 660
            duration = 0.14
            amplitude = 0.20
        case .e:
            frequency = 420
            duration = 0.16
            amplitude = 0.19
        case .f:
            frequency = 740
            duration = 0.28
            amplitude = 0.22
        case .g:
            frequency = 150
            duration = 0.30
            amplitude = 0.24
        }
    }
}
#else
enum RuntimeToneCue: Equatable {
    case a
    case b
    case c
    case d
    case e
    case f
    case g
}

final class RuntimeTonePlayer {
    func play(_ cue: RuntimeToneCue) {}
}
#endif
