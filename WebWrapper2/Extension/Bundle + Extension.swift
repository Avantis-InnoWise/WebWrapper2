//
//  Bundle + Extension.swift
//  WebWrapper2
//
//  Created by Yahor Yauseyenka on 18.02.22.
//
import Cocoa

extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}

