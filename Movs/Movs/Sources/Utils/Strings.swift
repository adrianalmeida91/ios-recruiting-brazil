//
//  Strings.swift
//  Movs
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

enum Strings: String, Localizable {
    case apply
    case date
    case favorites
    case filter
    case genres
    case movie
    case movies
    case movieUnfavoriteSuccessful = "movie_unfavorite_successful"
    case removeFilter = "remove_filter"
    case search
    case thereIsNotFavoriteMovie = "there_is_not_favorite_movie"
    case unfavorite
    case convertUrlFailure = "convert_url_failure"
    case errorDelete = "error_delete"
    case errorFetch = "error_fetch"
    case errorParseDataToString = "error_parse_data_to_string"
    case errorSave = "error_save"
    case errorSearch = "error_search"
    case repositryErrorDataNotFound = "repositry_error_data_not_found"
    case repositryErrorParseJSON = "repositry_error_parse_json"
    case viewControllerNotFound = "view_controller_not_found"

    // MARK: - Accessibility

    case favoriteValue = "favorite_value"
    case movieMarkedAs = "movie_marked_as"
    case posterImageView = "poster_image_view"
    case unfavoriteValue = "unfavorite_value"
}
