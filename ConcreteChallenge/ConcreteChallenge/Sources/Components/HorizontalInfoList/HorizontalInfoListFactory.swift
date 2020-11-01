//
//  HorizontalInfoListFactory.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 31/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum HorizontalInfoListFactory {
    static func makeTableView() -> HorizontalInfoListTableView {
        let tableView = HorizontalInfoListTableView()

        return tableView
    }
}
