//
//  IsHiddenBinding.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 19/05/2022.
//

import SwiftUI
extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = true) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
