//
//  CityViewController.swift
//  CityListDemo
//
//  Created by ray on 15/11/24.
//  Copyright © 2015年 ray. All rights reserved.
//

import UIKit

protocol CityViewControllerDelegate{
    func selectCity(city:String);
}

class CityViewController: UIViewController,UISearchDisplayDelegate,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,LocationManagerDelegate {
    
    @IBOutlet weak var layoutTopConstraint: NSLayoutConstraint!
    @IBOutlet var searchDC: UISearchDisplayController!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    /** 回调接口*/
    var delegate:CityViewControllerDelegate?;
    
    
    
    //城市数据库
    var dict:NSMutableDictionary!;
    //所有城市名称
    var cityArray:NSMutableArray!;
     //所有城市拼音首字母
    var citySpell:NSMutableArray!;
    //所有城市拼音首字母
    var sectionCitySpell:NSMutableArray!;
    //搜索到得城市
    var searchCityArray:NSArray!;
    //城市管理
    var locationManager:LocationManager!;
    //当前定位城市名称
    var cityName:String = "正在获取...";
    //最近访问城市
    var historyCitys = ["北京","上海","广州"];
    //热门城市
    let hotCitys = ["上海","北京","广州","深圳","武汉","天津","西安","南京","杭州"];
    //最近访问城市数据
    var dataHistoryCitys:SpecifyArray!;
    let keyHistory = "keyHistory";
    
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.title = "选择城市";
        
        cityArray = NSMutableArray();
        citySpell = NSMutableArray();
        searchCityArray = NSArray();
        dataHistoryCitys = SpecifyArray(max: 3);
       
