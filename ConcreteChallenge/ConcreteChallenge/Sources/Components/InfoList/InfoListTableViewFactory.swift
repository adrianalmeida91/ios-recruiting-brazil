//
//  InfoListTableViewFactory.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 30/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum InfoListTableViewFactory {
    static func makeTableView(movie: Movie) -> InfoListTableView {
        let tablewView = InfoListTableView()

        return tablewView
    }
}