//
//  ABHomeLinkCell.swift
//  ArcBlockTimeline
//
//  Created by lee on 2021/7/5.
//  Copyright © 2021 com.arc.block. All rights reserved.
//

import UIKit

class ABHomeLinkCell: ABHomeTableViewCell {

    override var model: ABHomeModel! {
        didSet {
            linkLable.text = model.link
            cellLabel.attributedText = model.text.attributed
        }
    }
    
    fileprivate lazy var linkLable: UILabel = {
        let lable = UILabel()
        lable.numberOfLines = 2
        lable.textColor = .c46A3FF
        lable.font = .systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        return lable
    }()
    
    override func setupSubviews() {
        super.setupSubviews()
        cellContainer.addSubview(cellLabel)
        cellLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.top.left.equalTo(10)
        }
        
        let linkView = UIView()
        linkView.backgroundColor = .cF4F6F9
        linkView.layer.cornerRadius = 4
        linkView.layer.backgroundColor = linkView.backgroundColor?.cgColor
        cellContainer.addSubview(linkView)
        linkView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.bottom.right.equalTo(-10)
            make.top.equalTo(cellLabel.snp.bottom).offset(10)
        }
        
        let linkIcon = UIImageView(image: UIImage(named: "LinkIcon"))
        linkView.addSubview(linkIcon)
        linkIcon.snp.makeConstraints { (make) in
            make.height.width.equalTo(50)
            make.top.left.bottom.equalToSuperview()
        }

        linkView.addSubview(linkLable)
        linkLable.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.centerY.equalTo(linkIcon)
            make.left.equalTo(linkIcon.snp.right).offset(10)
        }
    }

}
