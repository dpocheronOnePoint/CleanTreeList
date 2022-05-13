//
//  BindingInverter.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import SwiftUI

extension Binding where Value == Bool {
    var not: Binding<Value> {
        Binding<Value>(
            get: { !self.wrappedValue },
            set: { self.wrappedValue = !$0 }
        )
    }
}
