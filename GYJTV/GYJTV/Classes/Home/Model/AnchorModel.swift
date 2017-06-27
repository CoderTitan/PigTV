//
//  AnchorModel.swift
//  GYJTV
//
//  Created by 田全军 on 2017/4/20.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class AnchorModel: BaseModel {

    var uid : String = ""
    var roomid : String = ""
    var name : String = ""
    var pic51 : String = ""
    var pic74 : String = ""
    var live : Int = 0 // 是否在直播
    var push : Int = 0 // 直播显示方式
    var focus : Int = 0 // 关注数
    
    var isEvenIndex : Bool = false

}

//MARK: 数据库
extension AnchorModel{
    //1.插入
    func insertIntoDB(){
        //1.拼接插入语句
        let insert = "INSERT INTO t_focus (roomid, name, pic51, pic74, live, push) VALUES ('\(roomid)', '\(name)', '\(pic51)', '\(pic74)', \(live), \(push));"
 
        //2.执行语句
        if SqliteTools.excuteSqlite(insert) {
            print("插入成功")
        }else{
            print("插入失败")
        }
    }
    
    //2.删除
    func deleteSqliteDB(){
        //1.拼接删除语句
        let deleteSql = "DELETE FROM t_focus WHERE roomid = '\(roomid)';"
        
        //2.执行语句
        if SqliteTools.excuteSqlite(deleteSql) {
            print("删除成功")
        }else {
            print("删除失败")
        }
    }
}
