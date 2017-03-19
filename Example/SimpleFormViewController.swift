//
//  SimpleFormViewController.swift
//  GZStackView
//
//  Created by GenoZhou on 2017-03-18.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import UIKit
import GZForm

class SimpleFormViewController: FormViewController {
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rows = SimpleTextFieldRow.gen(amount: 10, prefix: "TextField")
        rows.forEach{ addItem($0) }
    }
}
