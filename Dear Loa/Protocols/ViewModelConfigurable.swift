//
//  ViewModelConfigurable.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation

protocol ViewModelConfigurable {
    
    associatedtype ViewModelType
    
    var viewModel: ViewModelType? { get }
    
    func configureFrom(_ viewModel: ViewModelType)
}
