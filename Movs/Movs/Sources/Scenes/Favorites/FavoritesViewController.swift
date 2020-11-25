//
//  FavoritesViewController.swift
//  Movs
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

protocol FavoritesDisplayLogic: AnyObject {
    func displayMovies(viewModel: Favorites.FetchMovies.ViewModel)
    func displayEmptyView()
    func displayMovieUnfavorite()
    func displayFailureError()
    func displaySearchedMovies(viewModel: Favorites.FetchMoviesBySearch.ViewModel)
    func displaySearchError(searchedText: String)
}

final class FavoritesViewController: UIViewController, FavoritesDisplayLogic {
    private lazy var removeFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.removeFilter.localizable, for: .normal)
        button.setTitleColor(.appYellowLight, for: .normal)
        button.backgroundColor = .appBlackLight
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.isHidden = true

        return button
    }()

    private lazy var horizontalTableView = HorizontalInfoListFactory.make()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [removeFilterButton, horizontalTableView, errorView])
        stackView.axis = .vertical

        return stackView
    }()

    // MARK: - Private variables

    private var movies: [Movie] = []

    private var moviesFiltered: [Movie] = []

    private var filter: FilterSearch = FilterSearch()

    // MARK: - Private constants

    private let interactor: FavoritesBusinessLogic

    private let errorView: ErrorView = ErrorViewFactory.make()

    // MARK: - Initializers

    init(interactor: FavoritesBusinessLogic) {
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

        filter(newFilter: FilterSearch())
    }

    // MARK: - Functions

    func filter(newFilter: FilterSearch) {
        filter = FilterSearch(search: newFilter.search ?? filter.search,
                                   date: newFilter.date ?? filter.date,
                                   genres: newFilter.genres ?? filter.genres)

        guard !filter.isEmpty else {
            return fetchMovies()
        }

        removeFilterButton.isHidden = filter.date == nil && filter.genres == nil
        interactor.fetchMoviesBySearch(request: Favorites.FetchMoviesBySearch.Request(filter: filter))
    }

    // MARK: - FavoritesDisplayLogic conforms

    func displayMovies(viewModel: Favorites.FetchMovies.ViewModel) {
        movies = viewModel.movies
        moviesFiltered = []

        setupViewModel()
    }

    func displayEmptyView() {
        displayEmptyMovie()
    }

    func displayMovieUnfavorite() {
        if movies.count <= 0 {
            displayEmptyMovie()
        }
    }

    func displayFailureError() {
        displayErrorView()
    }

    func displaySearchedMovies(viewModel: Favorites.FetchMoviesBySearch.ViewModel) {
        moviesFiltered = viewModel.movies

        setupViewModel()
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
        setupActions()
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

    private func setupActions() {
        removeFilterButton.addTarget(self, action: #selector(didRemoveFilterButtonTapped), for: .touchUpInside)

        horizontalTableView.bind { [weak self] index in
            self?.horizontalItemTapped(index)
        }
    }

    private func horizontalItemTapped(_ index: Int) {
        let movieToRemove = moviesFiltered.count > 0 ? moviesFiltered[index] : movies[index]

        if let indexToRemove = movies.firstIndex(of: movieToRemove) {
            movies.remove(at: indexToRemove)
        }

        if let indexToRemove = moviesFiltered.firstIndex(of: movieToRemove) {
            moviesFiltered.remove(at: indexToRemove)
        }

        setupViewModel()

        interactor.deleteMovie(request: Favorites.DeleteMovie.Request(movie: movieToRemove))
    }

    private func setupViewModel() {
        let moviesDisplay = moviesFiltered.count > 0 ? moviesFiltered : movies
        let horizontalItemsViewModel = moviesDisplay.map { movie -> HorizontalInfoListViewModel in
            HorizontalInfoListViewModel(imageURL: movie.imageURL, title: movie.title, subtitle: movie.releaseDate, descriptionText: movie.overview)
        }

        horizontalTableView.setupDataSource(items: horizontalItemsViewModel)
    }

    private func fetchMovies() {
        showHorizontalList()
        interactor.fetchMovies()
    }

    private func showHorizontalList() {
        errorView.isHidden = true
        horizontalTableView.isHidden = false
        clearFilter()
    }

    private func clearFilter() {
        moviesFiltered = []
        filter = FilterSearch()
        removeFilterButton.isHidden = true
    }

    private func displayEmptyMovie() {
        let searchIcon = UIImage(assets: .searchIcon)
        let configurationError = ErrorConfiguration(image: searchIcon, text: Strings.thereIsNotFavoriteMovie.localizable)
        displayErrorView(configuration: configurationError)
    }

    private func displayErrorView(configuration: ErrorConfiguration = ErrorConfiguration()) {
        horizontalTableView.isHidden = true
        errorView.isHidden = false

        errorView.configuration = configuration
    }

    // MARK: - Fileprivate functions

    @objc fileprivate func didRemoveFilterButtonTapped() {
        filter = FilterSearch(search: filter.search)
        filter(newFilter: filter)
    }
}

extension Selector {
    static let didRemoveFilterButtonTapped = #selector(FavoritesViewController.didRemoveFilterButtonTapped)
}
