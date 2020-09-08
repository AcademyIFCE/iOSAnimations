//
//  Image.swift
//  ImageCutter
//
//  Created by Yuri on 08/09/20.
//  Copyright © 2020 academy.ifce. All rights reserved.
//

import UIKit

struct ImageData: Decodable {
    var name: String
    var x: CGFloat
    var y: CGFloat
    var width: CGFloat
    var height: CGFloat
    var rect: CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    static func getImages() -> [ImageData] {
        guard let json = Bundle.main.url(forResource: "sprites", withExtension: ".json"), let data = try? Data(contentsOf: json) else { return [] }
        
        return try! JSONDecoder().decode([ImageData].self, from: data)
    }
}
