//
//  UIImage+Extensions.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 22/05/2021.
//

import UIKit

extension UIImage {
    static let plusImage = UIImage(systemName: "plus.circle.fill")
    
    func sameAspectRatio(newHeight: CGFloat) -> UIImage {
        let scale = newHeight / size.height
        let newWidth = size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        return UIGraphicsImageRenderer(size: newSize).image { _ in
            self.draw(in: .init(origin: .zero, size: newSize))
        }
    }
}
