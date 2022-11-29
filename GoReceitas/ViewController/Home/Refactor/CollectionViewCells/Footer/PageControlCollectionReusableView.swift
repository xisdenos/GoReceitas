//
//  PageControlCollectionReusableView.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 28/11/22.
//

import UIKit

class PageControlCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    static let identifier: String = String(describing: PageControlCollectionReusableView.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        print("page contrl")
    }
}
