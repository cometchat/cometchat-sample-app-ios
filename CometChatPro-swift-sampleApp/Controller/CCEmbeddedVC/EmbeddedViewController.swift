//
//  EmbeddedViewController.swift
//  CometChatUI
//
//  Created by pushpsen airekar on 18/11/18.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.
//

import UIKit
import CometChatPro

class EmbeddedViewController: UIViewController{
    
    //Outlets Declarations
    
    // Variable Declarations
    var groupsArray:Array<Group>!
    var groupRequest:GroupsRequest!
    var usersArray:Array<User>!
    var userRequest:UsersRequest!
    var usersArray1:Array<User>!
    private let limit = 10
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CometChat.calldelegate = self
        
    }
}

// Calling Delegates 

extension EmbeddedViewController : CometChatCallDelegate {
    
    func onIncomingCallReceived(incomingCall: Call?, error: CometChatException?) {
        
        CometChatLog.print(items:" Incoming call " + incomingCall!.stringValue());
        
        DispatchQueue.main.async {
            
            if incomingCall != nil && incomingCall?.receiverType == .user {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                
                if let CallingViewController = storyBoard.instantiateViewController(withIdentifier: "callingViewController") as? CallingViewController {
                    
                    CallingViewController.receivedCall = incomingCall
                    if let callInitiator = (incomingCall!.callInitiator as? User) {
                        
                        CallingViewController.callingString = "Incoming Call"
                        CallingViewController.userNameString = callInitiator.name
                        CallingViewController.isIncoming = true
                        CallingViewController.isGroupCall = false
                        if(incomingCall?.callType.rawValue == 1){
                            CallingViewController.isAudioCall = "0"
                        }else{
                            CallingViewController.isAudioCall = "1"
                        }
                        CallingViewController.avtarURLString = callInitiator.avatar
                    }
                    
                    self.present(CallingViewController, animated: true, completion: { () in
                        
                    })
                }
            }else if incomingCall != nil && incomingCall?.receiverType == .group{
                
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                
                if let CallingViewController = storyBoard.instantiateViewController(withIdentifier: "callingViewController") as? CallingViewController {
                    
                    CallingViewController.receivedCall = incomingCall
                    
                    if let callReceiver = (incomingCall!.callReceiver as? Group) {
                        
                        CallingViewController.callingString = "Incoming Call"
                        CallingViewController.userNameString = callReceiver.name
                        CallingViewController.isIncoming = true
                        CallingViewController.isGroupCall = true
                        if(incomingCall?.callType.rawValue == 1){
                            CallingViewController.isAudioCall = "0"
                        }else{
                            CallingViewController.isAudioCall = "1"
                        }
                        CallingViewController.avtarURLString = callReceiver.icon
                    }
                    self.present(CallingViewController, animated: true, completion: { () in
                        
                    })
                }
            }
        }
    }
    
    
    
    
    
    func onOutgoingCallAccepted(acceptedCall: Call?, error: CometChatException?) {
        
        CometChatLog.print(items:"onOutgoingCallAccepted \(String(describing: acceptedCall?.stringValue()))");
        guard let sessionID = acceptedCall?.sessionID else {
            return;
        }
        
        self.dismiss(animated: true, completion: nil)
        
        CometChat.startCall(sessionID: sessionID, inView:self.view, userJoined: { (someone_joined) in
            
            CometChatLog.print(items:someone_joined as Any)
            
        }, userLeft: { (some_one_left) in
            
            CometChatLog.print(items:some_one_left as Any)
            
        }, onError: { (error) in
            
            CometChatLog.print(items:error as Any)
            
        }) { (ended_call) in
            
            if((self.presentingViewController) != nil){
                self.dismiss(animated: false, completion: nil)
                
            }
        }
    }
    
    func onOutgoingCallRejected(rejectedCall: Call?, error: CometChatException?) {
       
        if((self.presentingViewController) != nil){
            self.dismiss(animated: false, completion: nil)
        }
        CometChatLog.print(items: rejectedCall?.stringValue() as Any)
    }
    
    func onIncomingCallCancelled(canceledCall: Call?, error: CometChatException?) {
        
        if((self.presentingViewController) != nil){
            self.dismiss(animated: false, completion: nil)
            print("cancel")
        }
        CometChatLog.print(items: canceledCall?.stringValue() as Any)
    }
    
}






