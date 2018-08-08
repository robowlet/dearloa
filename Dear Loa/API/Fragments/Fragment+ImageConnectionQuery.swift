//
//  Fragment+ImageConnectionQuery.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/30/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation
import MobileBuySDK

extension Storefront.ImageConnectionQuery {
    
    @discardableResult
    func fragmentForStandardProductImage() -> Storefront.ImageConnectionQuery { return self
        .pageInfo { $0
            .hasNextPage()
        }
        .edges { $0
            .cursor()
            .node { $0
                .transformedSrc()
            }
        }
    }
}
