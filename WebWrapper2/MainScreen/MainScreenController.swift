//
//  MainScreenController.swift
//  WebWrapper2
//
//  Created by Yahor Yauseyenka on 16.02.21.
//

import Cocoa
import WebKit
import SnapKit

class MainScreenController: NSViewController {
    private let backButton : NSButton = {
        let backButton = NSButton()
        backButton.makeAdultButton(with: Constants.pinkColor, radius: Constants.cornerRadius)
        backButton.setAccessibilityIdentifier(WebButton.back.rawValue)
        backButton.title = .localized.backButton
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.action = #selector(backButtonClicked)
        return backButton
    }()
    
    private let forwardButton: NSButton = {
        let forwardButton = NSButton()
        forwardButton.makeAdultButton(with: Constants.pinkColor, radius: Constants.cornerRadius)
        forwardButton.setAccessibilityIdentifier(WebButton.forward.rawValue)
        forwardButton.title = .localized.forwardButton
        forwardButton.action = #selector(forwardButtonClicked)
        return forwardButton
    }()
    
    private let homeButton: NSButton = {
        let homeButton = NSButton()
        homeButton.makeAdultButton(with: Constants.pinkColor, radius: Constants.cornerRadius)
        homeButton.setAccessibilityIdentifier(WebButton.home.rawValue)
        homeButton.title = .localized.homeButton
        homeButton.action = #selector(homeButtonClicked)
        return homeButton
    }()
    
    @IBOutlet weak var boxView: NSBox!
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        webView.uiDelegate = self
        configureView()
        configureWebView()
    }
    
    //MARK: - View configuration
    private func configureWebView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let url = AppPersistentVariables.baseUrl {
                self.webView.load(URLRequest(url: url))
            }
        }
    }

    private func configureView() {
        boxView.fillColor = .windowBackgroundColor
        boxView.cornerRadius = 0

        self.setupConstraints(with: backButton, homeButton, forwardButton)

        if webView.backForwardList.backList.isEmpty {
            backButton.isEnabled = false
        }
        if webView.backForwardList.forwardList.isEmpty {
            forwardButton.isEnabled = false
        }
    }

    //MARK: - Setup constrains for all buttons
    private func setupConstraints(with buttons: NSButton...) {
        buttons.forEach { button in
            self.boxView.addSubview(button)
            switch button.accessibilityIdentifier() {
            case WebButton.home.rawValue:
                button.snp.makeConstraints {
                    $0.width.equalTo(Constants.homeButtonWidth)
                    $0.centerX.equalTo(self.boxView.snp.centerX)
                    $0.top.equalTo(self.boxView.snp.top).inset(Constants.backForwardInsets.top)
                    $0.bottom.equalTo(self.boxView.snp.bottom).inset(Constants.backForwardInsets.bottom)
                }
            case WebButton.forward.rawValue:
                button.snp.makeConstraints {
                    $0.width.equalTo(Constants.forwardButtonWidth)
                    $0.top.equalTo(self.boxView.snp.top).inset(Constants.backForwardInsets.top)
                    $0.right.equalTo(self.boxView.snp.right).inset(Constants.backForwardInsets.right)
                    $0.bottom.equalTo(self.boxView.snp.bottom).inset(Constants.backForwardInsets.bottom)
                }
            case WebButton.back.rawValue:
                button.snp.makeConstraints {
                    $0.width.equalTo(Constants.backButtonWidth)
                    $0.top.equalTo(self.boxView.snp.top).inset(Constants.backForwardInsets.top)
                    $0.left.equalTo(self.boxView.snp.left).inset(Constants.backForwardInsets.left)
                    $0.bottom.equalTo(self.boxView.snp.bottom).inset(Constants.backForwardInsets.bottom)
                }
            default:
                break
            }
        }
    }

    //MARK: - WebView Button Selectors
    @objc private func backButtonClicked() {
        guard let button = self.boxView.subviews.last?.subviews.first(where: { $0.accessibilityIdentifier() == WebButton.back.rawValue }),
              let backButton = button as? NSButton else { return }
        if backButton.isEnabled == true {
            webView.goBack()
        }
    }

    @objc private func forwardButtonClicked() {
        guard let button = self.boxView.subviews.last?.subviews.first(where: { $0.accessibilityIdentifier() ==  WebButton.forward.rawValue }),
              let forwardButton = button as? NSButton else { return }
        if forwardButton.isEnabled == true {
            webView.goForward()
        }
    }

    @objc private func homeButtonClicked() {
        guard let url = AppPersistentVariables.baseUrl else { return }
        self.webView.load(URLRequest(url: url))
    }
}
