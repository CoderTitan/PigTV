//
//  GiftListView.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/5/25.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

private let kGiftCellID = "kGiftCellID"
//MARK: 赠送礼物协议
protocol GiftListViewDelegate : class{
    func giftListView(giftListView : GiftListView, giftModel : GiftModel)
}
class GiftListView: UIView ,NibLoadable{

    // MARK: 控件属性
    @IBOutlet weak var giftView: UIView!
    @IBOutlet weak var sendGiftBtn: UIButton!
    fileprivate var pageCollectionView : TQJCollectionView!
    fileprivate var giftVM : GiftViewModel = GiftViewModel()
    fileprivate var currentIndexPath : IndexPath?
    weak var delegate : GiftListViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //界面
        setupGiftListView()
        //数据
        loadGiftListData()

    }

}

//MARK: 添加视图
extension GiftListView{
    fileprivate func setupGiftListView(){
        let style = TQJTitleStyle()
        style.isScrollEnable = false
        style.isShowBottomLine = true
        style.normalColor = UIColor(r: 255, g: 255, b: 255)
        
        let layout = TQJPageCollectionLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        pageCollectionView = TQJCollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: giftView.bounds.height), style: style, titles: ["热门", "高级", "豪华", "专属"], isTitleInTop: true, layout: layout)
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        pageCollectionView.backgroundColor = UIColor.black
        pageCollectionView.register(nib: UINib(nibName: "GiftViewCell", bundle: nil), identifier: kGiftCellID)
        giftView.addSubview(pageCollectionView)
        
    }
    
    //加载数据
    fileprivate func loadGiftListData(){
        giftVM.loadGiftData {
            self.pageCollectionView.reloadData()
        }
    }
}

//MARK: 
extension GiftListView : TQJCollectionViewDelegate, TQJCollectionViewDateSource{
    func numberOfSections(in pageCollectionView: TQJCollectionView) -> Int {
        return giftVM.giftListData.count
    }
    func pageCollectionView(_ collectionView: TQJCollectionView, numberOfItemsInSection section: Int) -> Int {
        return giftVM.giftListData[section].list.count
    }
    func pageCollectionView(_ pageCollectionView: TQJCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGiftCellID, for: indexPath) as! GiftViewCell
        cell.giftModel = giftVM.giftListData[indexPath.section].list[indexPath.row]
        return cell
    }
    func pageCollectionView(_ pageCollectionView: TQJCollectionView, didSelectorItemAt indexPath: IndexPath) {
        sendGiftBtn.isEnabled = true
        currentIndexPath = indexPath
    }
}

//MARK: 送礼物按钮
extension GiftListView{
    @IBAction func sendGiftBtnClick() {
        let giftPackage = giftVM.giftListData[(currentIndexPath?.section)!]
        let gift = giftPackage.list[(currentIndexPath?.item)!]
        delegate?.giftListView(giftListView: self, giftModel: gift)
    }
}
