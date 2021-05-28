//
//  UIView+Extensions.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 28/05/2021.
//

import UIKit

enum Edge {
    case right
    case left
    case top
    case bottom
}

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func pinToSuperviewEdges(_ edges: [Edge] = [.top, .bottom, .left, .right], constant: CGFloat = 0) {
        guard let superview = superview else { return }
        edges.forEach {
            switch $0 {
            case .right:
                trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant).isActive = true
            case .left:
                leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
            case .top:
                topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
            }
        }
    }
}
