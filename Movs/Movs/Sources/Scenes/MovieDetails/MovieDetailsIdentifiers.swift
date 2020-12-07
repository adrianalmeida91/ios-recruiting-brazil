//
//  MovieDetailsIdentifiers.swift
//  Movs
//
//  Created by Adrian Almeida on 06/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

enum MovieDetailsIdentifiers: String, AccessibilityIdentifier {
    case movieDetailsImageView = "movie_details_image_view"

    // MARK: - AccessibilityIdentifier conforms

    var name: String {
        "movie_details"
    }
}
