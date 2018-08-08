//
//  String+HTML.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import UIKit

extension String {
    
    func interpretAsHTML(font: String, size: CGFloat) -> NSAttributedString? {
        
        var style = ""
        style += "<style>* { "
        style += "font-family: \"\(font)\" !important;"
        style += "font-size: \(size) !important;"
        style += "}</style>"
        
        let styledHTML = self.trimmingCharacters(in: CharacterSet.newlines).appending(style)
        let htmlData   = styledHTML.data(using: .utf8)!
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            NSAttributedString.DocumentReadingOptionKey.documentType      : NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey.characterEncoding : String.Encoding.utf8.rawValue,
            ]
        
        return try? NSAttributedString(data: htmlData, options: options, documentAttributes: nil)
    }
}
