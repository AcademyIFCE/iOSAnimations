//
//  MainView.swift
//  AnimationClass
//
//  Created by Yuri on 08/09/20.
//  Copyright © 2020 academy.ifce. All rights reserved.
//

import UIKit

class MainView: UIView {
    private let charCollection: CharactersCollectionView = {
        let characters = ImageCutterTool(imagePath: "spritessheet", imagesData: ImageData.getImages()).cuttedImages()
        let dataSource = CharactersDataSource(characters: characters)
        return CharactersCollectionView(dataSource: dataSource)
    }()
    
    private let favoriteCollection: FavoriteCollectionView = {
        let dataSource = CharactersDataSource()
        return FavoriteCollectionView(dataSource: dataSource)
    }()
    
    private var favoriteHeightConstraint = NSLayoutConstraint()
    
    private var isFavoriteOpen: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLayout()
        charCollection.didSelect = handleFavorite(character:position:)
        favoriteCollection.didSelect = handleUnfavorite(character:position:)
    }
    
    private func setupLayout() {
        charCollection.translatesAutoresizingMaskIntoConstraints = false
        favoriteCollection.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(favoriteCollection)
        self.addSubview(charCollection)
        
        favoriteHeightConstraint = favoriteCollection.heightAnchor.constraint(equalToConstant: 0)
        favoriteHeightConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            favoriteCollection.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            favoriteCollection.leftAnchor.constraint(equalTo: self.leftAnchor),
            favoriteCollection.rightAnchor.constraint(equalTo: self.rightAnchor),
            favoriteHeightConstraint,
            
            charCollection.topAnchor.constraint(equalTo: favoriteCollection.bottomAnchor),
            charCollection.leftAnchor.constraint(equalTo: self.leftAnchor),
            charCollection.rightAnchor.constraint(equalTo: self.rightAnchor),
            charCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func openDrawer(completion: (() -> ())?) {
        if !isFavoriteOpen && favoriteCollection.dataSource.characters.count >= 0 {
            favoriteHeightConstraint.constant = 83
            isFavoriteOpen = true
            animateDrawer(open: isFavoriteOpen, completion: completion)
        } else if favoriteCollection.dataSource.characters.count == 0 {
            favoriteHeightConstraint.constant = 0
            isFavoriteOpen = false
            animateDrawer(open: isFavoriteOpen, completion: completion)
        } else {
            completion?()
        }
    }
    
    private func animateDrawer(open: Bool, completion: (() -> ())? ) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            self.layoutIfNeeded()
        }, completion: { _ in completion?() })
    }
    
    private func animateAddition(character: Character, position: CGRect, completion: (()->())?) {
        //        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn], animations: {
        //            image.transform = CGAffineTransform(scaleX: 2, y: 2)
        //                .concatenating(CGAffineTransform(translationX: 0, y: -200))
        //        }) { _ in
        //            self.openDrawer {
        //                self.favoriteCollection.addNewCharacter(character: character)
        //                image.transform = .identity
        //                image.removeFromSuperview()
        //            }
        //        }
        
        // We will create a duplication that we will use for animations
        let image = UIImageView(frame: position)
        image.image = character.image
        self.addSubview(image)
        
        //Several modifications will occur simultaneously
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.7) {
                image.transform = CGAffineTransform(scaleX: 2, y: 2)
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.7) {
                var finalFrame = self.favoriteCollection.getNextItemPosition()
                finalFrame.y += 88
                image.frame.origin = finalFrame
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.7) {
                self.openDrawer(completion: nil)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3) {
                image.frame.size = CGSize(width: 45, height: 59)
            }
        }, completion: { _ in
            //At the end we have to remove the duplication and call the collection view update
            image.removeFromSuperview()
            completion?()
        })
    }
    
    private func handleFavorite(character: Character, position: CGRect) {
        if favoriteCollection.dataSource.canAddCharacter(character: character) {
            animateAddition(character: character, position: position) {
                self.favoriteCollection.addNewCharacter(character: character)
            }
        }
        
    }
    
    private func handleUnfavorite(character: Character, position: CGRect) {
        self.favoriteCollection.removeCharacter(character: character)
        openDrawer(completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
