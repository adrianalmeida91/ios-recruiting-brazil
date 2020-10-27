//
//  MovieViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 23/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class MoviesViewController: UIViewController, MoviesDisplayLogic {
    private let interactor: MoviesBusinessLogic

    private lazy var galleryItemView: GalleryItemView = {
        return GalleryItemView(itemSize: itemSize)
    }()

    // MARK: - Private variables

    private var itemSize: CGSize = CGSize(width: 0, height: 0)

    // MARK: - Initializers

    init(interactor: MoviesBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Override functions

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
//        fetchMovies()
    }

    // MARK: - MoviesDisplayLogic conforms

    func displayMoviesItems(viewModel: MoviesModels.MoviesItems.ViewModel) {
        print(viewModel.moviesResponse)
    }

    func displayMoviesError() { }

    // MARK: - Private functions

    private func setupLayout() {
        let anchorConstraint = CGFloat(16)
        self.itemSize = getItemSize(horizontalConstraint: anchorConstraint, verticalConstraint: anchorConstraint)

        view.addSubview(galleryItemView, constraints: [
            galleryItemView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: anchorConstraint),
            galleryItemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: anchorConstraint),
            galleryItemView.heightAnchor.constraint(equalToConstant: itemSize.height),
            galleryItemView.widthAnchor.constraint(equalToConstant: itemSize.width),
        ])

        view.backgroundColor = .white
    }

    private func getItemSize(horizontalConstraint: CGFloat, verticalConstraint: CGFloat) -> CGSize {
        let verticalItemsToShow = CGFloat(2.5)
        let horizontalItemsToShow = CGFloat(2)
        let heightCell = (view.safeAreaLayoutGuide.layoutFrame.size.height - verticalConstraint * (verticalItemsToShow + 1)) / verticalItemsToShow
        let widthCell = (view.safeAreaLayoutGuide.layoutFrame.size.width - horizontalConstraint * (horizontalItemsToShow + 1)) / horizontalItemsToShow

        return CGSize(width: widthCell, height: heightCell)
    }

    private func fetchMovies(language: String = Constants.MovieDefaultParameters.language, page: Int = Constants.MovieDefaultParameters.page) {
        interactor.fetchMovies(request: MoviesModels.MoviesItems.Request(language: language, page: page))
    }
}
