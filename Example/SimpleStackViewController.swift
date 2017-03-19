//
//  SimpleStackViewController.swift
//  Example
//
//  Created by GenoZhou on 2017-03-14.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import UIKit
import GZForm

class SimpleStackViewController: StackViewController {

    // MARK: - Properties
    
    let row1 = SimpleRow(color: .blue)
    let row2 = SimpleRow(color: .yellow)
    let row3 = SimpleRow(color: .gray)
    let row4 = SimpleRow(color: .green)
    let row5 = SimpleRow(color: .red)
    let row6 = SimpleRow(color: .white)
    let row7 = SimpleRow(color: .black)
    let row8 = SimpleRow(color: .brown)
    
    // MARK: - Lifecycle
    
    open override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rows = [row1, row2, row3, row4, row5, row6, row7, row8]
        rows.forEach{ addItem($0, hideSeparator: true) }
    }

}

