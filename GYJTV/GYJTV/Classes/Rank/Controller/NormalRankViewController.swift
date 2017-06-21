//
//  NormalRankViewController.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/21.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class NormalRankViewController: SubRankViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubrankControllers(["日榜", "周榜", "月榜", "总榜"])
    }
}
