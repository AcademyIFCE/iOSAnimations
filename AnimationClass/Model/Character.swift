//
//  Character.swift
//  AnimationClass
//
//  Created by Yuri on 08/09/20.
//  Copyright © 2020 academy.ifce. All rights reserved.
//

import UIKit
//Needs to be equatable so we can search easily on the array
struct Character: Equatable {
    var id = UUID()
    var image: UIImage
}
