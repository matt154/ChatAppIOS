//
//  MessageView.swift
//  ChatApp
//
//  Created by user220390 on 28/02/1401 AP.
//

import UIKit

class MessageView: UIView{
    
    @IBOutlet weak var SenderName: UITextView!
    @IBOutlet weak var Content: UITextView!
    @IBOutlet weak var SenderOSType: UILabel!
    @IBOutlet weak var Time: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        let bundel = Bundle.init(for: MessageView.self)
        if let viewToAdd = bundel.loadNibNamed("MessageView", owner: self), let contentView = viewToAdd.first as? UIView {
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(contentView)
        }
    }
    
    func arangeTextViews(){
        adjustUITextViewHeight(arg: Content)
        adjustUITextViewHeight(arg: Time)
        adjustUITextViewHeight(arg: SenderName)
    }
}

func adjustUITextViewHeight(arg : UITextView) {
    arg.translatesAutoresizingMaskIntoConstraints = true
    arg.sizeToFit()
    arg.isScrollEnabled = false
    arg.layer.masksToBounds = true
}

