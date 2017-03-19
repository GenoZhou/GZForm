//
//  ViewResponderManaging.swift
//  StackViewController
//
//  Created by GenoZhou on 2017-02-28.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import Foundation

public struct ViewResponder {
    var responder: UIResponder
    var associatedView: UIView?
}

public protocol ViewResponderManaging: class {
    var viewResponders: [ViewResponder] { get set }
    var infinite: Bool { get }
}

extension ViewResponderManaging {
    
    public var infinite: Bool { return false }
    
    // MARK: Public Properties
    
    public var firstResponder: UIResponder? { return firstViewResponder?.responder }
    
    public var firstResponderAssociatedView: UIView? { return firstViewResponder?.associatedView }
    
    public var previousResponder: UIResponder? { return previousViewResponder?.responder }
    
    public var previousResponderAssociatedView: UIView? { return previousViewResponder?.associatedView }
    
    public var nextResponder: UIResponder? { return nextViewResponder?.responder }
    
    public var nextResponderAssociatedView: UIView? { return nextViewResponder?.associatedView }
    
    // MARK: Private Properties
    
    private var firstViewResponder: ViewResponder? {
        return viewResponders.filter { $0.responder.isFirstResponder }.first
    }
    
    private var previousViewResponder: ViewResponder? {
        guard let firstResponderIndex = viewResponders.index(where: { $0.responder.isFirstResponder }) else { return nil }
        let previousFirstResponderIndex = firstResponderIndex > 0 ? firstResponderIndex - 1 : firstResponderIndex
        return viewResponders[previousFirstResponderIndex]
    }
    
    private var nextViewResponder: ViewResponder? {
        guard
            let firstResponderIndex = viewResponders.index(where: { $0.responder.isFirstResponder }),
            let nextFirstResponderIndex = infinite ? (firstResponderIndex == viewResponders.count - 1 ? 0 : firstResponderIndex + 1) : (firstResponderIndex == viewResponders.count - 1 ? nil : firstResponderIndex + 1)
            else { return nil }
        return viewResponders[nextFirstResponderIndex]
    }
    
    // MARK: Public Methods
    
    public func addManagedViewRespondersFromView(_ view: UIView) {
        let viewResponders = view.subviews.filter{ $0.canBecomeFirstResponder }.map{ ViewResponder(responder: $0, associatedView: view) }
        viewResponders.forEach{ addManagedViewResponder($0) }
    }
    
    public func removeManagedViewRespondersFromView(_ view: UIView) {
        let viewResponders = view.subviews.filter{ $0.canBecomeFirstResponder }.map{ ViewResponder(responder: $0, associatedView: view) }
        viewResponders.forEach{ removeManagedViewResponder($0) }
    }
    
    public func insertManagedViewResponderFromView(_ view: UIView, atIndex index: Int) {
        let viewResponders = view.subviews.filter{ $0.canBecomeFirstResponder }.map{ ViewResponder(responder: $0, associatedView: view) }
        var index = index
        viewResponders.forEach{
            insertManagedViewResponder($0, atIndex: index)
            index += 1
        }
    }
    
    // MARK: Private Methods
    
    private func addManagedViewResponder(_ managedViewResponder: ViewResponder) {
        viewResponders.append(managedViewResponder)
    }
    
    private func removeManagedViewResponder(_ managedViewResponder: ViewResponder) {
        guard let index = viewResponders.index(where: { $0.responder == managedViewResponder.responder }) else { return }
        viewResponders.remove(at: index)
    }
    
    private func insertManagedViewResponder(_ managedViewResponder: ViewResponder, atIndex index: Int) {
        guard index <= viewResponders.count && index >= 0 else { fatalError("index out of range") }
        viewResponders[index] = managedViewResponder
    }
}
