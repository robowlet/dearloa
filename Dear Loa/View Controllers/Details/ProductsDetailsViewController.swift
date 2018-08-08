//
//  ProductsDetailsViewController.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import UIKit

private enum CellKind: Int {
    case header
    case details
}

class ProductDetailsViewController: ParallaxViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var product: ProductViewModel!
    
    private var imageViewController: ImageViewController!
    
    // ----------------------------------
    //  MARK: - Segue -
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier! {
        case "ImageViewController":
            self.imageViewController = segue.destination as! ImageViewController
        default:
            break
        }
    }
    
    // ----------------------------------
    //  MARK: - View Loading -
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /////
        title = product.title
        navigationController?.navigationBar.tintColor = .white
        
        /////
        
        self.registerTableCells()
        
        self.configureHeader()
        self.configureImageController()
    }
    
    private func registerTableCells() {
        self.tableView.register(ProductHeaderCell.self)
        self.tableView.register(ProductDetailsCell.self)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
    }
    
    private func configureHeader() {
        self.headerHeight = self.view.bounds.width * 0.5625 // 16:9 ratio
    }
    
    private func configureImageController() {
        
        self.imageViewController.activePageIndicatorColor   = self.view.tintColor.withAlphaComponent(0.8)
        self.imageViewController.inactivePageIndicatorColor = self.view.tintColor.withAlphaComponent(0.3)
        
        self.imageViewController.imageItems = self.product.images.items.map {
            ImageItem.url($0.url, placeholder: nil)
        }
    }
}

// ----------------------------------
//  MARK: - Actions -
//
extension ProductDetailsViewController {
    
    @IBAction func cartAction(_ sender: Any) {
        let cartController: CartNavigationController = self.storyboard!.instantiateViewController()
        self.navigationController!.present(cartController, animated: true, completion: nil)
    }
}

// ----------------------------------
//  MARK: - ProductHeaderDelegate -
//
extension ProductDetailsViewController: ProductHeaderDelegate {
    
    func productHeader(_ cell: ProductHeaderCell, didAddToCart sender: Any) {
        let item = CartItem(product: self.product, variant: self.product.variants.items[0])
        CartController.shared.add(item)
    }
}

// ----------------------------------
//  MARK: - UITableViewDataSource -
//
extension ProductDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch CellKind(rawValue: indexPath.row)! {
        case .header:
            let cell = tableView.deque(ProductHeaderCell.self, configureFrom: self.product, at: indexPath)
            cell.delegate = self
            return cell
            
        case .details:
            return tableView.deque(ProductDetailsCell.self, configureFrom: self.product, at: indexPath)
        }
    }
}

// ----------------------------------
//  MARK: - UITableViewDelegate -
//
extension ProductDetailsViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateParallax()
    }
}

// ----------------------------------
//  MARK: - Convenience -
//
private extension UITableView {
    
    func register<C>(_ cellType: C.Type) where C: UITableViewCell {
        let name = String(describing: cellType.self)
        self.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
    
    func deque<M, C>(_ cellType: C.Type, configureFrom viewModel: M, at indexPath: IndexPath) -> C where M: ViewModel, C: UITableViewCell, C: ViewModelConfigurable, C.ViewModelType == M  {
        let name = String(describing: cellType.self)
        let cell = self.dequeueReusableCell(withIdentifier: name, for: indexPath) as! C
        cell.configureFrom(viewModel)
        return cell
    }
}
