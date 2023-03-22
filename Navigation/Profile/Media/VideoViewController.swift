//
//  VideoViewController.swift
//  Navigation
//
//  Created by Yoji on 19.03.2023.
//

import UIKit
import WebKit

final class VideoViewController: UIViewController {
    // MARK: Variables
    private let viewModel: VideoViewModelProtocol
    
    // MARK: Views
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.scrollView.isScrollEnabled = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    // MARK: Lifecycle
    init(viewModel: VideoViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        let width = self.view.frame.width * 2.45
        guard let htmlString = self.getHTMLString(viewModel.video, width: width) else {
            return
        }
        
        self.webView.loadHTMLString(htmlString.0, baseURL: htmlString.1)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    // MARK: Setups
    private func setupView() {
        self.view.addSubview(self.webView)
        
        NSLayoutConstraint.activate([
            self.webView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.webView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.webView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.webView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: (9/16)),
        ])
    }
    
    // MARK: Helpers
    private func getHTMLString(_ string: String, width: CGFloat) -> (String, URL)? {
        if let url = URL(string: string) {
            let height = (width / 16) * 9
            let htmlString = """
            <iframe
            width=\"\(width)\" height=\"\(height)\"
            src=\"\(string)\" title=\"YouTube video player\" frameborder=\"0\"
            allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\"
            allowfullscreen>
            </iframe>
            """
            return (htmlString, url)
        }
        return nil
    }
}
