//
//  Drawings.swift
//  Charts Testing App
//
//  Created by Vincent Rivière on 01/06/2019.
//  Copyright © 2019 Vincent Rivière. All rights reserved.
//

import UIKit

class Drawings {
    private var drawings: [Drawing]
    
    init() {
        self.drawings = []
    }
    
    public func addDrawing(drawing: Drawing) { self.drawings.append(drawing) }
    
    public func getLayer() -> CALayer {
        let finalLayer: CAShapeLayer = CAShapeLayer()
        for drawing in self.drawings {
            let shapeLayer: CAShapeLayer = CAShapeLayer()
            if drawing.animation {
                let drawAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
                drawAnimation.fromValue = 0
                drawAnimation.toValue = 1
                drawAnimation.duration = 0.8
                shapeLayer.add(drawAnimation, forKey: "animation")
            }
            shapeLayer.strokeColor = drawing.strokeColor
            shapeLayer.fillColor = drawing.fillColor
            shapeLayer.lineWidth = drawing.lineWidth
            shapeLayer.path = drawing.path.cgPath
            finalLayer.addSublayer(shapeLayer)
        }
        return finalLayer
    }
}
