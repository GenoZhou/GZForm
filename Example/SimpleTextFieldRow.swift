//
//  SimpleTextFieldRow.swift
//  GZStackView
//
//  Created by GenoZhou on 2017-03-18.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import UIKit

class SimpleTextFieldRow: UIView {

    let textField = UITextField()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: 66)
    }
    
    convenience init(placeholder: String) {
        self.init()
        textField.placeholder = placeholder
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    static func gen(amount: Int, prefix: String) -> [SimpleTextFieldRow] {
        var output: [SimpleTextFieldRow] = []
        var counter = 0
        repeat {
            let placeholder = "\(prefix) \(counter + 1)"
            let row = SimpleTextFieldRow(placeholder: placeholder)
            output.append(row)
            counter += 1
        } while counter < amount
        return output
    }
    
    private func commonInit() {
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 16).isActive = true
        textField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -16).isActive = true
    }

}
