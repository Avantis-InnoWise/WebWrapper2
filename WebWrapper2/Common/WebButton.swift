//
//  WebButton.swift
//  WebWrapper2
//
//  Created by Yahor Yauseyenka on 17.02.22.
//

import Foundation

enum WebButton {
    case back
    case home
    case forward
    
    var rawValue: String {
        switch self {
        case .back:
            return "back_button"
        case .home:
            return "home_button"
        case .forward:
            return "forward_button"
        }
    }
}
