//
//  GlobalMacro.swift
//  ArcBlockTimeline
//
//  Created by lee on 2021/7/5.
//  Copyright © 2021 com.arc.block. All rights reserved.
//

import UIKit

struct GlobalMacro {
    
    // 屏幕宽度
    static let Width = UIScreen.main.bounds.size.width
    // 屏幕高度
    static let Height = UIScreen.main.bounds.size.height
    
    // 状态栏高度
    static let StatusBarHeight: CGFloat = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0
    
    // 导航栏高度: 状态栏高度 + 44
    static let NavigationHeight: CGFloat = StatusBarHeight + 44
    
}
