//
//  ImageViewController.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import UIKit

protocol ImageControllerDelegate: class {
    func imageController(_ imageController: ImageViewController, didSelectImage image: UIImage?, at index: Int)
}

class ImageViewController: UIViewController {
    
    weak var delegate: ImageControllerDelegate?
    
    var imageItems: [ImageItem] = [] {
        didSet {
            self.selectedIndex = 0
            
            self.resetCollectionView()
            self.updateCollectionView()
            self.updatePageControl()
        }
    }
    
    var activePageIndicatorColor: UIColor? {
        get {
            return self.pageControl.currentPageIndicatorTintColor
        }
        set {
            self.pageControl.currentPageIndicatorTintColor = newValue
        }
    }
    
    var inactivePageIndicatorColor: UIColor? {
        get {
            return self.pageControl.pageIndicatorTintColor
        }
        set {
            self.pageControl.pageIndicatorTintColor = newValue
        }
    }
    
    private(set) var selectedIndex: Int = 0 {
        didSet {
            self.pageControl.currentPage = self.selectedIndex
        }
    }
    
    // ----------------------------------
    //  MARK: - View Load -
    //
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.pageControl)
        
        self.collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
    }
    
    private lazy var collectionView: UICollectionView = {
        
        let layout                     = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing      = 0.0
        layout.sectionInset            = .zero
        layout.scrollDirection         = .horizontal
        
        let collectionView             = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate        = self
        collectionView.dataSource      = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator   = false
        
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        
        let pageControl                           = UIPageControl()
        pageControl.pageIndicatorTintColor        = UIColor(white: 0.5, alpha: 0.4)
        pageControl.currentPageIndicatorTintColor = UIColor(white: 0.5, alpha: 0.8)
        
        return pageControl
    }()
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { context in
            self.scrollToSelectedIndex()
        }, completion: nil)
    }
    
    // ----------------------------------
    //  MARK: - Layout -
    //
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.layoutCollectionView()
        self.layoutPageControl()
    }
    
    private func layoutCollectionView() {
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView.frame = self.view.bounds
    }
    
    private func layoutPageControl() {
        var frame              = self.pageControl.frame
        frame.origin.y         = self.view.bounds.height - frame.height - 10.0 // align to bottom with 10 point spacing
        frame.origin.x         = (self.view.bounds.width - frame.width) * 0.5 // center horizontally
        self.pageControl.frame = frame
    }
    
    private func scrollToSelectedIndex() {
        var offset                        = self.collectionView.contentOffset
        offset.x                          = self.collectionView.bounds.width * CGFloat(self.selectedIndex)
        self.collectionView.contentOffset = offset
    }
    
    // ----------------------------------
    //  MARK: - Update -
    //
    private func resetCollectionView() {
        self.collectionView.contentOffset = .zero
    }
    
    private func updateCollectionView() {
        self.collectionView.reloadData()
    }
    
    private func updatePageControl() {
        self.pageControl.numberOfPages = self.imageItems.count
    }
    
    // ----------------------------------
    //  MARK: - UIScrollViewDelegate -
    //
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        /* -----------------------------------------
         ** Only respond to user-initiated scrolling
         ** events. Other may be a result of device
         ** rotation, etc.
         */
        if scrollView.isDragging {
            self.selectedIndex = Int((scrollView.contentOffset.x + (scrollView.bounds.width * 0.5)) / scrollView.bounds.width)
        }
    }
}

// ---------------------------------------
//  MARK: - UICollectionViewDataSource -
//
extension ImageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let item = self.imageItems[indexPath.item]
        
        switch item {
        case .bitmap(let image):
            cell.setImage(image)
            
        case .url(let url, let placeholder):
            cell.setImage(loadingFrom: url, placeholder: placeholder)
        }
        
        return cell
    }
}

// ------------------------------------------------
//  MARK: - UICollectionViewDelegateFlowLayout -
//
extension ImageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

// ---------------------------------------
//  MARK: - UICollectionViewDelegate -
//
extension ImageViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
        self.delegate?.imageController(self, didSelectImage: cell.loadedImage, at: indexPath.item)
    }
}

// ----------------------------------
//  MARK: - ImageItems -
//
enum ImageItem {
    case bitmap(UIImage)
    case url(URL, placeholder: UIImage?)
}

// ----------------------------------
//  MARK: - ImageCell -
//
private final class ImageCell: UICollectionViewCell {
    
    var loadedImage: UIImage? {
        return self.imageView.image
    }
    
    private lazy var imageView: UIImageView = {
        let imageView           = UIImageView(frame: self.bounds)
        imageView.contentMode   = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // ----------------------------------
    //  MARK: - Init -
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initialize()
    }
    
    private func initialize() {
        self.contentView.addSubview(self.imageView)
    }
    
    // ----------------------------------
    //  MARK: - Layout -
    //
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = self.bounds
    }
    
    // ----------------------------------
    //  MARK: - Setters -
    //
    func setImage(loadingFrom url: URL, placeholder: UIImage? = nil) {
        self.imageView.setImageFrom(url, placeholder: placeholder)
    }
    
    func setImage(_ image: UIImage) {
        self.imageView.image = image
    }
}
