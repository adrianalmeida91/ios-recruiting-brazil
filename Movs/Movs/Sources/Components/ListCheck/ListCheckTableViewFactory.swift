//
//  ListCheckTableViewFactory.swift
//  Movs
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum ListCheckTableViewFactory {
    static func make() -> ListCheckTableView {
        let listCheckItem = ListCheckTableView()

        return listCheckItem
    }
}
