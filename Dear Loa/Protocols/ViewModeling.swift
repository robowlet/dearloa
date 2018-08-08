//
//  ViewModeling.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation

protocol ViewModeling {
    
    associatedtype ViewModelType: ViewModel
    
    var viewModel: ViewModelType { get }
}

extension ViewModeling where ViewModelType.ModelType == Self {
    
    var viewModel: ViewModelType {
        return ViewModelType(from: self)
    }
}

extension Array where Element: ViewModeling {
    
    var viewModels: [Element.ViewModelType] {
        return self.map { $0.viewModel }
    }
}
