//
//  ABHomeViewModel.swift
//  ArcBlockTimeline
//
//  Created by lee on 2021/7/5.
//  Copyright © 2021 com.arc.block. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ABHomeViewModel {
    
    fileprivate let disposeBag = DisposeBag()
    
    let listData = BehaviorRelay<[ABHomeModel]>(value: [])
    
    func loadList() {
        ABConvertJSON.shared
            .reload()
            .do(onNext: { (models) in
                // print(models)
            })
            .bind(to: listData)
            .disposed(by: disposeBag)
    }
    
}
