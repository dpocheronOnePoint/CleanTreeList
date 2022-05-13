//
//  UnderlineTextField.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import SwiftUI

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(.accentColor)
            .padding(10)
    }
}

