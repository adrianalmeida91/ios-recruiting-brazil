//
//  FilterProtocol.swift
//  Movs
//
//  Created by Adrian Almeida on 30/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol FilterProtocol: AnyObject {
    var useOnlySearchFilter: Bool { get }

    func filter(newFilter: FilterSearch)
}
