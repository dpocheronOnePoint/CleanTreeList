//
//  LocalizeError.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 18/05/2022.
//

import Foundation
import SwiftUI

struct LocalizeError {
    var needDisplayError: Bool
    var errorString: LocalizedStringKey
}

extension LocalizeError {
    static let undisplayError = LocalizeError(needDisplayError: false, errorString: "")
    static let displayError = LocalizeError(needDisplayError: true, errorString: "Email incorrect")
}
