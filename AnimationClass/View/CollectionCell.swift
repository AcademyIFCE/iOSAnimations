//
//  CollectionCell.swift
//  AnimationClass
//
//  Created by Yuri on 08/09/20.
//  Copyright © 2020 academy.ifce. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    let charPortrait: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    required init?(coder: NSCoder) {
        fatalError("No Interface Builders to be found")
    }
    
    override func prepareForReuse() {
        charPortrait.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        charPortrait.placeAndCenterInView(view: self)
    }
}
