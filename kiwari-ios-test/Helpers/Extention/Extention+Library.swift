//
//  Extention+Library.swift
//  kiwari-ios-test
//
//  Created by keenOI on 20/04/20.
//  Copyright © 2020 keen. All rights reserved.
//

import UIKit

extension UILabel {
    func setObject(completion: (UILabel) -> Void) {
        completion(self)
    }
}

extension UITextField {
    func setObject(completion: (UITextField) -> Void) {
        completion(self)
    }
}

extension UITextView {
    func setObject(completion: (UITextView) -> Void) {
        completion(self)
    }
}

extension UIButton {
    func setObject(completion: (UIButton) -> Void) {
        completion(self)
    }
}

extension UIImageView {
    func setObject(completion: (UIImageView) -> Void) {
        completion(self)
    }
}

extension UIStackView {
    func setObject(completion: (UIStackView) -> Void) {
        completion(self)
    }
}

extension UIView {
    func setObjectView(completion: (UIView) -> Void) {
        completion(self)
    }
}


