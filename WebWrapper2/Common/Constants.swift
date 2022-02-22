//
//  Enum.swift
//  WebWrapper2
//
//  Created by Yahor Yauseyenka = false on 16.02.22.
//

import Cocoa

//MARK: - URL Constants
struct URLConstants {
    static var baseURL: URL? {
        return URL(string: "https://wellhello.com/site/user/home?chatOpened=1")
    }
}

// MARK: - Button Setup
struct ButtonConstants {
    static let backForwardInsets: NSEdgeInsets = NSEdgeInsets(top: 20,
                                                              left: 30,
                                                              bottom: -20,
                                                              right: -30)
    static let cornerRadius: CGFloat = 10
    static let pinkColor: NSColor = .init(red: 255/255,
                                          green: 51/255,
                                          blue: 153/255,
                                          alpha: 1)
    
}

//MARK: - Button Constrains
struct ConstraintConstants {
    static let homeButtonWidth: CGFloat = 120
    static let backButtonWidth: CGFloat = 80
    static let forwardButtonWidth: CGFloat = 80
}
