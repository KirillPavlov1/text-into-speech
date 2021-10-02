//
//  UserSettings.swift
//  text_to_speech
//
//  Created by Кирилл on 25.09.2021.
//

import Foundation
import Combine
import SwiftUI

class UserSettings: ObservableObject {
    @Published var font_size: Int {
        didSet {
            UserDefaults.standard.set(font_size, forKey: "font_size")
        }
    }
    @Published var line_spacing: Int {
        didSet {
            UserDefaults.standard.set(line_spacing, forKey: "line_spacing")
        }
    }
    @Published var rate: Float {
        didSet {
            UserDefaults.standard.set(rate, forKey: "rate")
        }
    }
    init() {
        self.font_size = UserDefaults.standard.object(forKey: "font_size") as? Int ?? 20
        self.line_spacing = UserDefaults.standard.object(forKey: "line_spacing") as? Int ?? 5
        self.rate = UserDefaults.standard.object(forKey: "rate") as? Float ?? 0.5
    }
}
