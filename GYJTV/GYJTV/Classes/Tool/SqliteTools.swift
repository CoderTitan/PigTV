//
//  SqliteTools.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/23.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class SqliteTools : NSObject{
    // 数据库指针属性
    fileprivate static var db : OpaquePointer? = nil
}

// MARK:- 打开数据库方法
extension SqliteTools{
    @discardableResult
    class func openDB( _ filePath : String) -> Bool{
        //1.转化路径
        let cFilePath = filePath.cString(using: .utf8)!
        
        //2.打开数据库
        return sqlite3_open(cFilePath, &db) == SQLITE_OK
    }
}

// MARK:- 执行语句方法
extension SqliteTools{
    //@discardableResult修饰后,如果没有使用方法的返回值，则不会报出警告
    @discardableResult
    class func excuteSqlite(_ sqliteStr : String) -> Bool{
        //1.转成c字符串
        let cSqlire = sqliteStr.cString(using: .utf8)!
        
        //2.执行语句
        return sqlite3_exec(db, cSqlire, nil, nil, nil) == SQLITE_OK
    }
}

// MARK:- 查询语句方法
extension SqliteTools{
    class func querySqlite(_ sqliteString : String) -> [[String : Any]] {
        //1.创建游标:指针
        var smrt : OpaquePointer? = nil
        
        //2.给游标赋值
        let cSqlString = sqliteString.cString(using: .utf8)!
        sqlite3_prepare_v2(db, cSqlString, -1, &smrt, nil)
        
        //3.判断是否有下一行
        //3.1获取列数
        let count = sqlite3_column_count(smrt)
        
        //3.2定义数组
        var tempArray = [[String : Any]]()
        //3.3取出数据
        while sqlite3_step(smrt) == SQLITE_ROW {
            var temp = [String : Any]()
            for i in 0..<count {
                let key = String(cString: sqlite3_column_name(smrt, i), encoding: .utf8)!
                let value = String(cString: sqlite3_column_text(smrt, i)!)
                
                temp[key] = value
            }
            tempArray.append(temp)
        }
        return tempArray
    }
}
