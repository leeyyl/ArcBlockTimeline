//
//  ABHomeTextCell.swift
//  ArcBlockTimeline
//
//  Created by lee on 2021/7/5.
//  Copyright © 2021 com.arc.block. All rights reserved.
//

import UIKit

class ABHomeTextCell: ABHomeTableViewCell {

    override var model: ABHomeModel! {
        didSet {
            cellLabel.attributedText = model.text.attributed
        }
    }

    override func setupSubviews() {
        super.setupSubviews()
        cellContainer.addSubview(cellLabel)
        cellLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(10)
            make.bottom.right.equalTo(-10)
        }
    }

}
