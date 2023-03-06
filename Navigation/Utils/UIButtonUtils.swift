//
//  UIButtonUtils.swift
//  Navigation
//
//  Created by Yoji on 05.03.2023.
//

import UIKit

extension UIButton {
    func validateViaTxtField(_ txtField: UITextField) {
        let txtFieldIsEmpty = (txtField.text?.isEmpty ?? true) && txtField.text == ""
        self.isEnabled = !txtFieldIsEmpty
    }
}
