# Charts
Cool charts for iOS application [SWIFT 4]

## Installing

1) Download the desired chart
2) Add it to your project directory
3) In the Storyboard, add a View from the Objects Library
4) Select the View and click on the "Show the identity inspector"
5) Select the appropriate Class
6) Connect the Chart (UIView subclass) to your code with an Outlet
```swift
  @IBOutlet weak var my_chart: SpiderChart!
```
    my_chart.trace();
  }
7) Init your Chart with the Method set
```swift
set(nb_param: UInt, color_param: UIColor, 
    color_stat: UIColor, color_stat_border: UIColor, 
    name_param: [String], value_param: [UInt]);
```
8) Trace your Chart with the methode trace
```swift
    my_chart.trace();

```



## Features

### 1) SpiderChart

![alt text](https://github.com/Choqs/Charts/blob/master/readme_sources/anim.gif)![alt text](https://github.com/Choqs/Charts/blob/master/readme_sources/anim2.gif)

