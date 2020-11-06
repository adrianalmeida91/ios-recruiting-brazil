//
//  MocksHelper.swift
//  MovsTests
//
//  Created by Adrian Almeida on 06/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

final class MocksHelper {
    static func readLocalFile(forName name: String, ofType type: String = "json") -> Data? {
        do {
            if let bundlePath = Bundle(for: MocksHelper.self).path(forResource: name, ofType: type),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error.localizedDescription)
        }

        return nil
    }

    static func parse<T: Decodable>(jsonData: Data) -> T? {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: jsonData)

            return decodedData
        } catch {
            print(error.localizedDescription)
        }

        return nil
    }
}
