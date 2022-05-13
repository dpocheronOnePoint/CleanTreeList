//
//  FormTextField.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import SwiftUI

struct FormTextField: View {
    
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .underlineTextField()
            .font(.system(.footnote))
            .padding(.horizontal)
    }
}

struct FormTextField_Previews: PreviewProvider {
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var code: String

        var body: some View {
            FormTextField(placeholder: "Email", text: $code)
        }
      }
    
    static var previews: some View {
        PreviewWrapper()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
