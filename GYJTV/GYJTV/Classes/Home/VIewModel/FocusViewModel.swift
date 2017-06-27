//
//  FocusViewModel.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/23.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class FocusViewModel: HomeViewModel {

}


extension FocusViewModel{
    func  loadFocusData(_ complection : () -> ()){
        let dataArray = SqliteTools.querySqlite("SELECT * FROM t_focus;")
        
        for dict in dataArray {
            self.anchorModels.append(AnchorModel(dic: dict))
        }
        
        complection()
    }
}
