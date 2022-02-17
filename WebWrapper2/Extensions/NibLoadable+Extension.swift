//
//  NibLoadable.swift
//  WebWrapper2
//
//  Created by Yahor Yauseyenka on 16.02.21.
//

import Cocoa

protocol NibLoadable: AnyObject {
    static func loadFromNib(_ nib: NSNib) -> Self
}

extension NibLoadable where Self: NSViewController {
    static func loadFromNib(_ nib: NSNib = nib()) -> Self {
        let result = self.init()
        nib.instantiate(withOwner: result, topLevelObjects: nil)
        result.viewDidLoad()
        return result
    }

    static func nib() -> NSNib {
        let bundle = Bundle(for: self)
        let nibName = String(describing: self)
        return NSNib(nibNamed: nibName, bundle: bundle) ?? NSNib()
    }
}

extension NSViewController: NibLoadable {}
