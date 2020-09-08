//
//  ImageCutterTool.swift
//  ImageCutter
//
//  Created by Yuri on 08/09/20.
//  Copyright © 2020 academy.ifce. All rights reserved.
//

import UIKit

class ImageCutterTool {
    var imagePath: String
    var image: UIImage?
    var imagesData: [ImageData]
    
    init(imagePath: String = "spritesheet", imagesData: [ImageData] = ImageData.getImages()) {
        self.imagePath = imagePath
        self.imagesData = imagesData
    }
    
    private func loadImageFromURL() {
        guard let imagePath = Bundle.main.url(forResource: "spritesheet", withExtension: ".png"), let data = try? Data(contentsOf: imagePath) else {
            fatalError("There is no image like that on the bundle")
        }
        
        image = UIImage(data: data)
    }
    
    private func cropImage(image: UIImage, crop: CGRect) -> UIImage {
        guard let cgImage = image.cgImage,
            let cropped = cgImage.cropping(to: crop) else { fatalError("Something could not be cut")}
        return UIImage(cgImage: cropped)
    }
    
    func cuttedImages() -> [Character] {
        loadImageFromURL()
        guard let originalImage = image else { return [] }
        let images = imagesData
            .map { Character(image: cropImage(image: originalImage, crop: $0.rect))}
        
        return images
    }
}
