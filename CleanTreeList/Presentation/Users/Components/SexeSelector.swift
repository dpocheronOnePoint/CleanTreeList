//
//  SexeSelector.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import SwiftUI

struct SexeSelector: View {
    @Binding var sexeSelection: Bool
    let sexeTitle: String
    
    var body: some View {
        Toggle(isOn: $sexeSelection) {
            Text(sexeTitle)
                .font(.system(.footnote))
                .foregroundColor(Color.secondary)
                .padding(.vertical, 12)
        } //: TOGGLE
        .toggleStyle(SelectorStyle())
    }
}

struct SexeSelector_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State(initialValue: true) var sexeSelection: Bool
        
        var body: some View {
            SexeSelector(sexeSelection: $sexeSelection, sexeTitle: "Femme")
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
