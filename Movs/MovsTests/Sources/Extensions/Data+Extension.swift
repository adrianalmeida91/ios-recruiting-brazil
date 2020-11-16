//
//  Data+Extension.swift
//  MovsTests
//
//  Created by Adrian Almeida on 08/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation
@testable import Movs

extension Date {
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.Utils.dateFormat

        return dateFormatter.string(from: self)
    }
}
