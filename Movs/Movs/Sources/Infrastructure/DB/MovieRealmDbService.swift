//
//  MovieRealmDbService.swift
//  Movs
//
//  Created by Adrian Almeida on 31/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import RealmSwift

final class MovieRealmDbService {
    func fetch<T: Object>(_ type: T.Type, completion: @escaping (Result<[T], Error>) -> Void) {
        DispatchQueue.main.async {
            do {
                let realm = try RealmManager.realmInstance()
                let models = Array(realm.objects(T.self))
                completion(.success(models))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func save<T: Object>(model: T, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.async {
            do {
                let realm = try RealmManager.realmInstance()
                try realm.write {
                    realm.add(model)
                    completion(.success(()))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }

    func delete<T: Object>(model: T, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.async {
            do {
                let realm = try RealmManager.realmInstance()
                try realm.write {
                    realm.delete(model)
                    completion(.success(()))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
}
