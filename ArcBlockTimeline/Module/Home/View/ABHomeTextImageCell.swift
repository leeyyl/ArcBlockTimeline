//
//  ABHomeTextImageCell.swift
//  ArcBlockTimeline
//
//  Created by lee on 2021/7/5.
//  Copyright © 2021 com.arc.block. All rights reserved.
//

import UIKit
import Kingfisher

class ABHomeTextImageCell: ABHomeTableViewCell {

    override var model: ABHomeModel! {
        didSet {
            updateLayout(model.text)
            moreView.isHidden = model.images.count == 1
            coverImageView.kf.setImage(with: URL(string: model.images.first ?? ""),
                                       placeholder: UIImage(named: "DefaultImage"))
        }
    }
    
    fileprivate lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    fileprivate lazy var moreView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    override func setupSubviews() {
        super.setupSubviews()
        cellContainer.addSubview(coverImageView)
        let label = UILabel()
        label.textColor = .white
        label.text = "更多图片"
        moreView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        coverImageView.addSubview(moreView)
        moreView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(-10)
        }
    }
    
    fileprivate func updateLayout(_ content: String) {
        if content.isEmpty {
            cellLabel.removeFromSuperview()
            coverImageView.snp.remakeConstraints { (make) in
                make.top.equalTo(10)
                make.left.equalTo(10)
                make.height.equalTo(180)
                make.right.bottom.equalTo(-10)
            }
        } else {
            cellLabel.attributedText = model.text.attributed
            cellContainer.addSubview(cellLabel)
            cellLabel.snp.remakeConstraints { (make) in
                make.right.equalTo(-10)
                make.top.left.equalTo(10)
            }
            coverImageView.snp.remakeConstraints { (make) in
                make.left.equalTo(10)
                make.height.equalTo(180)
                make.right.bottom.equalTo(-10)
                make.top.equalTo(cellLabel.snp.bottom).offset(10)
            }
        }
    }

}
