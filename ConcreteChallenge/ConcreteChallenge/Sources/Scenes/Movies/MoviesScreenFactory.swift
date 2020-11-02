//
//  MoviesScreenFactory.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 23/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit
import Moya

enum MoviesScreenFactory {
    static func make(delegate: MoviesViewControllerDelegate) -> UIViewController {
        let realmProvider = MovieRealmDbService()
        let realmWorker = RealmWorker(provider: realmProvider)

        let moyaProviderStubClosure = MoyaProvider<MovieDbAPI>.neverStub
        let moyaProvider = MoyaProvider<MovieDbAPI>(stubClosure: moyaProviderStubClosure, plugins: [NetworkLoggerPlugin()])
        let moyaWorker = MoyaWorker(provider: moyaProvider)

        let presenter = MoviesPresenter()

        let interactor = MoviesInteractor(realmWorker: realmWorker, moyaWorker: moyaWorker, presenter: presenter)

        let moviesViewController = MoviesViewController(interactor: interactor)
        moviesViewController.delegate = delegate
        presenter.viewController = moviesViewController

        return moviesViewController
    }
}
