//
//  Localizable.swift
//  Movs
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

protocol Localizable {
    var localizable: String { get }

    var bundle: Bundle { get }
}

extension Localizable where Self: RawRepresentable, RawValue == String {
    var localizable: String {
        return NSLocalizedString(rawValue, bundle: bundle, comment: .empty)
    }

    var bundle: Bundle {
        return Bundle.main
    }

    // MARK: - Functions

    func localizable(with arguments: CVarArg...) -> String {
        return String(format: localizable, arguments)
    }
}
