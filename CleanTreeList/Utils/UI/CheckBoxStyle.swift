//
//  CheckBoxStyle.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import SwiftUI

struct CheckBoxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .foregroundColor(configuration.isOn ? .accentColor : .primary)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                    feedback.notificationOccurred(.success)
                }
            
            configuration.label
        } //: HSTACK
    }
}

struct CheckBoxStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("Placeholder label", isOn: .constant(true))
            .toggleStyle(CheckBoxStyle())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

