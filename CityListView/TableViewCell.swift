//
//  TableViewCell.swift
//  CityListDemo
//
//  Created by ray on 15/11/24.
//  Copyright © 2015年 ray. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setData(cityName:String){
        self.cityName.text = cityName;
    }
    
}
