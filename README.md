# Charts
Cool charts for iOS application [SWIFT 4]

## Installing

1) Download the desired chart

2) Add it to your project directory

3) In the Storyboard, add a View from the Objects Library

4) Select the View, click on the "Show the identity inspector" and select the appropriate Class
![alt text](https://github.com/Choqs/Charts/blob/master/readme_sources/anim3.gif)

5) Connect the Chart (UIView subclass) to your code with an Outlet
```swift
  @IBOutlet weak var my_chart: SpiderChart!
```

6) Init your Chart with the Method set
```swift
set(nb_param: UInt, color_param: UIColor, 
    color_stat: [UIColor], color_stat_border: [UIColor], 
    name_param: [String], value_param: [[Int]]);
```
- nb_param             : UInt representing the number of parameter in your chart (5 for a pentagon)
- color_param         : UIColor of the grid
- color_stat              : list of UIColor (must be the same size as name_param and value_param)
- color stat_border  : list of UIColor for the border line
- name_param        : list of String representing the names of parameters
- value_param         : matrix of Int representing the value of each parameter for each objects

7) Trace your Chart with the Method trace
```swift
    my_chart.trace();

```



## Features

### 1) SpiderChart

![alt text](https://github.com/Choqs/Charts/blob/master/readme_sources/anim.gif)![alt text](https://github.com/Choqs/Charts/blob/master/readme_sources/anim2.gif)

