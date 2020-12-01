//
//  MovieViewController.swift
//  Movs
//
//  Created by Adrian Almeida on 23/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

protocol MoviesDisplayLogic: AnyObject {
    func displayMovies(viewModel: Movies.FetchMovies.ViewModel)
    func displayError()
    func displaySearchedMovies(viewModel: Movies.FetchMoviesBySearch.ViewModel)
    func displaySearchError(searchedText: String)
}

final class MoviesViewController: UIViewController, FilterProtocol, MoviesDisplayLogic {
    private lazy var galleryCollectionView = GridGalleryCollectionView(itemSize: getItemSize(), items: [])

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [galleryCollectionView, errorView])
        stackView.axis = .vertical

        return stackView
    }()

    // MARK: - Private variables

    private var movies: [Movie] = []

    private var moviesFiltered: [Movie] = []

    private var currentPage: Int = 0

    private var lastPage: Int?

    private var filter: String = .empty

    // MARK: - Variables

    weak var delegate: MoviesViewControllerDelegate?

    // MARK: - Private constants

    private let interactor: MoviesBusinessLogic

    private let errorView: ErrorView = ErrorViewFactory.make()

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

        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchMovies()
    }

    // MARK: - FilterProtocol conforms

    var useOnlySearchFilter = true

    func filter(newFilter: FilterSearch) {
        guard let search = newFilter.search, !search.isEmpty else {
            clearSearch()
            return fetchMovies()
        }

        showGallery()

        filter = search

        let request = Movies.FetchMoviesBySearch.Request(filter: search)
        interactor.fetchMoviesBySearch(request: request)
    }

    // MARK: - MoviesDisplayLogic conforms

    func displayMovies(viewModel: Movies.FetchMovies.ViewModel) {
        currentPage = viewModel.page
        lastPage = viewModel.totalPages
        movies.append(contentsOf: viewModel.movies)

        reloadMovies()
    }

    func displayError() {
        displayErrorView()
    }

    func displaySearchedMovies(viewModel: Movies.FetchMoviesBySearch.ViewModel) {
        moviesFiltered = viewModel.movies

        reloadMovies()
    }

    func displaySearchError(searchedText: String) {
        let searchIcon = UIImage(assets: .searchIcon)
        let errorFormatted = String(format: Strings.errorSearch.localizable, searchedText)
        let configurationError = ErrorConfiguration(image: searchIcon, text: errorFormatted)
        displayErrorView(configuration: configurationError)
    }

    // MARK: - Private functions

    private func setup() {
        setupLayout()
        setupAction()
    }

    private func setupLayout() {
        view.addSubview(stackView, constraints: [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        view.backgroundColor = .white
    }

    private func setupAction() {
        galleryCollectionView.bindOnItemPress { [weak self] index in
            self?.galleryItemTapped(index)
        }

        galleryCollectionView.bindOnDisplayLastItem { [weak self] in
            self?.fetchNewPageMovies()
        }
    }

    private func galleryItemTapped(_ index: Int) {
        let movieTapped = moviesFiltered.count > 0 ? moviesFiltered[index] : movies[index]
        delegate?.galleryItemTapped(movie: movieTapped, self)
    }

    private func fetchNewPageMovies() {
        guard filter.isEmpty, let lastPage = lastPage, currentPage + 1 <= lastPage else {
            return
        }

        currentPage += 1
        fetchMovies(page: currentPage)
    }

    private func fetchMovies(language: String = Constants.MovieDefaultParameters.language, page: Int = Constants.MovieDefaultParameters.page) {
        // skip fetchMovies if user scroll faster than reloadMovies first time and evit reloadMovies twice before first response
        guard errorView.isHidden else {
            return
        }

        if page == Constants.MovieDefaultParameters.page {
            movies = []
        }

        let request = Movies.FetchMovies.Request(language: language, page: page)
        interactor.fetchMovies(request: request)
    }

    private func reloadMovies() {
        let displayMovies = moviesFiltered.count > 0 ? moviesFiltered : movies

        let itemsViewModel = displayMovies.map { movie -> GridGalleryItemViewModel in
            GridGalleryItemViewModel(imageURL: movie.imageURL, title: movie.title, isFavorite: movie.isFavorite)
        }

        galleryCollectionView.setupDataSource(items: itemsViewModel)
    }

    private func showGallery() {
        errorView.isHidden = true
        galleryCollectionView.isHidden = false
    }

    private func clearSearch() {
        filter = .empty
        moviesFiltered = []
    }

    private func displayErrorView(configuration: ErrorConfiguration = ErrorConfiguration()) {
        galleryCollectionView.isHidden = true
        errorView.isHidden = false

        currentPage = Constants.MovieDefaultParameters.page
        errorView.configuration = configuration
    }

    private func getItemSize() -> CGSize {
        let verticalMargin = CGFloat(Constants.GridGalleryCollectionView.verticalMargin)
        let horizontalMargin = CGFloat(Constants.GridGalleryCollectionView.horizontalMargin)

        let amountItemVertical = CGFloat(Constants.GridGalleryCollectionView.amountItemVertical)
        let amountItemHorizontal = CGFloat(Constants.GridGalleryCollectionView.amountItemHorizontal)

        let searchViewHeight = CGFloat(52)
        let tabBarHeight = CGFloat(48)

        let heightCell = (view.safeAreaLayoutGuide.layoutFrame.size.height - searchViewHeight - tabBarHeight - verticalMargin * (amountItemVertical + 1)) / amountItemVertical
        let widthCell = (view.safeAreaLayoutGuide.layoutFrame.size.width - horizontalMargin * (amountItemHorizontal + 1)) / amountItemHorizontal

        return CGSize(width: widthCell, height: heightCell)
    }
}
