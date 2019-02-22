//
//  RSTextViewMaster.swift
//  RSTextViewMaster
//
//  Created by Radu Ursache (RanduSoft)
//  Based on jeasungLEE's TextViewMaster (https://github.com/JeaSungLEE/TextViewMaster)
//  Copyright © 2019 RanduSoft. All rights reserved.
//

import UIKit

@objc public protocol RSTextViewMasterDelegate: UITextViewDelegate {
    @objc optional func growingTextView(growingTextView: RSTextViewMaster, shouldChangeTextInRange range:NSRange, replacementText text:String) -> Bool
    @objc optional func growingTextViewShouldReturn(growingTextView: RSTextViewMaster)
    
    @objc optional func growingTextView(growingTextView: RSTextViewMaster, willChangeHeight height:CGFloat)
    @objc optional func growingTextView(growingTextView: RSTextViewMaster, didChangeHeight height:CGFloat)
}

public class RSTextViewMaster: UITextView, UIScrollViewDelegate {
    public var isAnimate: Bool = true
    public var maxLength: Int = 0
    public var minHeight: CGFloat = 0
    public var maxHeight: CGFloat = 0
    
    public var placeHolder: String = ""
    public var placeHolderFont: UIFont = UIFont.systemFont(ofSize: 17)
    public var placeHolderColor: UIColor = UIColor(white: 0.8, alpha: 1.0)
    public var placeHolderTopPadding: CGFloat = 0
    public var placeHolderBottomPadding: CGFloat = 0
    public var placeHolderRightPadding: CGFloat = 5
    public var placeHolderLeftPadding: CGFloat = 5
    
    private weak var heightConstraint: NSLayoutConstraint?
    private var previousRect = CGRect.zero
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        contentMode = .redraw
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidEndEditing), name: UITextView.textDidEndEditingNotification, object: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        let height = self.checkHeightConstraint()
        self.setNewHieghtConstraintConstant(with: height)
        
        if self.isAnimate {
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: { [weak self] in
                guard let self = self, let delegate = self.delegate as? RSTextViewMasterDelegate else { return }
                delegate.growingTextView?(growingTextView: self, willChangeHeight: height)
                
                if self.isScrolling() {
                    self.scrollToBottom()
                }
                
            }) { [weak self] _ in
                guard let self = self, let delegate = self.delegate as? RSTextViewMasterDelegate else { return }
                delegate.growingTextView?(growingTextView: self, didChangeHeight: height)
            }
        } else {
            guard let delegate = delegate as? RSTextViewMasterDelegate else { return }
            delegate.growingTextView?(growingTextView: self, willChangeHeight: height)
            
            if self.isScrolling() {
                self.scrollToBottom()
            }
            
            delegate.growingTextView?(growingTextView: self, didChangeHeight: height)
        }
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        if text.isEmpty {
            self.drawPlaceHolder(rect)
        }
    }
}

extension RSTextViewMaster {
    private func isScrolling() -> Bool {
        if let constant = self.heightConstraint?.constant, constant < self.maxHeight + 1 {
            return true
        }
        
        return false
    }
    
    private func checkHeightConstraint() -> CGFloat {
        let height = self.getHeight()
        
        if self.heightConstraint == nil {
            self.setHeightConstraint(with: height)
        }
        
        return height
    }
    
    private func setNewHieghtConstraintConstant(with constant: CGFloat) {
        guard constant != self.heightConstraint?.constant else { return }
        self.heightConstraint?.constant = constant
    }
    
    private func getHeight() -> CGFloat {
        let size = sizeThatFits(CGSize(width: bounds.size.width, height: CGFloat.greatestFiniteMagnitude))
        var height = size.height
        
        height = self.minHeight > 0 ? max(height, self.minHeight) : height
        height = self.maxHeight > 0 ? min(height, self.maxHeight) : height
        
        return height
    }
    
    private func setHeightConstraint(with height: CGFloat) {
        self.heightConstraint = self.heightAnchor.constraint(equalToConstant: height)
        self.addConstraint(self.heightConstraint!)
    }
    
    private func scrollToBottom() {
        let bottom = self.contentSize.height - self.bounds.size.height
        self.setContentOffset(CGPoint(x: 0, y: bottom), animated: false)
    }
    
    private func getPlaceHolderAttribues() -> [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        var attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeHolderColor,
            .paragraphStyle: paragraphStyle
        ]
        attributes[.font] = placeHolderFont
        
        return attributes
    }
    
    private func drawPlaceHolder(_ rect: CGRect) {
        let xValue = textContainerInset.left + self.placeHolderLeftPadding
        let yValue = textContainerInset.top + self.placeHolderTopPadding
        let width = rect.size.width - xValue - (textContainerInset.right + self.placeHolderRightPadding)
        let height = rect.size.height - yValue - (textContainerInset.bottom + self.placeHolderBottomPadding)
        let placeHolderRect = CGRect(x: xValue, y: yValue, width: width, height: height)
        
        guard let gc = UIGraphicsGetCurrentContext() else { return }
        gc.saveGState()
        defer { gc.restoreGState() }
        
        self.placeHolder.draw(in: placeHolderRect, withAttributes: getPlaceHolderAttribues())
    }
}

extension RSTextViewMaster {
    @objc private func textDidEndEditing(notification: Notification) {
        self.scrollToBottom()
    }
    
    @objc private func textDidChange(notification: Notification) {
        
        if let sender = notification.object as? RSTextViewMaster, sender == self {
            if self.maxLength > 0 && text.count > self.maxLength {
                let endIndex = text.index(text.startIndex, offsetBy: self.maxLength)
                text = String(text[..<endIndex])
                undoManager?.removeAllActions()
            }
            
            self.setNeedsDisplay()
        }
        
        let pos = self.endOfDocument
        let currentRect = self.caretRect(for: pos)
        self.previousRect = self.previousRect.origin.y == 0.0 ? currentRect : previousRect
        if (currentRect.origin.y > previousRect.origin.y) {
            if self.isScrolling() {
                self.flashScrollIndicators()
            }
        }
        previousRect = currentRect
    }
}

extension RSTextViewMaster: RSTextViewMasterDelegate {
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard textView.hasText || text != "" else { return false }
        if let delegate = delegate as? RSTextViewMasterDelegate {
            guard let value = delegate.growingTextView?(growingTextView: self, shouldChangeTextInRange: range, replacementText: text) else { return false }
            return value
        }
        
        if text == "\n" {
            if let delegate = delegate as? RSTextViewMasterDelegate {
                delegate.growingTextViewShouldReturn?(growingTextView: self)
                return true
            } else {
                textView.resignFirstResponder()
                return false
            }
        }
        
        return true
    }
}
