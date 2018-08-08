//
//  Fragment+ProductConnectionQuery.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/30/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation

import MobileBuySDK

extension Storefront.ProductConnectionQuery {
    
    @discardableResult
    func fragmentForStandardProduct() -> Storefront.ProductConnectionQuery { return self
        .pageInfo { $0
            .hasNextPage()
        }
        .edges { $0
            .cursor()
            .node { $0
                .id()
                .title()
                .descriptionHtml()
                .variants(first: 250) { $0
                    .fragmentForStandardVariant()
                }
                .images(first: 250, maxWidth: ClientQuery.maxImageDimension, maxHeight: ClientQuery.maxImageDimension) { $0
                    .fragmentForStandardProductImage()
                }
            }
        }
}
}
