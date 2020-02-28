//
//  ImageViewer.swift
//  SahibHelper
//
//  Created by sahib hussain on 25/02/20.
//

import UIKit
import SDWebImage

public class ImageViewer: UIViewController {
    
    @IBOutlet public var baseImageView: UIImageView!
    @IBOutlet public var blurView: UIVisualEffectView!
    @IBOutlet public var collectionView: UICollectionView!
    @IBOutlet public var closeButton: UIButton!
    
    public var imageUrls: [String] = []
    private let designHelper = DesignHelper.shared
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        designHelper.setButtonFontAwesome(btn: closeButton, size: 25, style: .solid, icon: .times)
        closeButton.addTarget(self, action: #selector(closeButtonClicked(_:)), for: .touchUpInside)
        
        let cvc = UINib(nibName: "ImageViewerCVC", bundle: nil)
        collectionView.register(cvc, forCellWithReuseIdentifier: "cell")
        
    }
    
    @objc public func closeButtonClicked(_ button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension ImageViewer: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageViewerCVC
        let item = imageUrls[indexPath.item]
        
        if let url = URL(string: item) {
            cell.mainImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.mainImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "loading"), options: .refreshCached, completed: nil)
        }else {
            cell.mainImageView.image = UIImage(named: "incorrect")
            designHelper.toast(message: "Image Url not is incorrect", position: .center, duration: 2.0, view: self.view)
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let items = collectionView.visibleCells
        let item = items.first
        
        print(item ?? "nil")
        
    }
    
}
