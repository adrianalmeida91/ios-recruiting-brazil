//
//  AccessibilityIdentifier.swift
//  Movs
//
//  Created by Adrian Almeida on 06/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol AccessibilityIdentifier: RawRepresentable {
    var name: String { get }

    var identifier: String { get }
}

extension AccessibilityIdentifier {
    var identifier: String {
        if name.isEmpty {
            return "\(rawValue)_identifier"
        }

        return "\(name)_\(rawValue)_identifier"
    }
}
