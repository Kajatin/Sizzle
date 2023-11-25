//
//  Item.swift
//  Sizzle
//
//  Created by Roland Kajatin on 25/11/2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
