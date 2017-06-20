//
//  CourseViewModel.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/19.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class CourseViewModel {

    lazy var courseArray : [CourseModel] = [CourseModel]()
    
    func loadCourseData( _ complection : @escaping() -> ()){
        NetworkTool.requestData(.get, URLString: kDiscoverScrollUrl) { (result : Any) in
            
            guard let resultDic = result as? [String : Any] else { return }
            
            guard let message = resultDic["message"] as? [String : Any] else { return }
            
            guard let banners = message["banners"] as? [[String : Any]] else { return }
            
            for dict in banners{
                let model = CourseModel(dic: dict)
                self.courseArray.append(model)
            }
            complection()
        }
    }
}
