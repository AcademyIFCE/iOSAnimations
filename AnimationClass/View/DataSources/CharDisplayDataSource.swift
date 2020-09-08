//
//  CharDisplayDataSource.swift
//  AnimationClass
//
//  Created by Yuri on 08/09/20.
//  Copyright © 2020 academy.ifce. All rights reserved.
//

import UIKit

class CharactersDataSource: NSObject, UICollectionViewDataSource {
    
    var characters: [Character]
    
    init(characters: [Character] = []) {
        self.characters = characters
        super.init()
    }
    
    func canAddCharacter(character: Character) -> Bool {
        return !characters.contains(character)
    }

    func addNew(character: Character) {
        if !characters.contains(character) {
            characters.append(character)
        }
    }
    
    func remove(character: Character) {
        characters.removeAll(where: {$0.id == character.id})
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CollectionCell else { fatalError("Wrong cell") }
        cell.charPortrait.image = characters[indexPath.row].image
        
        return cell
    }
}
