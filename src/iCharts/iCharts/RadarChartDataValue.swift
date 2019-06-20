//
//  RadarChartAxis.swift
//  Charts Testing App
//
//  Created by Vincent Rivière on 30/05/2019.
//  Copyright © 2019 Vincent Rivière. All rights reserved.
//

import UIKit

public class RadarChartDataValues {
    private var values: [Double]
    private var color: UIColor
    
    public init(values: [Double], color: UIColor) {
        self.values = values
        self.color = color
    }
    
    public func getValuesDim() -> Int { return values.count }
    
    public func getValues() -> [Double] { return self.values }
    
    public func getColor() -> UIColor { return self.color }
    
    public func getFillColor() -> UIColor { return self.color.withAlphaComponent(0.5) }
}
