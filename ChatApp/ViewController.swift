//
//  ViewController.swift
//  ChatApp
//
//  Created by user220390 on 24/02/1401 AP.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    // UIparams
    @IBOutlet weak var powerSwitch: UISwitch!
    @IBOutlet weak var NameTextFiled: UITextField!
    @IBOutlet weak var MessageTextFiled: UITextField!
    @IBOutlet weak var SendButton: UIButton!
    @IBOutlet weak var ScrollStack: UIStackView!
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var ScrollView: UIScrollView!
    
    
    // jenral params
    var ref: DatabaseReference!
    var jsonEncoder: JSONEncoder = JSONEncoder()
    var jsonDecoder: JSONDecoder = JSONDecoder()
    var messagesView = [String : MessageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.SendButton.isUserInteractionEnabled = true
        // Add listner to power value in serevr
        ref.child("power").observe(.value, with: {(snapshot) in
            if let serverPower = snapshot.value as? Bool {
                self.powerSwitch?.setOn(serverPower, animated: true)
                if serverPower == true {
                    self.clearMessagesView()
                    self.SendButton.isUserInteractionEnabled = true
                }
                else{
                    self.SendButton.isUserInteractionEnabled = false
                }
            }
        })
        
        // Add listner to messages list in server
        ref.child("messages").observe(.value, with: {(snapshot) in
            if let messages = snapshot.value as? Dictionary<String, [String:String]>{
                messages.forEach { id, messageDict in
                    print(id, messageDict)
                    if !self.messagesView.keys.contains(id){
                        let newMessage = Message.init(dict: messageDict)
                        self.addMessageView(message: newMessage, id: id)
                    }
                }
                self.messagesView.forEach { id, view in
                    if !messages.keys.contains(id){
                        view.removeFromSuperview()
                    }
                }
            }
            else{
                print("invalid")
            }
            
        })
    }
    
    
    @IBAction func SwitchChanged(_ sender: Any) {
        ref.child("power").setValue(powerSwitch.isOn)
        if powerSwitch.isOn{
            clearMessagesView()
            ref.child("messages").removeValue()
            SendButton.isUserInteractionEnabled = true
        }
        else{
            SendButton.isUserInteractionEnabled = false
        }
    }
    
    
    @IBAction func SendMessage(_ sender: Any) {
        let senderName = NameTextFiled.text ?? ""
        let content = MessageTextFiled.text ?? ""
        
        
        
        if senderName != "" && content != "" {
            let messageId = ref.child("messages").childByAutoId().key!
            let message = Message.init(senderName: senderName, content: content)
            addMessageView(message: message, id: messageId)
            ref.child("messages").childByAutoId().setValue(message.toDict())
        }
        else{
            ErrorLabel.text = "Can't leave filldes empty."
        }
    }
    
    func addMessageView(message: Message, id: String) {
        let messageView = message.CreateView()
        messageView.frame = view.bounds
        messageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        ScrollStack.addArrangedSubview(messageView)
        NSLayoutConstraint.activate([
            messageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            messageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
            ])
        messageView.arangeTextViews()
        messagesView[id] = messageView
        let bottomOffset = CGPoint(x: 0, y: ScrollView.contentSize.height - ScrollView.bounds.height + ScrollView.contentInset.bottom)
        ScrollView.setContentOffset(bottomOffset, animated: true)
    }
    
    func clearMessagesView(){
        self.messagesView.values.forEach { view in
            view.removeFromSuperview()
        }
    }
    
}


