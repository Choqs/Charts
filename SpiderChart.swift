//
//  SpiderChart.swift
//  test
//
//  Created by Vincent Riviere on 03/02/2018.
//  Copyright © 2018 Vincent Riviere. All rights reserved.
//

import UIKit

class SpiderChart: UIView
{
  var nb_param: UInt = 5;
  var color_param: UIColor = UIColor.black;
  var color_stat: [UIColor] = [UIColor.cyan];
  var color_stat_border: [UIColor] = [UIColor.blue];
  var name_param: [String] = ["Execution", "Landing", "Style", "Creativity", "Difficulty"];
  var value_param: [[Int]] = [[90, 10, 69, 85, 32]];
  var view_size: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0);

  //[String: Float]();
  
  override func layoutSubviews()
  {
    view_size = self.bounds;
    trace();
  }
  
  func set(nb_param: UInt, color_param: UIColor, color_stat: [UIColor],
           color_stat_border: [UIColor], name_param: [String], value_param: [[Int]])
  {
    self.nb_param = nb_param;
    self.color_param = color_param;
    self.color_stat = color_stat;
    self.color_stat_border = color_stat_border;
    self.name_param = name_param;
    self.value_param = value_param;
  }
  
  func axes()
  {
    //INIT SOME VARIABLE
    let shapeLayer = CAShapeLayer();
    let context = UIBezierPath();
    shapeLayer.strokeColor = color_param.cgColor;
    shapeLayer.fillColor = UIColor.clear.cgColor;
    shapeLayer.lineWidth = 1.0
    shapeLayer.lineCap = kCALineCapRound;
    //DRAW AXES
    var angle: CGFloat = 270;
    for _ in 1...nb_param
    {
      context.move(to: CGPoint(x: view_size.width / 2, y: view_size.height / 2));
      context.addLine(to: CGPoint(x: view_size.width / 2 + view_size.height / 2.4 * CGFloat(cos(.pi * Double(angle) / 180)),
                                   y: view_size.height / 2 + view_size.height / 2.4 * CGFloat(sin(.pi * Double(angle) / 180))));
      angle += 360 / CGFloat(nb_param);
    }
    draw_a(context: context, layer: shapeLayer);
  }
  
  func grid_intern()
  {
    //INIT SOME VARIABLE
    let shapeLayer = CAShapeLayer();
    let context = UIBezierPath();
    shapeLayer.strokeColor = color_param.cgColor;
    shapeLayer.fillColor = UIColor.clear.cgColor;
    shapeLayer.lineWidth = 1.0;
    shapeLayer.lineCap = kCALineCapRound
    
    //DRAW GRID
    var angle: CGFloat = 270;
    for _ in 1...nb_param
    {
      for i in 1...3
      {
        let index: CGFloat = view_size.height / 2.4 * 0.25 * CGFloat(i);
        context.move(to: CGPoint(x: view_size.width / 2 + index * CGFloat(cos(.pi * Double(angle) / 180)),
                                 y: view_size.height / 2 + index * CGFloat(sin(.pi * Double(angle) / 180))));
        let angle2 = angle + 360 / CGFloat(nb_param);
        context.addLine(to: CGPoint(x: view_size.width / 2 + index * CGFloat(cos(.pi * Double(angle2) / 180)),
                                    y: view_size.height / 2 + index * CGFloat(sin(.pi * Double(angle2) / 180))));
      }
      angle += 360 / CGFloat(nb_param);
    }
    
    draw_a(context: context, layer: shapeLayer);
  }
  
  func grid_extern()
  {
    //INIT SOME VARIABLE
    let shapeLayer = CAShapeLayer();
    let context = UIBezierPath();
    shapeLayer.strokeColor = color_param.cgColor;
    shapeLayer.fillColor = UIColor.clear.cgColor;
    shapeLayer.lineWidth = 2.0;
    shapeLayer.lineCap = kCALineCapRound;
    
    //DRAW grid
    var angle: CGFloat = 270;
    for _ in 1...nb_param
    {
      let index: CGFloat = view_size.height / 2.4;
      context.move(to: CGPoint(x: view_size.width / 2 + index * CGFloat(cos(.pi * Double(angle) / 180)),
                               y: view_size.height / 2 + index * CGFloat(sin(.pi * Double(angle) / 180))));
      angle += 360 / CGFloat(nb_param);
      context.addLine(to: CGPoint(x: view_size.width / 2 + index * CGFloat(cos(.pi * Double(angle) / 180)),
                                  y: view_size.height / 2 + index * CGFloat(sin(.pi * Double(angle) / 180))));
    }
    
    draw_a(context: context, layer: shapeLayer);
  }
  
  override func draw(_ rect: CGRect)
  {
    var angle: CGFloat = 270;
    let view_size_demi = view_size.height / 2.2;
    angle = 270;
    for i in 0...nb_param - 1
    {
      angle = CGFloat(Int(angle) % 360);
      let w: CGFloat = CGFloat(name_param[Int(i)].count) * 11;
      let label = UILabel(frame: CGRect(x: 0, y: 0,  width: w, height: 11));
      label.text = name_param[Int(i)];
      if ((angle < 300  && angle > 240) || (angle > 60 && angle < 120))
      {
        label.textAlignment = .center;
        label.center = CGPoint(x: view_size.width / 2 + view_size_demi * CGFloat(cos(.pi * Double(angle) / 180)),
                               y: view_size.height / 2 + view_size_demi * CGFloat(sin(.pi * Double(angle) / 180)));
      }
      else if (angle <= 300 && angle >= 60)
      {
        label.textAlignment = .right;
        label.center = CGPoint(x: view_size.width / 2 + view_size_demi * CGFloat(cos(.pi * Double(angle) / 180)) - w / 2,
                               y: view_size.height / 2 + view_size_demi * CGFloat(sin(.pi * Double(angle) / 180)));
      }
      else
      {
        label.textAlignment = .left;
        label.center = CGPoint(x: view_size.width / 2 + view_size_demi * CGFloat(cos(.pi * Double(angle) / 180)) + w / 2,
                               y: view_size.height / 2 + view_size_demi * CGFloat(sin(.pi * Double(angle) / 180)));
      }
      label.font = UIFont (name: "Helvetica Neue", size: 11.0);
      self.addSubview(label);
      angle += 360 / CGFloat(nb_param);
    }
  }
  
  func test()
  {
    for l in 0...value_param.count - 1
    {
      //INIT SOME VARIABLE
      let shapeLayer = CAShapeLayer();
      let context = UIBezierPath();
      shapeLayer.strokeColor = color_stat[l].cgColor;
      shapeLayer.fillColor = UIColor.clear.cgColor;
      shapeLayer.lineWidth = 2.0;
      shapeLayer.lineCap = kCALineCapRound;
      //DRAW STATS
      var angle: CGFloat = 270;
      var index: CGFloat = CGFloat(value_param[l][0]) / 100 * view_size.height / 2.4;
      context.move(to: CGPoint(x: view_size.width / 2 + index * CGFloat(cos(.pi * Double(angle) / 180)),
                               y: view_size.height / 2 + index * CGFloat(sin(.pi * Double(angle) / 180))));
      for i in 0...nb_param - 2
      {
        index = CGFloat(value_param[l][Int(i)]) / 100 * view_size.height / 2.4;
        let index2: CGFloat = CGFloat(value_param[l][Int(i + 1)]) / 100 * view_size.height / 2.4;
        
        angle += 360 / CGFloat(nb_param);
        context.addLine(to: CGPoint(x: view_size.width / 2 + index2 * CGFloat(cos(.pi * Double(angle) / 180)),
                                    y: view_size.height / 2 + index2 * CGFloat(sin(.pi * Double(angle) / 180))));
      }
      context.close();
      draw_a(context: context, layer: shapeLayer);
      
      shapeLayer.strokeColor = color_stat_border[l].cgColor;
      //ANNIMATION FILLING
      let startPath = UIBezierPath(rect: CGRect(x: view_size.width / 2, y: view_size.height / 2,
                                                width: 10, height: 10));
      let rectangleLayer = CAShapeLayer();
      rectangleLayer.path = startPath.cgPath;
      rectangleLayer.fillColor = color_stat[l].withAlphaComponent(0.5).cgColor;
      
      self.layer.addSublayer(rectangleLayer);
      
      let zoomAnimation = CABasicAnimation();
      zoomAnimation.keyPath = "path";
      zoomAnimation.duration = 1;
      zoomAnimation.toValue = context.cgPath;
      zoomAnimation.fillMode = kCAFillModeForwards;
      zoomAnimation.isRemovedOnCompletion = false;
      rectangleLayer.add(zoomAnimation, forKey: "zoom");
    }
  }
  
  func trace()
  {
    self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    axes();
    grid_intern();
    grid_extern();
    test();
  }
  
  func draw_a (context: UIBezierPath, layer: CAShapeLayer)
  {
    layer.path = context.cgPath;
    self.layer.addSublayer(layer);
    let animation = CABasicAnimation(keyPath: "strokeEnd");
    animation.fromValue = 0;
    animation.toValue = 1;
    animation.duration = 0.8;
    layer.add(animation, forKey: "animation");
  }
}
