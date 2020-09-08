//
//  ViewExtension.swift
//  AnimationClass
//
//  Created by Yuri on 08/09/20.
//  Copyright © 2020 academy.ifce. All rights reserved.
//

import UIKit

extension UIView {
    func placeAndCenterInView(view: UIView, paddig: UIEdgeInsets = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: paddig.top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -paddig.bottom),
            self.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: paddig.left),
            self.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -paddig.right)
        ])
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        self.layer.mask = mask
    }
}
