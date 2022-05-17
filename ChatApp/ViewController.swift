//
//  ViewController.swift
//  ChatApp
//
//  Created by user220390 on 24/02/1401 AP.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var ref: DatabaseReference!
    @IBOutlet weak var powerSwitch: UISwitch!
    
    @IBOutlet weak var NameTextFiled: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.child("power").observe(.value, with: {(snapshot) in
            if let serverPower = snapshot.value as? Bool {
                if self.powerSwitch == nil{
                    print("null")
                }
                else{
                    print("value")
                }
                print("server say \(serverPower)")
                self.powerSwitch?.setOn(serverPower, animated: true)
            }
        })
    }
    
    
    @IBAction func SwitchChanged(_ sender: Any) {
        ref.child("power").setValue(powerSwitch.isOn)
    }
    
    @IBAction func SwitchLoad(_ sender: Any){
        ref.child("power").observe(.value, with: {(snapshot) in
            if let serverPower = snapshot.value as? Bool {
                if self.powerSwitch == nil{
                    print("null")
                }
                else{
                    print("value")
                }
                print("server say \(serverPower)")
                self.powerSwitch?.setOn(serverPower, animated: true)
            }
        })
    }
}
