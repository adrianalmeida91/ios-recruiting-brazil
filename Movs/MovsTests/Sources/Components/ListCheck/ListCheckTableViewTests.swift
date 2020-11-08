//
//  ListCheckTableViewTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 08/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import FBSnapshotTestCase
@testable import Movs

final class ListCheckTableViewTests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()

        recordMode = false
    }

    // MARK: - Test functions

    func testShouldShowCheckListTableView() {
        let sut = ListCheckTableView()
        sut.setupDataSource(items: getItems())

        addSubviewForTest(equalConstraintsFor: sut)

        verify(sut)
    }

    func testShouldCreateCheckListTableViewByFactory() {
        let sut = ListCheckTableViewFactory.make()
        sut.setupDataSource(items: getItems())

        addSubviewForTest(equalConstraintsFor: sut)

        verify(sut)
    }

    func testShouldUpdateCheckListTableView() {
        let sut = ListCheckTableView()
        sut.setupDataSource(items: getItems())

        let sutViewController = addSubviewForTest(equalConstraintsFor: sut)
        sutViewController.view.layoutIfNeeded()

        let newViewModel: [ListCheckItemViewModel] = getItems().reversed()
        sut.setupDataSource(items: newViewModel)

        verify(sut)
    }

    // MARK: - Private functions

    private func getItems() -> [ListCheckItemViewModel] {
        return [
            ListCheckItemViewModel(title: Strings.mockDog.localizable, value: Strings.mockDate.localizable, icon: .arrowForward),
            ListCheckItemViewModel(title: Strings.mockOtherDog.localizable, value: Strings.mockGenres.localizable, icon: .arrowForward)
        ]
    }
}
