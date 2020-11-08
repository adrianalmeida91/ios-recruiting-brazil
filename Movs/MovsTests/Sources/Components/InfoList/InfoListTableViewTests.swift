//
//  InfoListTableViewTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 07/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import FBSnapshotTestCase
@testable import Movs

final class InfoListTableViewTests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()

        recordMode = false
    }

    // MARK: - Test functions

    func testShouldShowInfoListTableView() {
        let sut = InfoListTableView()
        sut.setupDataSource(items: getItems())

        addSubviewForTest(equalConstraintsFor: sut)

        verify(sut)
    }

    func testShouldUpdateInfoListTableView() {
        let sut = InfoListTableView()
        sut.setupDataSource(items: getItems())

        addSubviewForTest(equalConstraintsFor: sut)

        let newViewModel: [InfoListItemViewModel] = getItems().reversed()
        sut.setupDataSource(items: newViewModel)

        verify(sut)
    }

    func testShouldCreateInfoListTableViewByFactory() {
        let sut = InfoListTableViewFactory.make()
        sut.setupDataSource(items: getItems())

        addSubviewForTest(equalConstraintsFor: sut)

        verify(sut)
    }

    // MARK: - Private functions

    private func getItems() -> [InfoListItemViewModel] {
        return [
            InfoListItemViewModel(title: Strings.mockDog.localizable, icon: .favoriteEmptyIcon),
            InfoListItemViewModel(title: Strings.mockDate.localizable),
            InfoListItemViewModel(title: Strings.mockGenres.localizable),
            InfoListItemViewModel(descriptionText: Strings.mockOverview.localizable)
        ]
    }
}
