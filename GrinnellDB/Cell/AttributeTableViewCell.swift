//
//  AttributeTableViewCell.swift
//  GrinnellDB
//
//  Created by Zixuan on 9/20/19.
//  Copyright © 2019 Zixuan. All rights reserved.
//

import UIKit

class AttributeTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.subtitle.lineBreakMode = .byWordWrapping
        self.subtitle.numberOfLines = 0
        
        self.subtitle.isCopyingEnabled = true
    }
}

/* source: https://github.com/alexandreos/UILabel-Copyable */
public extension UILabel {
    // MARK: - Custom Flags
    private struct AssociatedKeys {
        static var isCopyingEnabled: UInt8 = 0
        static var shouldUseLongPressGestureRecognizer: UInt8 = 1
        static var longPressGestureRecognizer: UInt8 = 2
    }

    /// Set this property to `true` in order to enable the copy feature. Defaults to `false`.
    @objc
    @IBInspectable var isCopyingEnabled: Bool {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.isCopyingEnabled, newValue, .OBJC_ASSOCIATION_ASSIGN)
            setupGestureRecognizers()
        }
        get {
            let value = objc_getAssociatedObject(self, &AssociatedKeys.isCopyingEnabled)
            return (value as? Bool) ?? false
        }
    }


    /// Used to enable/disable the internal long press gesture recognizer. Defaults to `true`.
    @IBInspectable var shouldUseLongPressGestureRecognizer: Bool {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.shouldUseLongPressGestureRecognizer, newValue, .OBJC_ASSOCIATION_ASSIGN)
            setupGestureRecognizers()
        }
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.shouldUseLongPressGestureRecognizer) as? Bool) ?? true
        }
    }

    @objc
    var longPressGestureRecognizer: UILongPressGestureRecognizer? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.longPressGestureRecognizer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.longPressGestureRecognizer) as? UILongPressGestureRecognizer
        }
    }
    
    // MARK: - UIResponder
    @objc
    override var canBecomeFirstResponder: Bool {
        return isCopyingEnabled
    }

    @objc
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        // Only return `true` when it's the copy: action AND the `copyingEnabled` property is `true`.
        return (action == #selector(self.copy(_:)) && isCopyingEnabled)
    }

    @objc
    override func copy(_ sender: Any?) {
        if isCopyingEnabled {
            // Copy the label text
            let pasteboard = UIPasteboard.general
            pasteboard.string = text
        }
    }

    // MARK: - UI Actions
    @objc internal func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer === longPressGestureRecognizer && gestureRecognizer.state == .began {
            becomeFirstResponder()

            let copyMenu = UIMenuController.shared
            copyMenu.arrowDirection = .default
            if #available(iOS 13.0, *) {
                copyMenu.showMenu(from: self, rect: bounds)
            } else {
                // Fallback on earlier versions
                copyMenu.setTargetRect(bounds, in: self)
                copyMenu.setMenuVisible(true, animated: true)
            }
        }
    }

    // MARK: - Private Helpers
    fileprivate func setupGestureRecognizers() {
        // Remove gesture recognizer
        if let longPressGR = longPressGestureRecognizer {
            removeGestureRecognizer(longPressGR)
            longPressGestureRecognizer = nil
        }

        if shouldUseLongPressGestureRecognizer && isCopyingEnabled {
            isUserInteractionEnabled = true
            // Enable gesture recognizer
            let longPressGR = UILongPressGestureRecognizer(target: self,
                                                           action: #selector(longPressGestureRecognized(gestureRecognizer:)))
            longPressGestureRecognizer = longPressGR
            addGestureRecognizer(longPressGR)
        }
    }
}
