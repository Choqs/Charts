//
//  SpiderChartData.swift
//  Charts Testing App
//
//  Created by Vincent Rivière on 28/05/2019.
//  Copyright © 2019 Vincent Rivière. All rights reserved.
//

import UIKit

public class RadarChartData {
    private var values: [RadarChartDataValues]
    private var labels: [String]
    
    public init(values: [RadarChartDataValues], labels: [String]) {
        self.values = values
        self.labels = labels
    }
    
    private func checkDataDim() -> Bool {
        return self.values.allSatisfy({ (value) -> Bool in
            value.getValuesDim() == self.values.first!.getValuesDim() && value.getValuesDim() > 2
        })
    }
    
    private func checkValuesLabelsDim() -> Bool {
        return self.values.count == 0 || self.values.first!.getValuesDim() == self.labels.count
    }
    
    private func checkValuesNormalized() -> Bool {
        return self.values.allSatisfy({ (radarChartDataValue) -> Bool in
            return radarChartDataValue.getValues().allSatisfy({ (value) -> Bool in
                return value >= 0 && value <= 100
            })
        })
    }
    
    public func sanityCheck() {
        /* Check if all data in data are same dimension. */
        assert(self.checkDataDim(), "[RadarChartData] Dimension of all data must be at least three and equal each other.")
        
        /* Check if dimension of labels is equal to dimension of the data. */
        assert(self.checkValuesLabelsDim(), "[RadarChartData] Data and labels dimensions must be equals.")
        
        /* Check if labels dimension is at least three. */
        assert(self.labels.count > 2, "[RadarChartData] Dimension of labels must be at least 3.")
        
        /* Check if all value are normalized between 0 and 100 */
        assert(self.checkValuesNormalized(), "[RadarChartData] All values must be between 0 and 100")
    }
    
    public func getValues() -> [RadarChartDataValues] { return self.values }
    
    public func getValuesCount() -> Int { return self.values.count }
    
    public func valuesIsEmpty() -> Bool { return self.values.count == 0 }
    
    public func getLabels() -> [String] { return self.labels }
    
    public func getLabelsCount() -> Int { return self.labels.count }
}
