//
//  FormViewController.swift
//  GZStackView
//
//  Created by GenoZhou on 2017-03-14.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import UIKit

@IBDesignable
open class FormViewController: StackViewController, KeyboardObserving, ViewResponderManaging {
    
    // MARK: - Properties
    
    public var viewResponders: [ViewResponder] = []
    
    // MARK: - Initialization
    
    deinit {
        stopObservingKeyboard()
    }
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        startObservingKeyboard()
    }
    
    // MARK: - Public Methods
    
    open override func addItem(_ item: StackViewItem, hideSeparator: Bool = false) {
        super.addItem(item, hideSeparator: hideSeparator)
        addManagedViewRespondersFromView(item.viewForStack)
    }
    
    open override func removeItem(_ item: StackViewItem) {
        super.removeItem(item)
        removeManagedViewRespondersFromView(item.viewForStack)
    }
    
    open override func insertItem(_ item: StackViewItem, atIndex index: Int, hideSeparator: Bool = false) {
        super.insertItem(item, atIndex: index, hideSeparator: hideSeparator)
        insertManagedViewResponderFromView(item.viewForStack, atIndex: index)
    }
    
    
    // MARK: - KeyboardObserving
    
    public func keyboardWillShow(_ sender: Notification) {
        guard
            let keyboardHeight = (sender.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height,
            let duration = sender.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curveValue = sender.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Int,
            let curve = UIViewAnimationCurve.init(rawValue: curveValue),
            let frame = firstResponderAssociatedView?.frame
            else { return }
        
        var animationOption: UIViewAnimationOptions
        switch curve {
        case .easeIn:
            animationOption = UIViewAnimationOptions.curveEaseIn
        case .easeInOut:
            animationOption = UIViewAnimationOptions.curveEaseInOut
        case .easeOut:
            animationOption = UIViewAnimationOptions.curveEaseOut
        case .linear:
            animationOption = UIViewAnimationOptions.curveLinear
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: animationOption, animations: {
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            self.scrollView.scrollRectToVisible(frame, animated: false)
        }, completion: nil)
    }
    
    public func keyboardWillHide(_ sender: Notification) { scrollView.contentInset = UIEdgeInsets.zero }
    
    public func keyboardDidShow(_ sender: Notification) { }
    
    public func keyboardDidHide(_ sender: Notification) { }

}
