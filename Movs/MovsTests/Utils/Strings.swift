//
//  Strings.swift
//  MovsTests
//
//  Created by Adrian Almeida on 07/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation
@testable import Movs

enum Strings: String, Localizable {
    case mockMainDogImageURL = "mock_main_dog_image_url"
    case mockSecondaryDogImageURL = "mock_secondary_dog_image_url"
    case mockDog = "mock_dog"
    case mockOtherDog = "mock_other_dog"
    case mockDate = "mock_date"
    case mockOverview = "mock_overview"

    // MARK: - Computed variables

    var bundle: Bundle {
        return Bundle(for: MocksHelper.self)
    }
}
