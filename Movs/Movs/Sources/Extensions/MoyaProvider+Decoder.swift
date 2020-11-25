//
//  MoyaProvider+Decoder.swift
//  Movs
//
//  Created by Adrian Almeida on 27/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Moya

extension MoyaProvider {
    func request<T: Codable>(_ target: Target, completion: @escaping (Result<T, Error>) -> Void) {
        request(target) { (result: Result<Response, MoyaError>) in
            switch result {
            case .success(let response):
                do {
                    completion(.success(try response.map(T.self)))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func requestVoid(_ target: Target, completion: @escaping (Result<Void, Error>) -> Void) {
        request(target) { result in
            switch result {
            case .success:
                return completion(.success(()))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
}
