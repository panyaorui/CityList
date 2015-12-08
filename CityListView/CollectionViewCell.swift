//
//  CollectionViewCell.swift
//  CityListDemo
//
//  Created by ray on 15/12/2.
//  Copyright © 2015年 ray. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var button: CityButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
   
    }
    
    func addData(str:String){
        self.button.setTitle(str, forState: UIControlState.Normal);
    }
   
}
