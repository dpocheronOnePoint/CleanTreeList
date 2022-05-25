//
//  Tree.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

struct Tree: Codable, Identifiable {
    var id = UUID()
    let name, species, address2: String?
    let address: String
    let height, circumference: Int16
}

extension Record: DataToDomain {
    func ToDomain() -> Tree {
        Tree(name: name,
             species: species,
             address2: address2,
             address: address,
             height: height,
             circumference: circumference
        )
    }
}

extension CDTree: DataToDomain {
    func ToDomain() -> Tree {
        Tree(
            name: name,
            species: species,
            address2: address2,
            address: address,
            height: height,
            circumference: circumference
        )
    }
}

extension RealmTree: DataToDomain {
    func ToDomain() -> Tree {
        Tree(
            name: name,
            species: species,
            address2: address2,
            address: address,
            height: height,
            circumference: circumference
        )
    }
}

extension Tree {
    static let treeSampleData = Tree(name: "Erable", species: "pseudoplatanus", address2: "", address: "DAVOUT (147-149)", height: 8, circumference: 100)
}
