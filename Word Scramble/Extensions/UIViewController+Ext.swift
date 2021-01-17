//
//  UIViewController+Ext.swift
//  Word Scramble
//
//  Created by Vu Kim Duy on 17/1/21.
//

import UIKit

extension UIViewController {
    func presentErrorAlertController(title: String, message: String, buttonTitle: String) {
        let ac = UIAlertController(title: title, message: message , preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: buttonTitle, style: .default))
        present(ac, animated: true)
    }
}
