//
//  HideKeyBoard.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 19/05/2022.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
