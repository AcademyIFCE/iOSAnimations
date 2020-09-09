//
//  FavoriteCollectionView.swift
//  AnimationClass
//
//  Created by Yuri on 08/09/20.
//  Copyright © 2020 academy.ifce. All rights reserved.
//

import UIKit

class FavoriteCollectionView: CharactersCollectionView {
    override func configureLayout() {
        super.configureLayout()
        guard let layout = charsCollection.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let cellHeight = 59
        let cellWidth = 45
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.scrollDirection = .horizontal
        
        self.backgroundColor = .appOrange
    }
    
    override func setupView() {
        charsCollection.placeAndCenterInView(view: self, paddig: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
    }
    
    func addNewCharacter(character: Character) {
        if dataSource.canAddCharacter(character: character) {
            let lastIndex = IndexPath(row: dataSource.characters.count, section: 0)
            charsCollection.performBatchUpdates({
                dataSource.addNew(character: character)
                charsCollection.insertItems(at: [lastIndex])
            }, completion: {[weak self] _ in
                self?.charsCollection.scrollToItem(at: lastIndex, at: .centeredHorizontally, animated: true)
            })
        }
    }
    
    func removeCharacter(character: Character) {
        charsCollection.performBatchUpdates({
            guard let index = dataSource.characters.firstIndex(of: character) else { return }
            dataSource.remove(character: character)
            let removeIndex = IndexPath(row: index, section: 0)
            charsCollection.deleteItems(at: [removeIndex])
        })
    }
    
    func getNextItemPosition() -> CGPoint {
        //First we need to get the last visible cell
        guard let indexPath = charsCollection.indexPathsForVisibleItems.max(by: {$0.row < $1.row }), let cell = charsCollection.cellForItem(at: indexPath) else { return charsCollection.frame.origin }
        let nextVisibleFrame = CGPoint(x: cell.frame.origin.x + 20 + 45, y: cell.frame.origin.y)
        return nextVisibleFrame
    }
}
