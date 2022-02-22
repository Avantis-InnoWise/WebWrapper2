//
//  MainScreenController + WebView.swift
//  WebWrapper2
//
//  Created by Yahor Yauseyenka on 16.02.22.
//

import Cocoa
import WebKit

extension MainScreenController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        decisionHandler(.allow)
    }

    func webView(
        _ webView: WKWebView,
        didFinish navigation: WKNavigation!) {
        guard
            let backButtonView = self.boxView.subviews.last?.subviews.first(where: { $0.accessibilityIdentifier() == WebButton.back.rawValue }),
            let forwardButtonView = self.boxView.subviews.last?.subviews.first(where: { $0.accessibilityIdentifier() == WebButton.forward.rawValue }),
            let backButton = backButtonView as? NSButton,
            let forwardButton = forwardButtonView as? NSButton
        else { return }

            switch webView.backForwardList.backList.isEmpty {
            case true:
                backButton.isEnabled = false
            case false:
                backButton.isEnabled = true
            }
            
            switch webView.backForwardList.forwardList.isEmpty {
            case true:
                forwardButton.isEnabled = false
            case false:
                forwardButton.isEnabled = true
            }
    }
}

extension MainScreenController: WKUIDelegate {
    func webView(
        _ webView: WKWebView,
        createWebViewWith configuration: WKWebViewConfiguration,
        for navigationAction: WKNavigationAction,
        windowFeatures: WKWindowFeatures
    ) -> WKWebView? {
        if navigationAction.targetFrame == nil ||
            navigationAction.targetFrame?.isMainFrame == false {
            if let url = navigationAction.request.url {
                self.webView.load(URLRequest(url: url))
            }
        }
        return nil
    }
}

