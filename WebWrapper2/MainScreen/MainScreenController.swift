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
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.action = #selector(forwardButtonClicked)
        return forwardButton
    }()
    
    private let homeButton: NSButton = {
        let homeButton = NSButton()
        homeButton.makeAdultButton(with: Constants.pinkColor, radius: Constants.cornerRadius)
        homeButton.setAccessibilityIdentifier(WebButton.home.rawValue)
        homeButton.title = .localized.homeButton
        homeButton.translatesAutoresizingMaskIntoConstraints = false
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
            if let url = Constants.baseURL {
                self.webView.load(URLRequest(url: url))
            }
        }
    }

    private func configureView() {
        boxView.fillColor = .windowBackgroundColor
        boxView.cornerRadius = 0

        self.setupConstrainsForButtons()

        if webView.backForwardList.backList.isEmpty {
            backButton.isEnabled = false
        }
        if webView.backForwardList.forwardList.isEmpty {
            forwardButton.isEnabled = false
        }
    }

    //MARK: - Setup constrains for all buttons
    
    private func setupConstrainsForButtons() {
        self.boxView.addSubview(backButton)
        self.boxView.addSubview(homeButton)
        self.boxView.addSubview(forwardButton)

        self.backButton.widthAnchor.constraint(equalToConstant: Constants.backButtonWidth).isActive = true
        self.backButton.topAnchor.constraint(equalTo: self.boxView.topAnchor, constant: Constants.backForwardInsets.top).isActive = true
        self.backButton.leadingAnchor.constraint(equalTo: self.boxView.leadingAnchor, constant: Constants.backForwardInsets.left).isActive = true
        self.backButton.bottomAnchor.constraint(equalTo: self.boxView.bottomAnchor, constant: Constants.backForwardInsets.bottom).isActive = true

        self.homeButton.widthAnchor.constraint(equalToConstant: Constants.homeButtonWidth).isActive = true
        self.homeButton.centerXAnchor.constraint(equalTo: self.boxView.centerXAnchor).isActive = true
        self.homeButton.topAnchor.constraint(equalTo: self.boxView.topAnchor, constant: Constants.backForwardInsets.top).isActive = true
        self.homeButton.bottomAnchor.constraint(equalTo: self.boxView.bottomAnchor, constant: Constants.backForwardInsets.bottom).isActive = true

        self.forwardButton.widthAnchor.constraint(equalToConstant: Constants.forwardButtonWidth).isActive = true
        self.forwardButton.topAnchor.constraint(equalTo: self.boxView.topAnchor, constant: Constants.backForwardInsets.top).isActive = true
        self.forwardButton.trailingAnchor.constraint(equalTo: self.boxView.trailingAnchor, constant: Constants.backForwardInsets.right).isActive = true
        self.forwardButton.bottomAnchor.constraint(equalTo: self.boxView.bottomAnchor, constant: Constants.backForwardInsets.bottom).isActive = true
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
        guard let button = self.boxView.subviews.last?.subviews.first(where: { $0.accessibilityIdentifier() == WebButton.forward.rawValue }),
              let forwardButton = button as? NSButton else { return }
        if forwardButton.isEnabled == true {
            webView.goForward()
        }
    }

    @objc private func homeButtonClicked() {
        guard let url = Constants.baseURL else { return }
        self.webView.load(URLRequest(url: url))
    }
}
