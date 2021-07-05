//
//  ABHomeViewController.swift
//  ArcBlockTimeline
//
//  Created by lee on 2021/7/5.
//  Copyright © 2021 com.arc.block. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class ABHomeViewController: UIViewController {
    
    fileprivate let disposeBag = DisposeBag()
    
    fileprivate let viewModel = ABHomeViewModel()
    
    fileprivate lazy var homeTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.backgroundColor = .cF4F6F9
        tableView.register(ABHomeTextCell.self)
        tableView.register(ABHomeTextImageCell.self)
        tableView.register(ABHomeLinkCell.self)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "首页"
        view.backgroundColor = .red
        view.addSubview(homeTableView)
        homeTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        viewModel.loadList()
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<Void, ABHomeModel>> (
            configureCell: { dataSource, tableView, indexPath, model -> UITableViewCell in
                var cell: ABHomeTableViewCell!
                switch model.type {
                case .text:
                    cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ABHomeTextCell
                case .textImage, .image:
                    cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ABHomeTextImageCell
                case .link:
                    cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ABHomeLinkCell
                }
                cell.model = model
                return cell
        })
        
        viewModel.listData
            .map{ $0.map{ SectionModel(model: Void(), items: [$0]) } }
            .bind(to: homeTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        homeTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        homeTableView.rx.modelSelected(ABHomeModel.self)
            .subscribe (onNext: { (model) in
                
                switch model.type {
                case .text:
                    print("纯文本自动调整高度")
                case .textImage, .image:
                    let vc = ABDetailViewController(model: model)
                    self.navigationController?.pushViewController(vc, animated: true)
                case .link:
                    let vc = ABWebViewController(url: model.link)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
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

extension ABHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
}
