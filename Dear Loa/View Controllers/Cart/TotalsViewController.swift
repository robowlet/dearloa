//
//  TotalsViewController.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import UIKit
import MobileBuySDK
import PassKit

enum PaymentType {
    case applePay
    case webCheckout
}

protocol TotalsControllerDelegate: class {
    func totalsController(_ totalsController: TotalsViewController, didRequestPaymentWith type: PaymentType)
}

class TotalsViewController: UIViewController {
    
    @IBOutlet private weak var subtotalTitleLabel: UILabel!
    @IBOutlet private weak var subtotalLabel:      UILabel!
    @IBOutlet private weak var buttonStackView:    UIStackView!
    
    weak var delegate: TotalsControllerDelegate?
    
    var itemCount: Int = 0 {
        didSet {
            self.subtotalTitleLabel.text = "\(self.itemCount) Item\(itemCount == 1 ? "" : "s")"
        }
    }
    
    var subtotal: Decimal = 0.0 {
        didSet {
            self.subtotalLabel.text = Currency.stringFrom(self.subtotal)
        }
    }
    
    // ----------------------------------
    //  MARK: - View Loading -
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPurchaseOptions()
    }
    
    override func viewDidLayoutSubviews() {
        view.backgroundColor = UIColor.white.withAlphaComponent(1)
    }
    
    private func loadPurchaseOptions() {
        
        let webCheckout = RoundedButton(type: .system)
        webCheckout.backgroundColor = #colorLiteral(red: 0.7254901961, green: 0.4784313725, blue: 0.5137254902, alpha: 1)
        webCheckout.addTarget(self, action: #selector(webCheckoutAction(_:)), for: .touchUpInside)
        webCheckout.setTitle("Checkout",  for: .normal)
        webCheckout.setTitleColor(.white, for: .normal)
        self.buttonStackView.addArrangedSubview(webCheckout)
        
        if PKPaymentAuthorizationController.canMakePayments() {
            let applePay = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
            applePay.addTarget(self, action: #selector(applePayAction(_:)), for: .touchUpInside)
            self.buttonStackView.addArrangedSubview(applePay)
        }
    }
    
    // ----------------------------------
    //  MARK: - Actions -
    //
    @objc func webCheckoutAction(_ sender: Any) {
        self.delegate?.totalsController(self, didRequestPaymentWith: .webCheckout)
    }
    
    @objc func applePayAction(_ sender: Any) {
        self.delegate?.totalsController(self, didRequestPaymentWith: .applePay)
    }
}
