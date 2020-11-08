//
//  InfoListItemViewModelTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 07/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Fakery
import XCTest
@testable import Movs

final class InfoListItemViewModelTests: XCTestCase {
    let faker = Faker(locale: Constants.MovieDefaultParameters.language)

    // MARK: - Test functions

    func testViewModelShouldBeEmpty() {
        let viewModel = InfoListItemViewModel()

        XCTAssertNil(viewModel.title)
        XCTAssertNil(viewModel.icon)
        XCTAssertNil(viewModel.descriptionText)
        XCTAssertNil(viewModel.action)
        XCTAssertTrue(viewModel.isEmpty)
    }

    func testViewModelShouldHasOnlyTitle() {
        let catName = faker.cat.name()
        let viewModel = InfoListItemViewModel(title: catName)

        XCTAssertEqual(viewModel.title, catName)
        XCTAssertNil(viewModel.icon)
        XCTAssertNil(viewModel.descriptionText)
        XCTAssertNil(viewModel.action)
        XCTAssertFalse(viewModel.isEmpty)
    }

    func testViewModelShouldHasOnlyIcon() {
        let icon = UIImage.Assets.allCases.randomElement()
        let viewModel = InfoListItemViewModel(icon: icon)

        XCTAssertNil(viewModel.title)
        XCTAssertEqual(viewModel.icon, icon)
        XCTAssertNil(viewModel.descriptionText)
        XCTAssertNil(viewModel.action)
        XCTAssertFalse(viewModel.isEmpty)
    }

    func testViewModelShouldHasOnlyDescription() {
        let text = faker.lorem.sentences()
        let viewModel = InfoListItemViewModel(descriptionText: text)

        XCTAssertNil(viewModel.title)
        XCTAssertNil(viewModel.icon)
        XCTAssertEqual(viewModel.descriptionText, text)
        XCTAssertNil(viewModel.action)
        XCTAssertFalse(viewModel.isEmpty)
    }

    func testViewModelShouldHasTitleAndIcon() {
        let catName = faker.cat.name()
        let icon = UIImage.Assets.allCases.randomElement()
        let viewModel = InfoListItemViewModel(title: catName, icon: icon)

        XCTAssertEqual(viewModel.title, catName)
        XCTAssertEqual(viewModel.icon, icon)
        XCTAssertNil(viewModel.descriptionText)
        XCTAssertNil(viewModel.action)
        XCTAssertFalse(viewModel.isEmpty)
    }

    func testViewModelShouldHasTitleAndDescription() {
        let catName = faker.cat.name()
        let text = faker.lorem.sentences()
        let viewModel = InfoListItemViewModel(title: catName, descriptionText: text)

        XCTAssertEqual(viewModel.title, catName)
        XCTAssertNil(viewModel.icon)
        XCTAssertEqual(viewModel.descriptionText, text)
        XCTAssertNil(viewModel.action)
        XCTAssertFalse(viewModel.isEmpty)
    }

    func testViewModelShouldHasIconAndDescription() {
        let icon = UIImage.Assets.allCases.randomElement()
        let text = faker.lorem.sentences()
        let viewModel = InfoListItemViewModel(icon: icon, descriptionText: text)

        XCTAssertNil(viewModel.title)
        XCTAssertEqual(viewModel.icon, icon)
        XCTAssertEqual(viewModel.descriptionText, text)
        XCTAssertNil(viewModel.action)
        XCTAssertFalse(viewModel.isEmpty)
    }

    func testViewModelShouldBeComplete() {
        let catName = faker.cat.name()
        let icon = UIImage.Assets.allCases.randomElement()
        let text = faker.lorem.sentences()
        let viewModel = InfoListItemViewModel(title: catName, icon: icon, descriptionText: text)

        XCTAssertEqual(viewModel.title, catName)
        XCTAssertEqual(viewModel.icon, icon)
        XCTAssertEqual(viewModel.descriptionText, text)
        XCTAssertNil(viewModel.action)
        XCTAssertFalse(viewModel.isEmpty)
    }
}
