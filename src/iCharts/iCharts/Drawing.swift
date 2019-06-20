//
//  Drawing.swift
//  Charts Testing App
//
//  Created by Vincent Rivière on 01/06/2019.
//  Copyright © 2019 Vincent Rivière. All rights reserved.
//

import UIKit

class Drawing {
    public var path: UIBezierPath
    public var lineWidth: CGFloat
    public var fillColor: CGColor
    public var strokeColor: CGColor
    public var animation: Bool
    
    init(path: UIBezierPath, lineWidth: CGFloat, fillColor: UIColor, strokeColor: UIColor, animation: Bool) {
        self.path = path
        self.lineWidth = lineWidth
        self.fillColor = fillColor.cgColor
        self.strokeColor = strokeColor.cgColor
        self.animation = animation
    }
    
    public func getLayer() -> CALayer {
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        if self.animation {
            let drawAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            drawAnimation.fromValue = 0
            drawAnimation.toValue = 1
            drawAnimation.duration = 0.8
            shapeLayer.add(drawAnimation, forKey: "animation")
        }
        shapeLayer.strokeColor = self.strokeColor
        shapeLayer.fillColor = self.fillColor
        shapeLayer.lineWidth = self.lineWidth
        shapeLayer.path = self.path.cgPath
        return shapeLayer
    }
}
