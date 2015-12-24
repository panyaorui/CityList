//
//  SpecifyArray.swift
//  CityListDemo
//
//  Created by ray on 15/12/10.
//  Copyright © 2015年 ray. All rights reserved.
//

import UIKit

class SpecifyArray: NSObject {
    
    var array:NSMutableArray = NSMutableArray();
    
    
    var maxCount:Int = 10{
        didSet{
            if(maxCount <= 0){
               maxCount = 10;
            }
        }
    }
    
    init(max:Int) {
        super.init();
        maxCount = max;
    }
    
    func addObject(object:NSObject){
        array.addObject(object);
        if(array.count > maxCount && array.count > 1){
            array.removeObjectAtIndex(0);
        }
    }
    
    func count()->Int{
        return array.count;
    }
    
    func getaArray()->NSArray{
        return array;
    }
    
    func addArray(arr:NSArray){
    //    self.array = array as! NSMutableArray;
        self.array = NSMutableArray(array: arr);
    }
 
}
