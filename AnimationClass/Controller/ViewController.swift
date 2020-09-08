//
//  ViewController.swift
//  AnimationClass
//
//  Created by Yuri on 08/09/20.
//  Copyright © 2020 academy.ifce. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let charCollection: CharactersCollectionView = {
        let characters = ImageCutterTool(imagePath: "spritessheet", imagesData: ImageData.getImages()).cuttedImages()
        let dataSource = CharactersDataSource(characters: characters)
        return CharactersCollectionView(dataSource: dataSource)
    }()
    
    let favoriteCollection: FavoriteCollectionView = {
        let dataSource = CharactersDataSource()
        return FavoriteCollectionView(dataSource: dataSource)
    }()
    
    
    var favoriteHeightConstraint = NSLayoutConstraint()
    
    var isFavoriteOpen: Bool = false
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("No Storyboards")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Favorites"
        charCollection.didSelect = handleFavorite(character:)
        favoriteCollection.didSelect = handleUnfavorite(character:)
    }
    
    private func setupLayout() {
        charCollection.translatesAutoresizingMaskIntoConstraints = false
        favoriteCollection.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(favoriteCollection)
        self.view.addSubview(charCollection)
        
        favoriteHeightConstraint = favoriteCollection.heightAnchor.constraint(equalToConstant: 0)
        favoriteHeightConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            favoriteCollection.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            favoriteCollection.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            favoriteCollection.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            favoriteHeightConstraint,
            
            charCollection.topAnchor.constraint(equalTo: favoriteCollection.bottomAnchor),
            charCollection.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            charCollection.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            charCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    
    private func openDrawer(completion: (() -> ())?) {
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
            self.view.layoutIfNeeded()
        }, completion: { _ in completion?() })
    }
    
    private func handleFavorite(character: Character) {
        openDrawer {
            self.favoriteCollection.addNewCharacter(character: character)
        }
    }
    
    private func handleUnfavorite(character: Character) {
        self.favoriteCollection.removeCharacter(character: character)
        openDrawer(completion: nil)
    }
}

