//
//  ABDetailCollectionCell.swift
//  ArcBlockTimeline
//
//  Created by lee on 2021/7/5.
//  Copyright © 2021 com.arc.block. All rights reserved.
//

import UIKit
import Kingfisher

class ABDetailCollectionCell: UICollectionViewCell {
    
    var imageUrl = "" {
        didSet {
            coverImageView.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: "LinkIcon"))
        }
    }
    
    lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(coverImageView)
        coverImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
