//
//  WeekAllRankViewController.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/21.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class WeekAllRankViewController: SubRankViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubrankControllers(["上周", "本周"])
    }
}