        getCityData();
        
    }
  
    /**
      装在城市数据信息
    */
    private func getCityData(){
        //获取当前城市
         locationManager = LocationManager();
        locationManager.delegate = self;
        locationManager.startLocationCity();
        //获取最近放问城市
        var object = NSUserDefaults.standardUserDefaults().arrayForKey(keyHistory);
        if(object == nil){
            self.dataHistoryCitys.addObject("北京");
        }else{
            self.dataHistoryCitys.addArray(object!);
        }
        self.historyCitys = self.dataHistoryCitys.getaArray() as! [String];
        
        let path = NSBundle.mainBundle().pathForResource("citydict", ofType: "plist");
        self.dict = NSMutableDictionary(contentsOfFile: path!);
        let key:NSArray = self.dict.allKeys;
        self.citySpell.addObjectsFromArray(key.sortedArrayUsingSelector(Selector("compare:")));
        self.sectionCitySpell = NSMutableArray();
        self.sectionCitySpell.addObjectsFromArray(["定位城市","最近访问城市","热门城市"]);
        self.sectionCitySpell.addObjectsFromArray(self.citySpell as [AnyObject]);
        let allValue:NSArray = self.dict.allValues;
        for oneArr in allValue{
            for cityName in oneArr as! NSArray{
                self.cityArray.addObject(cityName);
            }
        }
        
    }

    /** 对城市名称进行排序*/
    private func cityNameSort(str1:NSString,str2:String,context:Void)->NSComparisonResult{
        return str1.localizedCompare(str2);
    }
    private func handlerSearch(searchString:String?){
        if(searchString == nil){
            return;
        }
        
        //判断是否清空数据
        if(searchString!.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0){
            let array:NSArray = self.cityArray;
            let result:NSArray = ZYPinYinSearch.searchWithOriginalArray(array as [AnyObject], andSearchText: searchString, andSearchByPropertyName: "");
            self.searchCityArray = result.sortedArrayUsingSelector(Selector("compare:"));
        }else{ //清空数据
        
        }
    }
    
    /**
     将选中城市名称返回并关闭当前页面
    - parameter city: 城市名称
    */
    private func selectCity(city:String){
        
        if(self.delegate != nil){
            dataHistoryCitys.addObject(city);
            NSUserDefaults.standardUserDefaults().setObject(dataHistoryCitys.getaArray(), forKey: keyHistory);
            self.delegate!.selectCity(city);
            self.dismissViewControllerAnimated(true , completion: { () -> Void in
            })
        }
        
    }

   //////////////////// UITableViewDataSource  ////////////////////
    
    internal func tableView(table: UITableView, numberOfRowsInSection section: Int) -> Int{

        if(!self.tableview.isEqual(table)){ //搜索结果时
            return self.searchCityArray.count;
        }
        
        if(section < 3){
            return 1;
        }
        let key:NSString = self.sectionCitySpell.objectAtIndex(section) as! NSString;
        return self.dict.objectForKey(key)!.count;
    }
   
    func numberOfSectionsInTableView(table: UITableView) -> Int {
        
        if(!self.tableview.isEqual(table)){ //搜索结果时
            return 1;
        }
        return self.sectionCitySpell.count;
    }

    func sectionIndexTitlesForTableView(table: UITableView) -> [String]? {
        if(!self.tableview.isEqual(table)){ //搜索结果时
            return nil;
        }
        let arr01:NSArray = self.citySpell;
        let arr02:NSArray = NSArray(array: ["#","$"," *"]).arrayByAddingObjectsFromArray(arr01 as [AnyObject]);
        
        return arr02 as? [String];
    }
    
    func tableView(table: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view:SectionView = SectionView.viewFromNibNamed();
        if(!self.tableview.isEqual(table)){ //搜索结果时
            view.addData(self.citySpell.objectAtIndex(section) as! String);
        }else{
            view.addData(self.sectionCitySpell.objectAtIndex(section) as! String);
        }
        
        return view;
    }
    
    func tableView(tableView: UITableView,      section: Int) -> CGFloat {
        return 30;
    }
    
    func tableView(table: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if((indexPath.section == 0 || indexPath.section == 1) && self.tableview.isEqual(table)){
            return 70;
        }
        if(indexPath.section == 2 && self.tableview.isEqual(table)){
            return 175;
        }
        return 40;
    }
    
    internal func tableView(table: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let identifierHead = "cellHead";
         let identifier = "cell";
        var cellHead:TableViewHeadSectionCell? = table.dequeueReusableCellWithIdentifier(identifierHead) as? TableViewHeadSectionCell;
        var cell:TableViewCell? = table.dequeueReusableCellWithIdentifier(identifier) as? TableViewCell;
        let section = indexPath.section;
        
        if((section == 2 || section == 0 || section == 1) && self.tableview.isEqual(table)){  //如果为头部Section
            
            if(cellHead == nil){
                let nib:UINib = UINib(nibName: "TableViewHeadSectionCell", bundle: NSBundle.mainBundle());
                table.registerNib(nib, forCellReuseIdentifier: identifierHead);
                cellHead = table.dequeueReusableCellWithIdentifier(identifierHead) as? TableViewHeadSectionCell;
            }
            //添加数据
            switch(section){
                case 0: //定位城市
                    cellHead!.addData([self.cityName], city: selectCity)
                    cellHead!.reloadData();
                    break;
                case 1: // 最近使用城市
                    cellHead!.addData(historyCitys, city: selectCity);

                    break;
                case 2: // 热门城市
                    cellHead!.addData(hotCitys, city: selectCity)
                    break;
                
                default:
                    break;
            }
            
            return cellHead!;
            
        }
       // 普通城市数据
        if(cell == nil){
            let nib:UINib = UINib(nibName: "TableViewCell", bundle: NSBundle.mainBundle());
            table.registerNib(nib, forCellReuseIdentifier: identifier);
            cell = table.dequeueReusableCellWithIdentifier(identifier) as? TableViewCell;
        }
        //添加数据
        var key:NSString = "";
        if(self.tableview.isEqual(table)){
            key = self.sectionCitySpell.objectAtIndex(indexPath.section) as! NSString;
            cell!.setData(self.dict.objectForKey(key)!.objectAtIndex(indexPath.row) as! String);
        }else{
            cell!.setData(self.searchCityArray.objectAtIndex(indexPath.row) as! String);
        }
        
        return cell!;
    }
    
    //////////////////// UITableViewDelegate  ////////////////////
    
    func tableView(table: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(self.delegate != nil ){
            var cityName:String = "";
            if(table != self.tableview){
                cityName = self.searchCityArray.objectAtIndex(indexPath.row) as! String;
            }else{
                let section = indexPath.section;
                if(section > 2){//列表城市
                    let key:NSString = self.sectionCitySpell.objectAtIndex(section) as! NSString;
                    cityName = self.dict.objectForKey(key)!.objectAtIndex(indexPath.row) as! String;
                }
            }
            self.selectCity(cityName);
       }
    }
    
    
    
    //////////////////// UISearchDisplayDelegate  ////////////////////
    
    /**
     即将开始搜索
    */
    internal func searchDisplayControllerWillBeginSearch(controller: UISearchDisplayController){
         self.layoutTopConstraint.constant = 20;
        UIView.animateWithDuration(0.3) { () -> Void in
            self.view.layoutIfNeeded();
        }
    }
    
    /**
     搜索结束
    */
    internal func searchDisplayControllerWillEndSearch(controller: UISearchDisplayController){
        self.layoutTopConstraint.constant = 65;
    }
    
    //shouldReloadTableForSearchString
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String?) -> Bool {

        self.handlerSearch(searchString);
        return true;
    }
    
    //////////////////// LocationManagerDelegate  ////////////////////
    
    /**
    获取到当前城市
    - parameter cityName: 城市名称
    */
    func locationCity(cityName: String) {
        self.cityName = cityName;
        let indexPath:NSIndexPath = NSIndexPath(forRow: 0, inSection: 0);
        self.tableview.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None);
    }
    
}
