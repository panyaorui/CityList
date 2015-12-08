//
//  CityButton.swift
//  CityListDemo
//
//  Created by ray on 15/11/30.
//  Copyright © 2015年 ray. All rights reserved.
//

import UIKit

class CityButton: UIButton {
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!;
        
        //添加圆角
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = true;
        
        //添加变宽
        self.layer.borderWidth = 1;
        self.layer.borderColor = UIColor(red: 190 / 255, green: 190 / 255, blue: 190 / 255, alpha: 1).CGColor;
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame);
    }

}
