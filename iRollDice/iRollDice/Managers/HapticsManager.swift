//
//  HapticsManager.swift
//  iRollDice
//
//  Created by Tiago Camargo Maciel dos Santos on 08/08/25.
//

import CoreHaptics
import UIKit

class HapticsManager {
    static let shared = HapticsManager()
    private var engine: CHHapticEngine? = nil
    
    private let generator = UINotificationFeedbackGenerator()
    
    private init() {}
    func play(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
    
    func prepareEngine() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Failed to create engine: \(error.localizedDescription)")
        }
    }

    func play() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        guard let engine else { return }
        
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0.1, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            // Cria um evento haptic com determinada intensidade e agudez
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        for i in stride(from: 0.1, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }

        do {
            // Cria o padrão Haptic a partir dos eventos criados
            let pattern = try CHHapticPattern(events: events, parameters: [])
            // Prepara o motor para executar o padrão Haptic criado
            let player = try engine.makePlayer(with: pattern)
            // Executa o padrão Haptic criado no momento 0, ou seja, quando a
            // função é disparada
            try player.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}
