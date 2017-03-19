//
//  StackViewController.swift
//  GZStackView
//
//  Created by GenoZhou on 2017-03-18.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import Foundation

@IBDesignable
open class StackViewController: UIViewController {
    public lazy var scrollView: UIScrollView = UIScrollView()
    public lazy var stackView: UIStackView = UIStackView()
    public var separatorClass: StackViewItemSeparator.Type = BaseSeparatorView.self
    
    // MARK: - Lifecycle
    
    open override func loadView() {
        super.loadView()
        commonLayout()
    }
    
    // MARK: - Public Methods
    
    open func addItem(_ item: StackViewItem, hideSeparator: Bool = false) {
        stackView.addArrangedSubview(item.viewForStack)
        if let controller = item.controllerForStack {
            addChildViewController(controller)
            controller.didMove(toParentViewController: controller)
        }
        if !hideSeparator {
            let axis: UILayoutConstraintAxis = (stackView.axis == UILayoutConstraintAxis.horizontal) ? .vertical : .horizontal
            separatorClass.attachTo(stackViewItem: item, withAxis: axis)
        }
    }
    
    open func removeItem(_ item: StackViewItem) {
        stackView.removeArrangedSubview(item.viewForStack)
        item.viewForStack.removeFromSuperview()
        if let controller = item.controllerForStack {
            controller.willMove(toParentViewController: nil)
            controller.removeFromParentViewController()
        }
    }
    
    open func insertItem(_ item: StackViewItem, atIndex index: Int, hideSeparator: Bool = false) {
        guard index <= stackView.subviews.count && index >= 0 else { fatalError("index out of range") }
        stackView.insertArrangedSubview(item.viewForStack, at: index)
        if let controller = item.controllerForStack {
            addChildViewController(controller)
            controller.didMove(toParentViewController: controller)
        }
        if !hideSeparator {
            let axis: UILayoutConstraintAxis = (stackView.axis == UILayoutConstraintAxis.horizontal) ? .vertical : .horizontal
            separatorClass.attachTo(stackViewItem: item, withAxis: axis)
        }
    }
    
    // MARK: - Private Methods

    private func commonLayout() {
        automaticallyAdjustsScrollViewInsets = false
        layoutAutoScrollView()
        layoutStackView()
    }
    
    private func layoutAutoScrollView() {
        if !view.subviews.contains(scrollView) {
            view.addSubview(scrollView)
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
    }
    
    private func layoutStackView() {
        stackView.axis = .vertical
        if !scrollView.subviews.contains(stackView) {
            scrollView.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        }
    }
    
}
