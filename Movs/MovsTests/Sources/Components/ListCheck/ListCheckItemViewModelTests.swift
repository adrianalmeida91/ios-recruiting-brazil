//
//  ListCheckItemViewModelTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 08/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Fakery
import XCTest
@testable import Movs

final class ListCheckItemViewModelTests: XCTestCase {
    let faker = Faker(locale: Constants.MovieDefaultParameters.language)

    // MARK: - Test functions

    func testViewModelShouldBeEmpty() {
        let viewModel = ListCheckItemViewModel()

        XCTAssertNil(viewModel.title)
        XCTAssertNil(viewModel.value)
        XCTAssertNil(viewModel.icon)
    }

    func testViewModelHasOnlyTitle() {
        let name = faker.name.firstName()
        let viewModel = ListCheckItemViewModel(title: name)

        XCTAssertEqual(viewModel.title, name)
        XCTAssertNil(viewModel.value)
        XCTAssertNil(viewModel.icon)
    }

    func testViewModelHasOnlyValue() {
        let lastName = faker.name.lastName()
        let viewModel = ListCheckItemViewModel(value: lastName)

        XCTAssertNil(viewModel.title)
        XCTAssertEqual(viewModel.value, lastName)
        XCTAssertNil(viewModel.icon)
    }

    func testViewModelHasOnlyIcon() {
        let icon = UIImage.Assets.allCases.randomElement()
        let viewModel = ListCheckItemViewModel(icon: icon)

        XCTAssertNil(viewModel.title)
        XCTAssertNil(viewModel.value)
        XCTAssertEqual(viewModel.icon, icon)
    }

    func testViewModelHasTitleAndValue() {
        let name = faker.name.firstName()
        let lastName = faker.name.lastName()
        let viewModel = ListCheckItemViewModel(title: name, value: lastName)

        XCTAssertEqual(viewModel.title, name)
        XCTAssertEqual(viewModel.value, lastName)
        XCTAssertNil(viewModel.icon)
    }

    func testViewModelHasTitleAndIcon() {
        let name = faker.name.firstName()
        let icon = UIImage.Assets.allCases.randomElement()
        let viewModel = ListCheckItemViewModel(title: name, icon: icon)

        XCTAssertEqual(viewModel.title, name)
        XCTAssertNil(viewModel.value)
        XCTAssertEqual(viewModel.icon, icon)
    }

    func testViewModelHasValueAndIcon() {
        let lastName = faker.name.lastName()
        let icon = UIImage.Assets.allCases.randomElement()
        let viewModel = ListCheckItemViewModel(value: lastName, icon: icon)

        XCTAssertNil(viewModel.title)
        XCTAssertEqual(viewModel.value, lastName)
        XCTAssertEqual(viewModel.icon, icon)
    }

    func testViewModelShouldBeComplete() {
        let name = faker.name.firstName()
        let lastName = faker.name.lastName()
        let icon = UIImage.Assets.allCases.randomElement()
        let viewModel = ListCheckItemViewModel(title: name, value: lastName, icon: icon)

        XCTAssertEqual(viewModel.title, name)
        XCTAssertEqual(viewModel.value, lastName)
        XCTAssertEqual(viewModel.icon, icon)
    }
}
