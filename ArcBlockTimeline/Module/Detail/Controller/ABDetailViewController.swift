//
//  ABDetailViewController.swift
//  ArcBlockTimeline
//
//  Created by lee on 2021/7/5.
//  Copyright © 2021 com.arc.block. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import JXPhotoBrowser

class ABDetailViewController: UIViewController {
    
    fileprivate let disposeBag = DisposeBag()
    
    fileprivate lazy var flowLayout: UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 20)
        flow.itemSize = CGSize(width: (GlobalMacro.Width - 40) / 3, height: (GlobalMacro.Width - 40) / 3)
        return flow
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let clv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        clv.register(ABDetailCollectionCell.self)
        clv.backgroundColor = .white
        clv.register(UICollectionReusableView.self,
                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                     withReuseIdentifier: "headerView")
        return clv
    }()
    
    fileprivate lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    fileprivate let model: ABHomeModel
    
    init(model: ABHomeModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "详情"
        view.backgroundColor = .white
        
        if !model.text.isEmpty {
            view.addSubview(textLabel)
            textLabel.snp.makeConstraints { (make) in
                make.left.equalTo(10)
                make.right.equalTo(-10)
                make.top.equalTo(GlobalMacro.NavigationHeight + 20)
            }
        }
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            if model.text.isEmpty {
                make.top.equalToSuperview()
            } else {
                make.top.equalTo(textLabel.snp.bottom).offset(10)
            }
            make.left.equalTo(10)
            make.right.equalTo(10)
            make.bottom.equalTo(-10)
        }
        
        bindViews()
    }
    
    fileprivate func bindViews() {
        if !model.text.isEmpty {
            textLabel.text = model.text
        }
        
        Observable.just(model.images)
            .bind(to: collectionView.rx.items) { (clv, row, url) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = clv.dequeueReusableCell(forIndexPath: indexPath) as ABDetailCollectionCell
                cell.imageUrl = url
                return cell
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .subscribe (onNext: { (indexPath) in
                let browser = JXPhotoBrowser()
                browser.numberOfItems = {
                    self.model.images.count
                }
                
                browser.cellClassAtIndex = { _ in
                    ABLoadingImageCell.self
                }
                
                browser.reloadCellAtIndex = { context in
                    let browserCell = context.cell as? ABLoadingImageCell
                    let path = IndexPath(item: context.index, section: indexPath.section)
                    let collectCell = self.collectionView.cellForItem(at: path) as? ABDetailCollectionCell
                    let placeholder = collectCell?.coverImageView.image
                    browserCell?.reloadData(placeholder: placeholder, urlString: self.model.images[context.index])
                }
                
                browser.transitionAnimator = JXPhotoBrowserZoomAnimator(previousView: { index -> UIView? in
                    let path = IndexPath(item: index, section: indexPath.section)
                    let cell = self.collectionView.cellForItem(at: path) as? ABDetailCollectionCell
                    return cell?.coverImageView
                })
                browser.pageIndex = indexPath.item
                browser.show()
            })
            .disposed(by: disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
