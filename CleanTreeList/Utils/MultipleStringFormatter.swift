//
//  MultipleStringFormatter.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import Foundation

func formattedMultipleStringWithInt(localizeString: String, integer: Int16) -> String {
    let formatString : String = NSLocalizedString(localizeString, comment: "")
    let resultString : String = String.localizedStringWithFormat(formatString, integer)
    return resultString;
}

