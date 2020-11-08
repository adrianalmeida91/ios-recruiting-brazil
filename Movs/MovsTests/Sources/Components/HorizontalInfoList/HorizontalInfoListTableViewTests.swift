//
//  HorizontalInfoListTableViewTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 07/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import FBSnapshotTestCase
@testable import Movs

final class HorizontalInfoListTableViewTests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()

        recordMode = false
    }

    // MARK: - Test functions

    func testShouldShowHorizontalInfoListTableView() {
        let sut = HorizontalInfoListTableView()
        sut.setupDataSource(items: getItems())

        addHorizontalInfoListTableViewLayout(horizontalInfoTableView: sut)

        wait(for: Constants.Utils.sleep)

        verify(sut)
    }

    func testShouldUpdateHorizontalInfoListTableView() {
        let sut = HorizontalInfoListTableView()
        sut.setupDataSource(items: getItems())

        let sutViewController = addHorizontalInfoListTableViewLayout(horizontalInfoTableView: sut)

        let newItems: [HorizontalInfoListViewModel] = getItems().reversed()
        sut.setupDataSource(items: newItems)

        sutViewController.view.layoutIfNeeded()

        wait(for: Constants.Utils.sleep)

        verify(sut)
    }

    func testShouldCreateHorizontalInfoListTableViewByFactory() {
        let sut = HorizontalInfoListFactory.make()
        sut.setupDataSource(items: getItems())

        addHorizontalInfoListTableViewLayout(horizontalInfoTableView: sut)

        wait(for: Constants.Utils.sleep)

        verify(sut)
    }

    // MARK: - Private functions

    @discardableResult
    private func addHorizontalInfoListTableViewLayout(horizontalInfoTableView: HorizontalInfoListTableView) -> UIViewController {
        let sutViewController = addSubviewForTest(horizontalInfoTableView) { (viewController: UIViewController) -> [NSLayoutConstraint] in
            [
                horizontalInfoTableView.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor),
                horizontalInfoTableView.leadingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.leadingAnchor),
                horizontalInfoTableView.trailingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.trailingAnchor),
                horizontalInfoTableView.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor)
            ]
        }

        sutViewController.view.layoutIfNeeded()

        return sutViewController
    }

    private func getItems() -> [HorizontalInfoListViewModel] {
        guard let moviesPopulariesResponse: MoviesPopulariesResponse = MocksHelper.getResponse() else {
            return []
        }

        return moviesPopulariesResponse.moviesResponse.map { movieResponse -> HorizontalInfoListViewModel in
            HorizontalInfoListViewModel(imageURL: Constants.MovieNetwork.baseImageURL.appending(movieResponse.imageURL), title: movieResponse.title, subtitle: movieResponse.releaseDate, descriptionText: movieResponse.overview)
        }
    }
}
