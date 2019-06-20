//
//  SpiderChart.swift
//  test
//
//  Created by Vincent Riviere on 03/02/2018.
//  Copyright © 2018 Vincent Riviere. All rights reserved.
//

import UIKit

public class UIRadarChart: UIView {
    public var data: RadarChartData = RadarChartData(values: [], labels: [])
    public var drawingStyle: DrawingStyle = UIRadarChart.DrawingStyle.lines
    public var animation = false
    public var title: String = ""
    private var height: CGFloat = 0
    private var width: CGFloat = 0
    private var axisSize: CGFloat = 0
    private var centerView: CGPoint = CGPoint(x: 0, y: 0)
    
    public enum DrawingStyle {
        case lines
        case circles
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    private func setupView() {
        let viewSize: CGSize = self.bounds.size
        self.height = viewSize.height
        self.width = viewSize.width
        self.axisSize = 0.8 * max(self.height, self.width) / 2
        self.centerView = CGPoint(x: self.width / 2, y: self.height / 2)
        self.clipsToBounds = true
    }
    
    public func draw() {
        sanityCheck()
        self.layer.addSublayer(self.drawAxisX().getLayer())
        self.layer.addSublayer(self.drawAxisY().getLayer())
        self.layer.addSublayer(self.drawAxisBase())
        self.layer.addSublayer(self.drawAxisLabel())
        self.layer.addSublayer(self.drawTitle())
        if !self.data.valuesIsEmpty() {
            self.layer.addSublayer(self.drawValues().getLayer())
        }
    }
    
    private func sanityCheck() {
        /* Check if the RadarChart view is a square. */
        assert(abs(self.height - self.width) < 10, "[RadarChart] The RadarChart view must be a square.")
        
        /* Check data sanity */
        self.data.sanityCheck()
    }

    private func getPoint(axis: Int, radius: CGFloat) -> CGPoint {
        let angleDegree: Double = Double((90 - axis * 360 / self.data.getLabelsCount()) % 360)
        let angleRad: Double = angleDegree * Double.pi / 180
        let translateX: CGFloat = radius * self.axisSize * CGFloat(cos(angleRad))
        let translateY: CGFloat = radius * self.axisSize * CGFloat(sin(angleRad))
        return self.centerView.applying(CGAffineTransform(translationX: translateX, y: -translateY))
    }
    
    private func drawAxisX() -> Drawing {
        let path: UIBezierPath = UIBezierPath()
        for i in 0...self.data.getLabelsCount() - 1 {
            path.move(to: self.self.centerView)
            path.addLine(to: self.getPoint(axis: i, radius: 1.05))
        }
        return Drawing(path: path, lineWidth: 1, fillColor: UIColor.clear,
                       strokeColor: UIColor.black, animation: self.animation)
    }
    
    private func drawAxisY() -> Drawings {
        let drawings: Drawings = Drawings()
        for i in 1...4 {
            let path: UIBezierPath = UIBezierPath()
            if self.drawingStyle == DrawingStyle.circles {
                let size: CGFloat = self.axisSize * CGFloat(i) / 4
                path.move(to: self.centerView.applying(CGAffineTransform(translationX: size, y: 0)))
                path.addArc(withCenter: self.centerView, radius: size, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
            } else {
                var from: CGPoint = self.getPoint(axis: 0, radius: CGFloat(i) / 4)
                path.move(to: from)
                for index in 1...self.data.getLabelsCount() {
                    let to: CGPoint = self.getPoint(axis: index, radius: CGFloat(i) / 4)
                    path.addLine(to: to)
                    from = to
                }
            }
            drawings.addDrawing(drawing: Drawing(path: path, lineWidth: i == 4 ? 2.0 : 1.0, fillColor: UIColor.clear,
                                                 strokeColor: UIColor.black.withAlphaComponent(0.5), animation: self.animation))
        }
        return drawings
    }
    
    private func drawValues() -> Drawings {
        let drawings: Drawings = Drawings()
        if self.data.getLabelsCount() == 0 {
            return drawings
        }
        for i in 0...self.data.getValuesCount() - 1 {
            let path: UIBezierPath = UIBezierPath()
            let values: RadarChartDataValues = self.data.getValues()[i]
            var from: CGPoint = self.getPoint(axis: 0, radius: CGFloat(values.getValues()[0]) / 100)
            path.move(to: from)
            for index in 1...values.getValuesDim() - 1 {
                let to: CGPoint = self.getPoint(axis: index, radius: CGFloat(values.getValues()[index]) / 100)
                path.addLine(to: to)
                from = to
            }
            path.close()
            drawings.addDrawing(drawing: Drawing(path: path, lineWidth: 2.0, fillColor: values.getFillColor(),
                                                 strokeColor: values.getColor(), animation: self.animation))
        }
        return drawings
    }
    
    private func drawAxisBase() -> CAShapeLayer {
        let layer: CAShapeLayer = CAShapeLayer()
        for i in 1...4 {
            let textLayer = CATextLayer()
            textLayer.fontSize = 10
            var point: CGPoint = self.getPoint(axis: 0, radius: CGFloat(i) / 4)
            point = point.applying(CGAffineTransform(translationX: 0, y: -14))
            textLayer.frame = CGRect(origin: point, size: CGSize(width: 18, height: 12))
            textLayer.alignmentMode = CATextLayerAlignmentMode.center
            textLayer.string = "\(i * 25)"
            textLayer.foregroundColor = UIColor.black.cgColor
            layer.addSublayer(textLayer)
        }
        return layer
    }
    
    private func drawAxisLabel() -> CAShapeLayer {
        let path: UIBezierPath = UIBezierPath()
        let layer: CAShapeLayer = CAShapeLayer()
        for i in 0...self.data.getLabelsCount() - 1 {
            let from: CGPoint = self.getPoint(axis: i, radius: 1.05)
            let indexFraction: Double = Double(i) / Double(self.data.getLabelsCount())
            path.move(to: from)
            let textLayer = CATextLayer()
            textLayer.fontSize = 10
            textLayer.string = self.data.getLabels()[i]
            textLayer.foregroundColor = UIColor.black.cgColor
            textLayer.backgroundColor = UIColor.clear.cgColor
            if (indexFraction != 0 && indexFraction < 0.5) {
                var to: CGPoint = from.applying(CGAffineTransform(translationX: 10, y: 0))
                path.addLine(to: to)
                to = to.applying(CGAffineTransform(translationX: 2, y: -7))
                textLayer.frame = CGRect(origin: to, size: CGSize(width: 100, height: 12))
                textLayer.alignmentMode = CATextLayerAlignmentMode.left
                layer.addSublayer(textLayer)
            } else {
                var to: CGPoint = from.applying(CGAffineTransform(translationX: -10, y: 0))
                path.addLine(to: to)
                to = to.applying(CGAffineTransform(translationX: -102, y: -7))
                textLayer.frame = CGRect(origin: to, size: CGSize(width: 100, height: 12))
                textLayer.alignmentMode = CATextLayerAlignmentMode.right
                layer.addSublayer(textLayer)
            }
        }
        let drawing: Drawing = Drawing(path: path, lineWidth: 1.0, fillColor: UIColor.clear, strokeColor: UIColor.black, animation: true)
        layer.addSublayer(drawing.getLayer())
        return layer
    }
    
    private func drawTitle() -> CAShapeLayer {
        return CAShapeLayer()
    }
}
