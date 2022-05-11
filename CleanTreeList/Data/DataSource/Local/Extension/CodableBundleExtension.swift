//
//  CodableBundleExtension.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 06/05/2022.
//

import Foundation

// MARK: - JSON decode from bundle
extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) throws -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            throw JSONDecodeError.locatingError
        }
        
        guard let data = try? Data(contentsOf: url) else {
            throw JSONDecodeError.loadingError
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            throw JSONDecodeError.decodingError
        }
        
        return loaded
    }
}
