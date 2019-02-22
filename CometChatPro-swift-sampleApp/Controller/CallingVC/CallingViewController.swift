//
//  CallingViewController.swift
//  CometChatPulse-swift-sampleApp
//
//  Created by Admin1 on 02/01/19.
//  Copyright © 2019 Admin1. All rights reserved.


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
    var isAudioCall:Bool!
    var receiverUid:String!
    var aNewCall:Call! = nil
    var callType:CallType!
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
      
        //Function Calling
        
        if(isIncoming == false){
            callAcceptView.removeFromSuperview()
            callSpeakerView.removeFromSuperview()
             self.sendCallRequest()
        }
        self.handleCallingVCApperance()
        print("callerUID \(String(describing: callerUID))")
        print("isAudioCall \(isAudioCall)")
        
        
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
                            print("Capture device found")
                            beginSession()
                        }
                    }
                }
            }
        }
}
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
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
            print("error: \(error.localizedDescription)")
        }
       
        if(isAudioCall == false){
             print("isAudioCall No")
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            self.callingBackgroundImage.layer.addSublayer(previewLayer)
            previewLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            captureSession.startRunning()
        }else{
             print("isAudioCall YEs")
            callingBackgroundImage.image = userAvtarImage
            callingBackgroundImage.addBlur()
        }
       
    }


    
    func sendCallRequest(){
       
        if(isAudioCall == true && isGroupCall == false){
            print(" oneOnOneAudio sendCallRequest  ");
            aNewCall = Call(receiverId:callerUID!, callType: .audio, receiverType: .user)
        }else if (isAudioCall == true && isGroupCall == true){
             print(" groupAudio sendCallRequest  ");
            aNewCall = Call(receiverId:callerUID!, callType: .audio, receiverType: .group)
        }else if(isAudioCall == false && isGroupCall == false){
             print(" oneOnOneVideo sendCallRequest  ");
            aNewCall = Call(receiverId:callerUID!, callType: .video, receiverType: .user)
        }else if(isAudioCall == false && isGroupCall == true){
             print(" groupVideo sendCallRequest  ");
            aNewCall = Call(receiverId:callerUID!, callType: .video, receiverType: .group)
        }
        
        
        CometChat.initiateCall(call: aNewCall, onSuccess: { (ongoing_call) in
            print("sendCallRequest onSuccess: \(String(describing: ongoing_call))")
            print("sendCallRequest messageType: \(String(describing: ongoing_call?.messageType))")
            print("sendCallRequest callStatus: \(String(describing: ongoing_call?.callStatus))")
            print("sendCallRequest metaData: \(String(describing: ongoing_call?.metaData))")
        }) { (error) in
             print("sendCallRequest error: \(String(describing: error))")
        }  
    }
    
    func handleCallingVCApperance(){
        
        var url: NSURL!
        var data: NSData!
        userNameLabel.text = userNameString
        callingLabel.text = callingString
        if(avtarURLString == nil){
            avtarURLString = ""
        }else{
            url = NSURL(string: avtarURLString)
            
        }
        

        if(isIncoming == true && avtarURLString != nil){
            print("isIncoming confirmed")
            DispatchQueue.global().async {
                data = NSData(contentsOf: url as URL)
                DispatchQueue.main.async {
                    self.userAvtar.image = UIImage(data: data! as Data)
                }
            }
            print("setImageFromURl: \(String(describing: avtarURLString))")
//            self.userAvtar.downloaded(from: avtarURLString)
        }else{
            userAvtar.image = userAvtarImage
        }
    }
    
    @IBAction func rejectPressed(_ sender: Any) {
        print("rejectPressed")
        
         if(isIncoming == true){
        if let sesssionId = receivedCall?.sessionID {
            
            CometChat.rejectCall(sessionID: sesssionId, status: .rejected, onSuccess: { [weak self](call) in
                
                guard let strongSelf = self
                    else
                {
                    return
                }
                
                if let _ = call {
        
                    strongSelf.dismiss(animated: true, completion: nil)
                }
                
            }) { (error) in
                
                print("Error on ending call : \(String(describing: error?.errorDescription))")
            }
        }
         }else{
             self.dismiss(animated: true, completion: nil)
        }
         self.dismiss(animated: true, completion: nil)
 }
    

    @IBAction func acceptPressed(_ sender: Any) {
        
        if let sessionId = receivedCall?.sessionID {
            
            CometChat.acceptCall(sessionID: sessionId, onSuccess: { [weak self](call) in
                
                guard let strongSelf = self
                    else
                {
                    return
                }
                
                if let _ = call {
                    
                    CometChat.startCall(sessionID: sessionId, inView: strongSelf.view, userJoined: { (user_joined) in
                        
                        print("user joined : \(user_joined)")
                        
                    }, userLeft: { (user_left) in
                        
                        print("user left \(user_left)")
                        
                    }, onError: { (exception) in
                        
                        self?.dismiss(animated: true, completion: nil)
                        
                    }, callEnded: { [weak self](call_ended) in
                        
                        guard let strongSelf = self
                            else
                        {
                            return
                        }
                        
                        DispatchQueue.main.async {
                            
                            self?.dismiss(animated: true, completion: nil)
                            
                        }
                        
                        print("call ended : \(call_ended)")
                    })
                }
                
                }, onError: { (error) in
                    
                    print("Error in accepting call : \(error?.errorDescription)")
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
