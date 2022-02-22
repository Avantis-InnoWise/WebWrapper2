//
//  Localized.swift
//  WebWrapper2
//
//  Created by Yahor Yauseyenka on 17.02.22.
//
import Cocoa

public struct Localization {

    var appTitle: String {
        NSLocalizedString("app.title", tableName: nil, bundle: .main, value: "App Title", comment: "App Title")
    }
    
    var backButton: String {
        NSLocalizedString("back.button", tableName: nil, bundle: .main, value: "Back", comment: "Back Button Title")
    }
    
    var homeButton: String {
        NSLocalizedString("home.button", tableName: nil, bundle: .main, value: "Home", comment: "Home Button Title")
    }
    
    var forwardButton: String {
        NSLocalizedString("forward.button", tableName: nil, bundle: .main, value: "Forward", comment: "Forward Button Title")
    }
    
}

public extension String {
    static var localized = Localization()
}
