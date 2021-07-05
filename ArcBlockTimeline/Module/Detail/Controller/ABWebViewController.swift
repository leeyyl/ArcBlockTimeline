//
//  ABWebViewController.swift
//  ArcBlockTimeline
//
//  Created by lee on 2021/7/5.
//  Copyright © 2021 com.arc.block. All rights reserved.
//

import UIKit
import WebKit

class ABWebViewController: UIViewController {
    
    fileprivate let url: String
    
    fileprivate lazy var webView: WKWebView = {
        let wk = WKWebView()
        wk.navigationDelegate = self
        return wk
    }()
    
    fileprivate lazy var progressView: UIProgressView = {
        let progress = UIProgressView.init(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: GlobalMacro.Width, height: 2))
        progress.tintColor = UIColor.green
        progress.trackTintColor = UIColor.white
        return progress
    }()
    
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "正在加载..."
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.right.bottom.equalToSuperview()
        }
        view.addSubview(progressView)
        view.bringSubviewToFront(progressView)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        if url.isUrl {
            guard let url = URL(string: url) else { return }
            webView.load(URLRequest(url: url))
        } else {
            let alert = UIAlertController(title: "提示", message: "链接无效", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "知道了", style: .default, handler: { (_) in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // 加载进度条
        if keyPath == "estimatedProgress"{
            progressView.alpha = 1.0
            progressView.setProgress(Float((self.webView.estimatedProgress) ), animated: true)
            if (self.webView.estimatedProgress )  >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }
    
    deinit {
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
        self.webView.uiDelegate = nil
        self.webView.navigationDelegate = nil
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

extension ABWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.title = webView.title
    }
    
}
