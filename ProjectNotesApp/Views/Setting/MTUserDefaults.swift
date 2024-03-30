//
//  MTUserDefaults.swift
//  ProjectNotesApp
//
//  Created by Apple on 21.3.2024.
//

import UIKit

struct MTUserDefaults {
    
    static var shared = MTUserDefaults()
    
    var theme: Theme {
        get {
            Theme(rawValue: UserDefaults.standard.integer(forKey: "themes")) ?? .device
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "themes")
        }
    }
    
}
