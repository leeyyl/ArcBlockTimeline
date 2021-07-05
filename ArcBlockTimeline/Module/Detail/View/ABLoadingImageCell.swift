//
//  ABLoadingImageCell.swift
//  ArcBlockTimeline
//
//  Created by lee on 2021/7/5.
//  Copyright © 2021 com.arc.block. All rights reserved.
//

import UIKit
import JXPhotoBrowser

class ABLoadingImageCell: JXPhotoBrowserImageCell {
    
    let progressView = ABProgressView()
    
    override func setup() {
        super.setup()
        addSubview(progressView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        progressView.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    }
    
    func reloadData(placeholder: UIImage?, urlString: String?) {
        progressView.progress = 0
        let url = urlString.flatMap { URL(string: $0) }
        
        imageView.kf.setImage(with: url, placeholder: placeholder) { [weak self] (received, total) in
            guard let `self` = self else { return }
            if total > 0 {
                self.progressView.progress = CGFloat(received) / CGFloat(total)
            }
        } completionHandler: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(_):
                self.progressView.progress = 1
            case .failure(_):
                self.progressView.progress = 0
            }
            self.setNeedsLayout()
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
