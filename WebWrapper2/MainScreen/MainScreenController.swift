//
//  MainScreenController.swift
//  WebWrapper2
//
//  Created by Yahor Yauseyenka on 16.02.21.
//

import Cocoa
import WebKit

class MainScreenController: NSViewController {
    private let backButton : NSButton = {
        let backButton = NSButton()
        backButton.makeAdultButton(with: ButtonConstants.pinkColor, radius: ButtonConstants.cornerRadius)
        backButton.setAccessibilityIdentifier(WebButton.back.rawValue)
        backButton.title = .localized.backButton
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.action = #selector(backButtonClicked)
        backButton.layer?.backgroundColor = NSColor.brown.cgColor
        return backButton
    }()
    
    private let forwardButton: NSButton = {
        let forwardButton = NSButton()
        forwardButton.makeAdultButton(with: ButtonConstants.pinkColor, radius: ButtonConstants.cornerRadius)
        forwardButton.setAccessibilityIdentifier(WebButton.forward.rawValue)
        forwardButton.title = .localized.forwardButton
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.action = #selector(forwardButtonClicked)
        forwardButton.layer?.backgroundColor = NSColor.brown.cgColor
        return forwardButton
    }()
    
    private let homeButton: NSButton = {
        let homeButton = NSButton()
        homeButton.makeAdultButton(with: ButtonConstants.pinkColor, radius: ButtonConstants.cornerRadius)
        homeButton.setAccessibilityIdentifier(WebButton.home.rawValue)
        homeButton.title = .localized.homeButton
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        homeButton.action = #selector(homeButtonClicked)
        homeButton.layer?.backgroundColor = NSColor.brown.cgColor
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
            if let url = URLConstants.baseURL {
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

        self.backButton.widthAnchor.constraint(equalToConstant: ConstraintConstants.backButtonWidth).isActive = true
        self.backButton.topAnchor.constraint(equalTo: self.boxView.topAnchor, constant: ButtonConstants.backForwardInsets.top).isActive = true
        self.backButton.leadingAnchor.constraint(equalTo: self.boxView.leadingAnchor, constant: ButtonConstants.backForwardInsets.left).isActive = true
        self.backButton.bottomAnchor.constraint(equalTo: self.boxView.bottomAnchor, constant: ButtonConstants.backForwardInsets.bottom).isActive = true

        self.homeButton.widthAnchor.constraint(equalToConstant: ConstraintConstants.homeButtonWidth).isActive = true
        self.homeButton.centerXAnchor.constraint(equalTo: self.boxView.centerXAnchor).isActive = true
        self.homeButton.topAnchor.constraint(equalTo: self.boxView.topAnchor, constant: ButtonConstants.backForwardInsets.top).isActive = true
        self.homeButton.bottomAnchor.constraint(equalTo: self.boxView.bottomAnchor, constant: ButtonConstants.backForwardInsets.bottom).isActive = true

        self.forwardButton.widthAnchor.constraint(equalToConstant: ConstraintConstants.forwardButtonWidth).isActive = true
        self.forwardButton.topAnchor.constraint(equalTo: self.boxView.topAnchor, constant: ButtonConstants.backForwardInsets.top).isActive = true
        self.forwardButton.trailingAnchor.constraint(equalTo: self.boxView.trailingAnchor, constant: ButtonConstants.backForwardInsets.right).isActive = true
        self.forwardButton.bottomAnchor.constraint(equalTo: self.boxView.bottomAnchor, constant: ButtonConstants.backForwardInsets.bottom).isActive = true
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
        guard let url = URLConstants.baseURL else { return }
        self.webView.load(URLRequest(url: url))
    }
}
