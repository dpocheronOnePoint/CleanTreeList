//
//  Regex.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 18/05/2022.
//

import Foundation

struct Regex {
    static let selfMatchRule = "SELF MATCHES %@"
    static let emailRegex = "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$"
}
