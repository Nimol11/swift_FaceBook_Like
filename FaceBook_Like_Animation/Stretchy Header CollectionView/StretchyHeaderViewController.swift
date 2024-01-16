//
//  StretchyHeaderViewController.swift
//  FaceBook_Like_Animation
//
//  Created by Nimol on 15/1/24.
//

import UIKit

class StretchyHeaderViewController: UIViewController {
 
    // Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // variable
    let padding: CGFloat = 16
    var headerView: HeaderView?
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        getProduct()
    }
    
    private func configCollectionView() {
        collectionView.register(HeaderView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        }
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    private func getProduct() {
        let url = "https://api.escuelajs.co/api/v1/products"
        NetworkLayer.share.fetchData(url: url) { (product: [ProductModel]) in
            dump(product)
        }
    }

    
}
extension StretchyHeaderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.identifier, for: indexPath) as? HeaderView
        
        return headerView!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .cyan
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width - 2 * padding , height: 50 )
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        if contentOffsetY > 0 {
            return
        }
        headerView?.animator?.fractionComplete = abs(contentOffsetY) / 100
    }
}
