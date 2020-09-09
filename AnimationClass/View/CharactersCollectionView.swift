//
//  CharactersCollectionView.swift
//  AnimationClass
//
//  Created by Yuri on 08/09/20.
//  Copyright © 2020 academy.ifce. All rights reserved.
//

import UIKit

class CharactersCollectionView: UIView, UICollectionViewDelegate {
    
    let charsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.register(CollectionCell.self, forCellWithReuseIdentifier: "collectionCell")
        collection.backgroundColor = .clear
        return collection
    }()
    
    let dataSource: CharactersDataSource
    var didSelect: (Character, CGRect) -> () = {_, _ in }
    
    init(dataSource: CharactersDataSource) {
        self.dataSource = dataSource
        
        super.init(frame: .zero)
        
        charsCollection.dataSource = dataSource
        charsCollection.delegate = self
        configureLayout()
        setupView()
    }
    
    func setupView() {
        charsCollection.placeAndCenterInView(view: self, paddig: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
    }
    
    func configureLayout() {
        guard let layout = charsCollection.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let cellHeight = 83
        let cellWidth = 63
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.scrollDirection = .vertical
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        //We need to translate our point from the collection to our superview
        let pointInView = collectionView.convert(cell.frame.origin, to: superview)
        
        var partialFrame = cell.frame
        partialFrame.origin = pointInView
        
        didSelect(dataSource.characters[indexPath.row], partialFrame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("No need for it")
    }
}
