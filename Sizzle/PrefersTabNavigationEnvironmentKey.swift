//
//  PrefersTabNavigationEnvironmentKey.swift
//  Sizzle
//
//  Created by Roland Kajatin on 25/11/2023.
//

import SwiftUI

struct PrefersTabNavigationEnvironmentKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var prefersTabNavigation: Bool {
        get { self[PrefersTabNavigationEnvironmentKey.self] }
        set { self[PrefersTabNavigationEnvironmentKey.self] = newValue }
    }
}

#if canImport(UIKit)
extension PrefersTabNavigationEnvironmentKey: UITraitBridgedEnvironmentKey {
    static func read(from traitCollection: UITraitCollection) -> Bool {
        return traitCollection.userInterfaceIdiom == .phone
    }
    
    static func write(to mutableTraits: inout UIMutableTraits, value: Bool) {
        // Do not write
    }
}
#endif
