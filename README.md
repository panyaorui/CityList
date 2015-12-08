# 定位和选择城市

## 动画效果

![image](https://github.com/panyaorui/CityList/blob/master/效果图/01.gif)


使用说明
## 1.引用CoreLocation类库用于定位服务
![image](https://github.com/panyaorui/CityList/blob/master/效果图/02.png)

## 2.设置定位权限NSLocationWhenInUseUsageDescription（使用应用程序时允许定位）
![image](https://github.com/panyaorui/CityList/blob/master/效果图/03.png)

##直接跳转CityViewController即可
```swift
var cityViewController:CityViewController = CityViewController(nibName: "CityViewController", bundle: nil);
        self.presentViewController(cityViewController, animated: true) { () -> Void in
            
        }
```



