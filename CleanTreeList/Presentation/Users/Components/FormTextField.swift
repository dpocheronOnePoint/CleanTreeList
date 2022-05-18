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
    
    var editingChangedAction: (() -> Void)?
    var unEditingChangedAction: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            TextField(placeholder, text: $text, onEditingChanged: { (editingChanged) in
                
                if(editingChanged) {
                    if( editingChangedAction != nil){
                        editingChangedAction!()
                    }
                }else{
                    if( unEditingChangedAction != nil){
                        unEditingChangedAction!()
                    }
                }
            })
            .underlineTextField()
            .font(.system(.footnote))
            .padding(.horizontal)
            Text("Test")
                .font(.system(.footnote))
                .foregroundColor(.red)
                .padding(.leading, 25)
        } // VSTACK
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
