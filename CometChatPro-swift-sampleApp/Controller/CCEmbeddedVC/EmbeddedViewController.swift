//
//  EmbeddedViewController.swift
//  CometChatUI
//
//  Created by pushpsen airekar on 18/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
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
     
        print("I m in onIncomingCallReceived");
        
                var isAudioCall:Bool!
                print(" Incoming call " + incomingCall!.stringValue());
                print("incomingCall?.callType.rawValue \(String(describing: incomingCall?.callType.rawValue))")
        
                if(incomingCall?.callType.rawValue == 1){
                    print("I m in videoCall");
                    isAudioCall = false
                }else{
                     print("I m in audioCall");
                    isAudioCall = true
                }
        
                DispatchQueue.main.async {
        
                    if incomingCall != nil {
        
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
                        if let CallingViewController = storyBoard.instantiateViewController(withIdentifier: "callingViewController") as? CallingViewController {
        
                            CallingViewController.receivedCall = incomingCall
        
                           self.present(CallingViewController, animated: true, completion: { () in
        
                            if let callInitiator = (incomingCall!.callInitiator as? User) {
        
                                    CallingViewController.callingString = "Incoming Call"
                                    CallingViewController.userNameString = callInitiator.name
                                    CallingViewController.isIncoming = true
                                    CallingViewController.isAudioCall = isAudioCall
                                    CallingViewController.avtarURLString = callInitiator.avatar
                                print("Callinitialtor avtar: \(String(describing: callInitiator.avatar))")
                                }
                            })
                        }
                     }
                  }
    }
    

    
   
    
    func onOutgoingCallAccepted(acceptedCall: Call?, error: CometChatException?) {
        print(#function);
        
        print("I m in onOutgoingCallAccepted");
                guard let sessionID = acceptedCall?.sessionID else {
                    return;
                }
        
                        self.dismiss(animated: true, completion: nil)
                        print("Call onOutgoingCallAccepted present ")
        
                        CometChat.startCall(sessionID: sessionID, inView:self.view, userJoined: { (someone_joined) in
        
                            print(someone_joined as Any)
        
                        }, userLeft: { (some_one_left) in
        
                            print(some_one_left as Any)
        
                        }, onError: { (error) in
        
                            print(error as Any)
        
                        }) { (ended_call) in
        
                            DispatchQueue.main.async {
        
                                UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        
                            }
                        }
    }
    
    func onOutgoingCallRejected(rejectedCall: Call?, error: CometChatException?) {
        print(#function);
    }
    
    func onIncomingCallCancelled(canceledCall: Call?, error: CometChatException?) {
        print(#function);
    }
    
}
    





