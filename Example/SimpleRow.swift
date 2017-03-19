//
//  SimpleRow.swift
//  StackViewController
//
//  Created by GenoZhou on 2017-02-26.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import UIKit

class SimpleRow: UIView {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: 100)
    }
    
    convenience init(color: UIColor) {
        self.init()
        backgroundColor = color
    }
    
}
