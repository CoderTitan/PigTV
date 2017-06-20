//
//  CourseHeaderVIew.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/19.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

fileprivate let kCollectionCell : String = "collectionCell"

//MARK: 点击事件代理
protocol CourseHeaderViewDelegate : class{
    func courseHeaderView(_ courseView : CourseHeaderVIew, didSelectItemAt courseModel : CourseModel)
}

class CourseHeaderVIew: UIView , NibLoadable{

    //MARK: 私有属性
    weak var delegate : CourseHeaderViewDelegate?
    fileprivate var scrollTimer : Timer?
    fileprivate lazy var courseVM : CourseViewModel = CourseViewModel()
    fileprivate lazy var pageControl : UIPageControl = {
        let page = UIPageControl(frame: CGRect(x: (self.frame.width - 80) * 0.5, y: self.frame.height - 40, width: 80, height: 40))
        page.pageIndicatorTintColor = UIColor.white
        page.currentPageIndicatorTintColor = UIColor.orange
        return page
    }()
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal

        let collection = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collection.backgroundColor = UIColor.white
        collection.register(CourserCollectionCell.self, forCellWithReuseIdentifier: kCollectionCell)
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCourseView()
        startTimer()
        loadCourseData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: 界面数据处理
extension CourseHeaderVIew{
    fileprivate func setupCourseView(){
        addSubview(collectionView)
        addSubview(pageControl)
    }
    
    func loadCourseData(){
        courseVM.loadCourseData { 
            self.collectionView.reloadData()
            self.pageControl.numberOfPages = self.courseVM.courseArray.count
            //设置向左可以滚动的最大数量
            let startIndex = IndexPath(item: self.courseVM.courseArray.count * 1000, section: 0)
            self.collectionView.scrollToItem(at: startIndex, at: .left, animated: true)
        }
    }
}

//MARK: 定时器
extension CourseHeaderVIew{
    func startTimer(){
        stopTimer()
        scrollTimer = Timer(timeInterval: 2, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.current.add(scrollTimer!, forMode: .commonModes)
    }
    
    func stopTimer(){
        if scrollTimer != nil {
            scrollTimer?.invalidate()
            scrollTimer = nil
        }
    }

    @objc private func scrollToNext(){
        let offseetX = collectionView.contentOffset.x + collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x : offseetX, y: 0), animated: true)
    }
}


//MARK: collectionView代理
extension CourseHeaderVIew :UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseVM.courseArray.count * 100000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionCell, for: indexPath) as! CourserCollectionCell
        cell.courseModel = courseVM.courseArray[indexPath.item % courseVM.courseArray.count]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let courseModel = courseVM.courseArray[indexPath.item % courseVM.courseArray.count]
        delegate?.courseHeaderView(self, didSelectItemAt: courseModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
}

//MARK: UIScrollViewDelegate
extension CourseHeaderVIew : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let count = courseVM.courseArray.count == 0 ? 1 : courseVM.courseArray.count
        let contentOffetX = collectionView.contentOffset.x + frame.width * 0.5
        pageControl.currentPage = Int(contentOffetX / frame.width) % count
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        startTimer()
    }
}

//MARK: UICollectionViewCell
class CourserCollectionCell : UICollectionViewCell{
    
    fileprivate lazy var imageView : UIImageView = UIImageView()
    
    var courseModel : CourseModel?{
        didSet{
            guard let model = courseModel else {
                return
            }
            imageView.setImage(model.picUrl, "Img_default")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.frame
    }
}

