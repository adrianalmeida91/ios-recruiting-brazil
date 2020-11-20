//
//  Decodable+Mapper.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

private class Mapper<N> where N: Decodable {
    enum Error: Swift.Error {
        case pathNotFound
    }

    func map(file: String, type: String) throws -> Data {
        let pathFromBundle = Bundle.main.path(forResource: file, ofType: type)
        let pathFromTestBundle = Bundle(for: Mapper.self).path(forResource: file, ofType: type)

        guard let path = pathFromBundle ?? pathFromTestBundle else {
            throw Error.pathNotFound
        }

        let url = URL(fileURLWithPath: path)

        return try Data(contentsOf: url, options: .mappedIfSafe)
    }

    func map(file: String, type: String, decoder: JSONDecoder) throws -> N {
        let data = try map(file: file, type: type)

        return try decoder.decode(N.self, from: data)
    }
}

extension Data {
    init(path: String, type: String = "json") {
        do {
            self = try Mapper<Self>().map(file: path, type: type)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

extension Decodable {
    init(path: String, type: String = "json", decoder: JSONDecoder = JSONDecoder()) {
        do {
            self = try Mapper<Self>().map(file: path, type: type, decoder: decoder)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
