//
//  LineChart.swift
//  Charts
//
//  Created by Vincent Riviere on 14/03/2018.
//  Copyright © 2018 Vincent Riviere. All rights reserved.
//

import UIKit

class LineChart: UIView
{
  var data: [Int] = [0];
  var color_line: UIColor = .red;
  var color_gradient: UIColor = .orange;
  var max: Int = 0;
  var min: Int = 0;
  var moy: Int = 0;
  var diff: Int = 0;
  var view_size: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0);

    
  override func layoutSubviews()
  {
    view_size = self.bounds;
    trace();
  }
  
  func set(data: [Int], color_line: UIColor, color_gradient: UIColor)
  {
    self.data = data;
    self.color_line = color_line;
    self.color_gradient = color_gradient;
  }
  
  func update_extremum()
  {
    max = data.count > 0 ? data[0] : 0;
    min = data.count > 0 ? data[0] : 0;
    for i in 0...data.count - 1
    {
      if (data[i] < min)
      {
        min = data[i];
      }
      else if (data[i] > max)
      {
        max = data[i];
      }
    }
    diff = max - min;
    if (min >= 0)
    {
      moy = 0;
    }
    else if (max <= 0)
    {
      moy = diff;
    }
    else
    {
      moy = -min;
    }
  }
  
  
  
  override func draw(_ rect: CGRect)
  {
    //INIT SOME VARIABLE
    update_extremum();
    let shapeLayer = CAShapeLayer();
    let context = UIBezierPath();
    shapeLayer.strokeColor = UIColor.black.cgColor;
    shapeLayer.lineWidth = 3.0;
    //DRAW AXES
    context.move(to: CGPoint(x: 0, y: view_size.height - CGFloat(moy) * view_size.height / CGFloat(diff)));
    context.addLine(to: CGPoint(x: view_size.width - 10, y: view_size.height - CGFloat(moy) * view_size.height / CGFloat(diff)));
    context.addLine(to: CGPoint(x: view_size.width - 10, y: view_size.height - CGFloat(moy) * view_size.height / CGFloat(diff) + 5));
    context.addLine(to: CGPoint(x: view_size.width, y: view_size.height - CGFloat(moy) * view_size.height / CGFloat(diff)));
    context.addLine(to: CGPoint(x: view_size.width - 10, y: view_size.height - CGFloat(moy) * view_size.height / CGFloat(diff) - 5));
    context.addLine(to: CGPoint(x: view_size.width - 10, y: view_size.height - CGFloat(moy) * view_size.height / CGFloat(diff)));
    context.move(to: CGPoint(x: 0, y: 10));
    context.addLine(to: CGPoint(x: -5, y: 10));
    context.addLine(to: CGPoint(x: 0, y: 0));
    context.addLine(to: CGPoint(x: 5, y: 10));
    context.addLine(to: CGPoint(x: 0, y: 10));
    context.addLine(to: CGPoint(x: 0, y: view_size.height - 10));
    context.addLine(to: CGPoint(x: -5, y: view_size.height - 10));
    context.addLine(to: CGPoint(x: 0, y: view_size.height));
    context.addLine(to: CGPoint(x: 5, y: view_size.height - 10));
    context.addLine(to: CGPoint(x: 0, y: view_size.height - 10));
    
    let center = view_size.height - CGFloat(moy) * view_size.height / CGFloat(diff);
    var i: Int = 1;
    while (center + CGFloat(i) * view_size.height / 10 < view_size.height)
    {
        let label = UILabel(frame: CGRect(x: 0, y: 0,  width: 40, height: 15.0));
        context.move(to: CGPoint(x: -5, y: center + CGFloat(i) * view_size.height / 10));
        context.addLine(to: CGPoint(x: 0, y: center + CGFloat(i) * view_size.height / 10));
        let tmp: Double = Double(-i) * Double(diff) / 10;
        label.text = "\(tmp)";
        label.textAlignment = .right;
        label.center = CGPoint(x: -27, y: center + CGFloat(i) * view_size.height / 10);
        label.font = UIFont (name: "Helvetica Neue", size: 15.0);
        self.addSubview(label);
        i += 1;
    }
    i = 0;
    while (center - CGFloat(i) * view_size.height / 10 > 0)
    {
      let label2 = UILabel(frame: CGRect(x: 0, y: 0,  width: 40, height: 15.0));
      context.move(to: CGPoint(x: -5, y: center - CGFloat(i) * view_size.height / 10));
      context.addLine(to: CGPoint(x: 0, y: center - CGFloat(i) * view_size.height / 10));
      let tmp: Double = Double(i) * Double(diff) / 10;
      label2.text = "\(tmp)";
      label2.textAlignment = .right;
      label2.center = CGPoint(x: -27, y: center - CGFloat(i) * view_size.height / 10);
      label2.font = UIFont (name: "Helvetica Neue", size: 15.0);
      self.addSubview(label2);
      i += 1;
    }

    let mid: CGFloat = view_size.height - CGFloat(moy) * view_size.height / CGFloat(diff);
    
    var first_pt = CGPoint(x: CGFloat(0) * view_size.width / CGFloat(data.count - 1), y: mid - CGFloat(data[0]) * view_size.height / CGFloat(diff));
    drawPoint(point: first_pt, color: UIColor(red: 1, green: 0, blue: 0, alpha: 0.6), radius: 3);
    
    draw_a(context: context, layer: shapeLayer);
    
    
    let shapeLayer2 = CAShapeLayer();
    shapeLayer2.strokeColor = color_line.cgColor;
    shapeLayer2.lineWidth = 1.0;
    
    let context2 = UIBezierPath();
    
    if (data.count > 1)
    {
      for i in 1...data.count - 1
      {
        let second_pt = CGPoint(x: CGFloat(i) * view_size.width / CGFloat(data.count - 1), y: mid - CGFloat(data[i]) * view_size.height / CGFloat(diff));
        drawPoint(point: second_pt, color: color_line, radius: 3);
        
        context2.move(to: first_pt);
        context2.addLine(to: second_pt);
        
        first_pt = second_pt;
      }
    }
    else
    {
      let second_pt = CGPoint(x: CGFloat(0) * view_size.width / CGFloat(data.count - 1), y: mid - CGFloat(data[0]) * view_size.height / CGFloat(diff));
      drawPoint(point: second_pt, color: color_line, radius: 3);
      
      context2.move(to: first_pt);
      context2.addLine(to: second_pt);
    }
    
    
    draw_a(context: context2, layer: shapeLayer2);
  }
  
  func get_point(index: Int) -> CGPoint
  {
    if (index >= data.count)
    {
      return CGPoint(x: 0, y: 0);
    }
    return CGPoint(x: CGFloat(index) * view_size.width / CGFloat(data.count),
                   y: view_size.height - (CGFloat(data[index]) + CGFloat(moy)) * view_size.height / CGFloat(diff));
  }
  
  func drawPoint(point: CGPoint, color: UIColor, radius: CGFloat)
  {
    let ovalPath = UIBezierPath(ovalIn: CGRect(x: point.x - radius, y: point.y - radius, width: radius * 2, height: radius * 2));
    color.setFill();
    ovalPath.fill();
  }

  
  func trace()
  {
    self.layer.sublayers?.forEach { $0.removeFromSuperlayer(); }
    let maskLayer = CALayer();
    maskLayer.backgroundColor = UIColor.black.cgColor;
    maskLayer.frame = CGRect(x: -100, y: -20, width: 2000, height: 2000);
    self.layer.mask = maskLayer;
    draw(CGRect());
  }
  
  func draw_a (context: UIBezierPath, layer: CAShapeLayer)
  {
    layer.path = context.cgPath;
    self.layer.addSublayer(layer);
    let animation = CABasicAnimation(keyPath: "strokeEnd");
    animation.fromValue = 0;
    animation.toValue = 1;
    animation.duration = 2;
    layer.add(animation, forKey: "animation");
  }
}

extension Double {
  /// Rounds the double to decimal places value
  func rounded(toPlaces places:Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
}
