//
//  TableViewHeadSectionCell.swift
//  CityListDemo
//
//  Created by ray on 15/12/1.
//  Copyright © 2015年 ray. All rights reserved.
//

import UIKit

class TableViewHeadSectionCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
   
    var data = [String]!();
    override func awakeFromNib() {
        super.awakeFromNib()

    }
   
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func reloadData(){
        self.collectionView.reloadData();
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return data!.count;
    }
    
   
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let nib = UINib(nibName: "CollectionViewCell", bundle: NSBundle.mainBundle());
        collectionView.registerNib(nib, forCellWithReuseIdentifier: "cell");
        let cell:CollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell;
        cell.addData(self.data[indexPath.row]);
        return cell;
    }
    
    ////////////////////  UICollectionViewDelegateFlowLayout   ////////////////////
    
    /** 每一个cell的大小 **/
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let widht = UIScreen.mainScreen().bounds.size.width;
        return CGSizeMake(widht / 3 - 20,40);
    }
    
    /** 设置每组的cell的边界 **/
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left:0, bottom: 0, right: 0);
    }

    
}
