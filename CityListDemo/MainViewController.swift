//
//  MainViewController.swift
//  CityListDemo
//
//  Created by ray on 15/12/9.
//  Copyright © 2015年 ray. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,CityViewControllerDelegate {

    @IBOutlet weak var btnCity: UIButton!
    var cityController:CityViewController!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func actionCity(sender: AnyObject) {
          cityController = CityViewController(nibName: "CityViewController", bundle: nil);
         cityController.delegate = self;
           self.presentViewController(cityController, animated: true) { () -> Void in
            
           }
    }
    
    func selectCity(city: String) {
        self.btnCity.setTitle(city, forState: UIControlState.Normal);
    }

}
