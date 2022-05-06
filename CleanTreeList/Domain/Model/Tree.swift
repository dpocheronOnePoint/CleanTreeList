//
//  Tree.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

struct Tree: Codable, Identifiable { //  --> Identifiable is better to display on List
    let name, species, address2: String?
    let address: String
    let height, circumference, id: Int
}

extension Record: DataToDomain {
    func ToDomain() -> Tree {
        Tree(name: name,
             species: species,
             address2: address2,
             address: address,
             height: height,
             circumference: circumference,
             id: id)
    }
}
