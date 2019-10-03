//
//  CallingViewController.swift
//  CometChatPro-swift-sampleApp
//
//  Created by Pushpsen Airekar on 02/01/19.
//  Copyright © 2019 Pushpsen Airekar. All rights reserved.


import UIKit
import CometChatPro
import AVFoundation
import Foundation

class CallingViewController: UIViewController {
    
    //Outlets Declarations
    @IBOutlet weak var userAvtar: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var callingLabel: UILabel!
    @IBOutlet weak var callingBackgroundImage: UIImageView!
    @IBOutlet weak var callAcceptView: UIView!
    @IBOutlet weak var callSpeakerView: UIView!
    @IBOutlet weak var callRejectView: UIView!
    let captureSession = AVCaptureSession()
    let stillImageOutput = AVCaptureStillImageOutput()
    var previewLayer : AVCaptureVideoPreviewLayer?
    var captureDevice : AVCaptureDevice?
    
    //Variable Declarations:
    var userNameString:String!
    var callingString:String!
    var avtarURLString:String!
    var userAvtarImage:UIImage!
    var callerUID:String!
    var isAudioCall:String!
    var receiverUid:String!
    var aNewCall:Call! = nil
    var isIncoming:Bool!
    var isGroupCall:Bool!
    var inComingCall:Call!
    var receivedCall : Call?
    
    init(receivedCall : Call) {
        super.init(nibName: nil, bundle: nil)
        self.receivedCall = receivedCall
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assigning Delegate
        
        if(isIncoming == false){
            callAcceptView.removeFromSuperview()
            callSpeakerView.removeFromSuperview()
            self.sendCallRequest()
        }
        
        //Function Calling
        self.handleCallingVCApperance()
      
        
        // HandleCameraSession
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        if let devices = AVCaptureDevice.devices() as? [AVCaptureDevice]
        {
            for device in devices
            {
                if (device.hasMediaType(AVMediaType.video))
                {
                    if(device.position == AVCaptureDevice.Position.front)
                    {
                        captureDevice = device
                        if captureDevice != nil
                        {
                            beginSession()
                        }
                    }
                }
            }
        }
    }
    
   
    
    
   
    
   
    
    func beginSession()
    {
        do
        {
            try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice!))
            stillImageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
            if captureSession.canAddOutput(stillImageOutput)
            {
                captureSession.addOutput(stillImageOutput)
            }
        }
        catch
        {
            CometChatLog.print(items:"error: \(error.localizedDescription)")
        }
        
        if(isAudioCall == "0"){
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            self.callingBackgroundImage.layer.addSublayer(previewLayer)
            previewLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            captureSession.startRunning()
        }else{
            callingBackgroundImage.image = userAvtarImage
            callingBackgroundImage.addBlur()
        }
        
    }
    
    
    func sendCallRequest(){
        
        if(isAudioCall == "1" && isGroupCall == false){
            aNewCall = Call(receiverId:callerUID!, callType: .audio, receiverType: .user)
        }else if (isAudioCall == "1" && isGroupCall == true){
            aNewCall = Call(receiverId:callerUID!, callType: .audio, receiverType: .group)
        }else if(isAudioCall == "0" && isGroupCall == false){
            aNewCall = Call(receiverId:callerUID!, callType: .video, receiverType: .user)
        }else if(isAudioCall == "0" && isGroupCall == true){
            aNewCall = Call(receiverId:callerUID!, callType: .video, receiverType: .group)
        }
        
        
        CometChat.initiateCall(call: aNewCall, onSuccess: { (ongoing_call) in
            CometChatLog.print(items:"sendCallRequest onSuccess: \(String(describing: ongoing_call?.stringValue()))")
            self.aNewCall = ongoing_call
        }) { (error) in
            CometChatLog.print(items:"sendCallRequest error: \(String(describing: error.debugDescription))")
        }
    }
    
    func handleCallingVCApperance(){
        
        var url: NSURL!
        userNameLabel.text = userNameString
        callingLabel.text = callingString
        if(avtarURLString == nil){
            avtarURLString = ""
        }else{
            url = NSURL(string: avtarURLString)
            
        }
        self.callingBackgroundImage.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_user"))
        if(isIncoming == true && avtarURLString != nil){
            self.userAvtar.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_user"))
        }else{
            userAvtar.image = userAvtarImage
        }
    }
    
    @IBAction func rejectPressed(_ sender: Any) {
        
        if(isIncoming == true){
            if let sesssionId = receivedCall?.sessionID {
                
                CometChat.rejectCall(sessionID: sesssionId, status: .rejected, onSuccess: { [weak self](call) in
                    
                    CometChatLog.print(items:"rejectCall :\(String(describing: call?.stringValue()))")
                    guard let strongSelf = self
                        else
                    {
                        return
                    }
                    
                    if let _ = call {
                        DispatchQueue.main.async {
                             strongSelf.dismiss(animated: true, completion: nil)
                        }
                    }
                    
                }) { (error) in
                    
                    CometChatLog.print(items: "Error on ending call : \(String(describing: error?.errorDescription))")
                }
            }
        }else{
            
            CometChat.rejectCall(sessionID: aNewCall.sessionID!, status: .cancelled, onSuccess: { [weak self](call) in
                
                CometChatLog.print(items:"rejectCall :\(String(describing: call?.stringValue()))")
                guard let strongSelf = self
                    else
                {
                    return
                }
                if let _ = call {
                    DispatchQueue.main.async {
                                                strongSelf.dismiss(animated: true, completion: nil)
                    }
                }
                
            }) { (error) in
                
                CometChatLog.print(items: "Error on ending call : \(String(describing: error?.errorDescription))")
            }
        }
    }
    
    
    @IBAction func acceptPressed(_ sender: Any) {
        
        if let sessionId = receivedCall?.sessionID {
            
            CometChat.acceptCall(sessionID: sessionId, onSuccess: { [weak self](call) in
                
                if let _ = call {
                                              
                    CometChat.startCall(sessionID: sessionId, inView: self!.view, userJoined: { (user_joined) in
                        
                        CometChatLog.print(items: "user joined : \(String(describing: user_joined))")
                        
                    }, userLeft: { (user_left) in
                        
                        CometChatLog.print(items: "user left \(String(describing: user_left))")
                        
                    }, onError: { (exception) in
                        
                        self?.dismiss(animated: true, completion: nil)
                        
                    }, callEnded: { [weak self](call_ended) in
                        
                        guard self != nil
                            else
                        {
                            return
                        }
                        
                        DispatchQueue.main.async {
                            
                            self?.dismiss(animated: true, completion: nil)
                            
                        }
                        
                        CometChatLog.print(items: "call ended : \(String(describing: call_ended))")
                    })
                }
                
                }, onError: { (error) in
                    
                    CometChatLog.print(items: "Error in accepting call : \(String(describing: error?.errorDescription))")
            })
        
        }
    }
    
    
}


extension UIImageView{
    
    func setImageFromURl(stringImageUrl url: String){
        
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOf: url as URL) {
                self.image = UIImage(data: data as Data)
            }
        }
    }
}
