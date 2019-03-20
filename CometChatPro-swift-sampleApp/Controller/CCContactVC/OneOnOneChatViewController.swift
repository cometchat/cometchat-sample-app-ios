//
//  OneOnOneChatViewController.swift
//  CCPulse-CometChatUI-ios-master
//
//  Created by pushpsen airekar on 02/12/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit
import YPImagePicker
import AVFoundation
import AVKit
import Photos
import CometChatPro
import WebKit
import MobileCoreServices
import AudioToolbox
import QuickLook



class OneOnOneChatViewController: UIViewController,UITextViewDelegate,UITableViewDelegate, UITableViewDataSource, UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate,AVAudioPlayerDelegate,AVAudioRecorderDelegate,UIGestureRecognizerDelegate,QLPreviewControllerDataSource,QLPreviewControllerDelegate  {

    //Outlets Declarations:
    @IBOutlet weak var videoCallBtn: UIBarButtonItem!
    @IBOutlet weak var audioCallButton: UIBarButtonItem!
    @IBOutlet weak var attachmentBtn: UIButton!
    @IBOutlet weak var ChatViewBottomconstraint: NSLayoutConstraint!
    @IBOutlet weak var ChatViewWithComponents: UIView!
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var chatInputView: UITextView!
    @IBOutlet weak var chatTableview: UITableView!
    @IBOutlet weak var micButton: UIButton!
    
    // Variable Declarations
    var count = 10
    var buddyUID:String!
    var buddyNameString:String!
    var buddyStatusString:String!
    var isGroup:String!
    var groupScope:Int!
    var buddyAvtar:UIImage!
    var buddyName:UILabel!
    var buddyStatus:UILabel!
    let modelName = UIDevice.modelName
    var imagePicker = UIImagePickerController()
    var selectedItems = [YPMediaItem]()
    let selectedImageV = UIImageView()
    let pickButton = UIButton()
    let resultsButton = UIButton()
    var videoURL:URL!
    var audioURL:URL!
    var fileURL: URL?
    var messages:[Message]?
    var chatMessage = [Message]()
    var refreshControl: UIRefreshControl!
    var previewURL:String!
    fileprivate let textCellID = "textCCell"
    fileprivate let imageCellID = "imageCell"
    fileprivate let videoCellID = "videoCell"
    fileprivate let fileCellID = "fileCell"
    fileprivate let audioCellID = "audioCell"
    fileprivate let actionCellID = "actionCell"
    
    var soundRecorder : AVAudioRecorder!
    var soundPlayer : AVAudioPlayer!
    var fileName: String = "audioFile1.m4a"
    @IBOutlet weak var recordingLabel: UILabel!
    
    private var messageRequest:MessagesRequest!
    var docController: UIDocumentInteractionController!
    let previewQL = QLPreviewController()
    public typealias sendMessageResponse = (_ success:getSendMessageResponse? , _ error:CometChatException?) -> Void
    public typealias userMessageResponse = (_ user:getMessageResponse? , _ error:CometChatException?) ->Void
    public typealias groupMessageResponse = (_ group:[BaseMessage]? , _ error:CometChatException?) ->Void
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        chatTableview.addSubview(refreshControl)
        
        //Function Calling
        self.handleOneOnOneChatVCApperance()
        self.hideKeyboardWhenTappedOnTableView()
        self.chatView.layer.borderWidth = 1
        self.chatView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        self.chatView.layer.cornerRadius = 20.0
        self.chatView.clipsToBounds = true
        self.chatInputView.delegate = self
        chatInputView.text = "Type a message..."
        chatInputView.textColor = UIColor.lightGray
        
        chatTableview.delegate = self
        chatTableview.dataSource = self
        CometChat.messagedelegate = self
        CometChat.userdelegate = self
        CometChat.groupdelegate = self
        
        //registerCell
        chatTableview.register(ChatTextMessageCell.self, forCellReuseIdentifier: textCellID)
        chatTableview.register(ChatImageMessageCell.self, forCellReuseIdentifier: imageCellID)
        chatTableview.register(ChatVideoMessageCell.self, forCellReuseIdentifier: videoCellID)
        let fileNib = UINib.init(nibName: "ChatFileMessageCell", bundle: nil)
        self.chatTableview.register(fileNib, forCellReuseIdentifier: "fileCell")
        let audioNib  = UINib.init(nibName: "ChatAudioMessageCell", bundle: nil)
        self.chatTableview.register(audioNib, forCellReuseIdentifier: "audioCell")
        let actionNib  = UINib.init(nibName: "ChatActionMessageCell", bundle: nil)
        self.chatTableview.register(actionNib, forCellReuseIdentifier: "actionCell")
        
        //QickLookController
        previewQL.dataSource = self
        
        
        chatTableview.separatorStyle = .none
        
        if(isGroup == "1"){
            messageRequest = MessagesRequest.MessageRequestBuilder().set(GUID: buddyUID).set(limit: 20).build()
        }else{
            messageRequest = MessagesRequest.MessageRequestBuilder().set(UID: buddyUID).set(limit: 20).build()
        }
        
        fetchPreviousMessages(messageReq: messageRequest) { (message, error) in
            
//            self.messages = message?.messages ?? nil
//            self.chatMessage = (self.messages ?? nil)!
            
            guard  let sendMessage =  message?.messages else{
                return
            }
             self.chatMessage = sendMessage
            
            print("messages are: \(String(describing: self.messages))")
            DispatchQueue.main.async{
                self.chatTableview.reloadData()
            }
        }
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        setupRecorder()
        let audioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, mode: AVAudioSessionModeDefault, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        }catch{print("\(error)")}
    }
    
    
    @objc func refresh(_ sender: Any) {
        print("refreshing")
        
        
        fetchPreviousMessages(messageReq: messageRequest) { (message, error) in
            
            guard let messages = message else{
                return
            }
            let oldMessageArray =  messages.messages
            self.chatMessage.insert(contentsOf: oldMessageArray, at: 0)
            print("messages are added: \(String(describing: self.messages))")
            
            DispatchQueue.main.async{
                self.chatTableview.reloadData()
            }
        }
        
        refreshControl.endRefreshing()
        //  your code to refresh tableView
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func setupRecorder() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent(fileName)
        let recordSetting = [ AVFormatIDKey : kAudioFormatAppleLossless,
                              AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                              AVEncoderBitRateKey : 320000,
                              AVNumberOfChannelsKey : 2,
                              AVSampleRateKey : 44100.2] as [String : Any]
        
        do {
            soundRecorder = try AVAudioRecorder(url: audioFilename, settings: recordSetting )
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
        } catch {
            print(error)
        }
    }
    
    func setupPlayer() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer.volume = 1.0
            audioURL = audioFilename
            
        } catch {
            print(error)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        // playAudio.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // recordAudio.isEnabled = true
        //  playAudio.setTitle("Play", for: .normal)
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let myURL = url as URL
        print("import result : \(myURL)")
        
        sendMediaMessage(toUserUID: buddyUID, mediaURL: "\(myURL.absoluteString)", isGroup: isGroup, messageType: .file) { (message, error) in
            
            let sendMessage =  message?.messages
            print("here the fileMessage is \(String(describing: sendMessage))")
            self.chatMessage.append(sendMessage!)
            print("ChatMessageArray:\(self.chatMessage)")
            
            DispatchQueue.main.async{
                self.chatTableview.beginUpdates()
                self.chatTableview.insertRows(at: [IndexPath.init(row: self.chatMessage.count-1, section: 0)], with: .automatic)
                
                self.chatTableview.endUpdates()
                self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableViewScrollPosition.none, animated: true)
            }
        }
    }
    
    
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    func clickFunction(){
        
        let importMenu = UIDocumentMenuViewController(documentTypes: [kUTTypePDF as String], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)
    }
    
    func fetchPreviousMessages(messageReq:MessagesRequest, completionHandler:@escaping userMessageResponse) {
        
        messageReq.fetchPrevious(onSuccess: { (messages) in
            
            let userMessagesArray = messages
            print("messages fetchPrevious: \(String(describing: messages))")
            print("messages fetchPrevious Desc: \(String(describing: messages?.description))")
            
            do{
                let response = try getMessageResponse(myMessageData: userMessagesArray!)
                completionHandler(response,nil)
            }catch {}
        }) { (error) in
            completionHandler(nil,error)
            return
        }
    }
    
    
    func sendMessage(toUserUID: String, message : String ,isGroup : String,completionHandler:@escaping sendMessageResponse){
        
        var textMessage : TextMessage
        if(isGroup == "1"){
            textMessage = TextMessage(receiverUid: toUserUID, text: message, messageType: .text, receiverType: .group)
        }else {
            textMessage = TextMessage(receiverUid: toUserUID, text: message, messageType: .text, receiverType: .user)
        }
        
        CometChat.sendTextMessage(message: textMessage, onSuccess: { (message) in
            do {
                let response = try getSendMessageResponse(myMessageData: message)
                completionHandler(response, nil)
            } catch {}
        }) { (error) in
            completionHandler(nil,error)
        }
    }
    
    func sendMediaMessage(toUserUID: String, mediaURL : String ,isGroup : String, messageType: CometChat.MessageType ,completionHandler:@escaping sendMessageResponse){
        
        var mediaMessage : MediaMessage
        
        if(isGroup == "1"){
            mediaMessage = MediaMessage(receiverUid: toUserUID, fileurl: mediaURL, messageType: messageType, receiverType: .group)
        }else {
            mediaMessage = MediaMessage(receiverUid: toUserUID, fileurl: mediaURL, messageType: messageType, receiverType: .user)
        }
        
        CometChat.sendMediaMessage(message: mediaMessage, onSuccess: { (message) in
            
            print("sendMediaMessage onSuccess\(String(describing: (message as? MediaMessage)?.url))")
            do {
                let response = try getSendMessageResponse(myMessageData: message)
                completionHandler(response, nil)
            } catch {}
        }) { (error) in
            
            print("sendMediaMessage error\(String(describing: error))")
            
        }
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         print("viewDidAppear Chat")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear Chat")
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: NSNotification.Name(rawValue: "com.pushNotificationData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
         print("viewWillDisappear Chat")
         NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "com.pushNotificationData"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    // MARK: - Notification oberserver methods
    
    @objc func didBecomeActive() {
        print("view did become active")
       
    }
    
    @objc func willEnterForeground() {
        print("view will enter foreground")
    }
    
    @objc func onDidReceiveData(_ notification: Notification)
    {
        
        print("onDidReceiveData Called : \(notification.userInfo)")
        fetchPreviousMessages(messageReq: messageRequest) { (message, error) in
            
            guard let messages = message else{
                return
            }
            let oldMessageArray =  messages.messages
            self.chatMessage.insert(contentsOf: oldMessageArray, at: 0)
            print("messages are added: \(String(describing: self.messages))")
            
            DispatchQueue.main.async{
                self.chatTableview.reloadData()
            }
        }  
    }
    
    
    func handleOneOnOneChatVCApperance(){
        
        navigationController?.navigationBar.barTintColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_COLOR)
        
        // ViewController Appearance
        self.hidesBottomBarWhenPushed = true
        navigationController?.navigationBar.isTranslucent = false
        guard (UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView) != nil else {
            return
        }
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        } else {
            
        }
        // NavigationBar Buttons Appearance
        
        let backButtonImage = UIImageView(image: UIImage(named: "back_arrow"))
        backButtonImage.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let backBTN = UIBarButtonItem(image: backButtonImage.image,
                                      style: .plain,
                                      target: self,
                                      action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backBTN
        backBTN.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
        //Video Button:
        videoCallBtn.image =  UIImage.init(named: "video_call.png")
        videoCallBtn.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        
        //Audio Button:
        audioCallButton.image =  UIImage.init(named: "audio_call.png")
        audioCallButton.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        
        //Mic Button:
        micButton.setImage(#imageLiteral(resourceName: "micNormal"), for: .normal)
        let audioRecorder = UILongPressGestureRecognizer(target: self, action: #selector(audioRecord(_:)))
        micButton.addGestureRecognizer(audioRecorder)
        
        //Send button:
        switch AppAppearance{
        case .AzureRadiance:
            sendBtn.backgroundColor = UIColor.init(hexFromString: "0084FF")
        case .MountainMeadow:
            sendBtn.backgroundColor = UIColor.init(hexFromString: "0084FF")
        case .PersianBlue:
            sendBtn.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.BACKGROUND_COLOR)
        case .Custom:
            sendBtn.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.BACKGROUND_COLOR)
        }
    
        
        
        //BuddyAvtar Apperance
        let containView = UIView(frame: CGRect(x: -10 , y: 0, width: 38, height: 38))
        containView.backgroundColor = UIColor.white
        containView.layer.cornerRadius = 19
        containView.layer.masksToBounds = true
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageview.image = buddyAvtar
        imageview.contentMode = UIView.ContentMode.scaleAspectFill
        imageview.layer.cornerRadius = 19
        imageview.layer.masksToBounds = true
        containView.addSubview(imageview)
        let leftBarButton = UIBarButtonItem(customView: containView)
        self.navigationItem.leftBarButtonItems?.append(leftBarButton)
        
        //TitleView Apperance
        let  titleView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        
        self.navigationItem.titleView = titleView
        buddyName = UILabel(frame: CGRect(x:0,y: 3,width: 150 ,height: 21))
        buddyName.textColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_TITLE_COLOR)
        buddyName.textAlignment = NSTextAlignment.left
        
        buddyName.text = buddyNameString
        buddyName.font = UIFont(name: SystemFont.regular.value, size: 18)
        titleView.addSubview(buddyName)
        
        buddyStatus = UILabel(frame: CGRect(x:0,y: titleView.frame.origin.y + 22,width: 200,height: 21))
        
        switch AppAppearance {
            
        case .AzureRadiance:
            buddyStatus.textColor = UIColor.init(hexFromString: "3E3E3E")
        case .MountainMeadow:
            buddyStatus.textColor = UIColor.init(hexFromString: "3E3E3E")
        case .PersianBlue:
            buddyStatus.textColor = UIColor.init(hexFromString: "FFFFFF")
        case .Custom:
            buddyStatus.textColor = UIColor.init(hexFromString: "3E3E3E")
        }
        
        buddyStatus.textAlignment = NSTextAlignment.left
        buddyStatus.text = buddyStatusString
        buddyStatus.font = UIFont(name: SystemFont.regular.value, size: 12)
        titleView.addSubview(buddyStatus)
        titleView.center = CGPoint(x: 0, y: 0)
        
        
        // More Actions:
        let tapOnProfileAvtar = UITapGestureRecognizer(target: self, action: #selector(UserAvtarClicked(tapGestureRecognizer:)))
        imageview.isUserInteractionEnabled = true
        imageview.addGestureRecognizer(tapOnProfileAvtar)
        
        
        let tapOnTitleView = UITapGestureRecognizer(target: self, action: #selector(TitleViewClicked(tapGestureRecognizer:)))
        titleView.isUserInteractionEnabled = true
        titleView.addGestureRecognizer(tapOnTitleView)
        
    }
    
    @objc func backButtonPressed(){
        print("backButtonPressed")
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc func audioRecord(_ sender: UIGestureRecognizer){
        print("Long tap")
        
        var timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(UIMenuController.update), userInfo: nil, repeats: true)
        if sender.state == .ended {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            soundRecorder.stop()
            count = 0
            self.setupPlayer()
            print("UIGestureRecognizerStateEnded")
            micButton.setImage(#imageLiteral(resourceName: "micNormal"), for: .normal)
            recordingLabel.isHidden = true
            
            self.chatInputView.text = "Type a message..."
            let alertController = UIAlertController(
                title: "Send AudioFile", message: "Are you sure want to send this Audio note.", preferredStyle: .alert)
            let OkAction = UIAlertAction(title: "Send", style: .default
                , handler: { (UIAlertAction) in
                    
                    print("AudioURL is : \(String(describing: self.audioURL))")
                    self.sendMediaMessage(toUserUID: self.buddyUID, mediaURL:"\(String(describing: self.audioURL.absoluteString))", isGroup: self.isGroup, messageType: .audio, completionHandler: { (message, error) in
                        
                        let sendMessage =  message?.messages
                        print("here the audioMessage is \(String(describing: sendMessage))")
                        self.chatMessage.append(sendMessage!)
                        print("ChatMessageArray:\(self.chatMessage)")
                        
                        DispatchQueue.main.async {
                            self.chatTableview.beginUpdates()
                            self.chatTableview.insertRows(at: [IndexPath.init(row: self.chatMessage.count-1, section: 0)], with: .automatic)
                            
                            self.chatTableview.endUpdates()
                            self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableViewScrollPosition.none, animated: true)
                            self.chatInputView.text = ""
                        }
                    })
            })
            let defaultAction = UIAlertAction(
                title: "Cancel", style: .destructive, handler: nil)
            
            //you can add custom actions as well
            alertController.addAction(defaultAction)
            alertController.addAction(OkAction)
            
            
            present(alertController, animated: true, completion: nil)
            
            //Do Whatever You want on End of Gesture
        }
        else if sender.state == .began {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            soundRecorder.record()
            print("UIGestureRecognizerStateBegan.")
            micButton.setImage(#imageLiteral(resourceName: "micSelected"), for: .normal)
            self.chatInputView.text = ""
            recordingLabel.isHidden = false
            recordingLabel.text = "Recording..."
            
            //Do Whatever You want on Began of Gesture
        }
    }
    
    @objc func update() {
        if(count > 0) {
            count += 1
            recordingLabel.text = "Recording...   \(count)"
        }
    }
    
    
    @objc func UserAvtarClicked(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileAvtarViewController = storyboard.instantiateViewController(withIdentifier: "ccprofileAvtarViewController") as! CCprofileAvtarViewController
        navigationController?.pushViewController(profileAvtarViewController, animated: true)
        profileAvtarViewController.title = buddyNameString
        profileAvtarViewController.profileAvtar = buddyAvtar
        profileAvtarViewController.hidesBottomBarWhenPushed = true
    }
    
    
    @objc func TitleViewClicked(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let UserProfileViewController = storyboard.instantiateViewController(withIdentifier: "userProfileViewController") as! UserProfileViewController
        navigationController?.pushViewController(UserProfileViewController, animated: true)
        UserProfileViewController.title = "View Profile"
        UserProfileViewController.groupScope = groupScope
        UserProfileViewController.getUserProfileAvtar = buddyAvtar
        UserProfileViewController.getUserName = buddyName.text
        UserProfileViewController.getUserStatus = buddyStatus.text
        if (isGroup == "1") {
            UserProfileViewController.isDisplayType = "GroupView"
            UserProfileViewController.guid = buddyUID
        }
        else{
            UserProfileViewController.isDisplayType = "OneOneOneViewProfile"
            UserProfileViewController.guid = buddyUID
        }
        UserProfileViewController.hidesBottomBarWhenPushed = true
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let userinfo = notification.userInfo
        {
            let keyboardFrame = (userinfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            ChatViewBottomconstraint.constant = (keyboardFrame?.height)!
            //            if(modelName == "iPhone 5" || modelName == "iPhone 5s" || modelName == "iPhone 5c" || modelName == "iPhone SE" ){
            //                self.ChatViewWithComponents.frame.origin.y = keyboardFrame!.height + 60;
            //            }else if (modelName == "iPhone 6 Plus" || modelName == "iPhone 6s Plus" || modelName == "iPhone 7 Plus" || modelName == "iPhone 8 Plus"){
            //                self.ChatViewWithComponents.frame.origin.y = keyboardFrame!.height + 60;
            //            }else if(modelName == "iPhone XS Max"){
            //                self.ChatViewWithComponents.frame.origin.y = keyboardFrame!.height + 32;
            //            }else if (modelName == "iPhone X" || modelName == "iPhone XS") {
            //                print("I m in iphone x")
            //                self.ChatViewWithComponents.frame.origin.y = keyboardFrame!.height + 32;
            //            }else if(modelName == "iPhone XR"){
            //                self.ChatViewWithComponents.frame.origin.y = keyboardFrame!.height + 32;
            //            }else if(modelName == "iPad Pro (12.9-inch) (2nd generation)"){
            //                self.ChatViewWithComponents.frame.origin.y = keyboardFrame!.height + 60;
            //            }else{
            //                ChatViewBottomconstraint.constant = (keyboardFrame?.height)!
            //               // self.ChatViewWithComponents.frame.origin.y = keyboardFrame!.height + 60;
            //
            //            }
            
        }
        
        
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        print("In keyboardWillHide")
        if self.view.frame.origin.y != 0 {
            
            ChatViewBottomconstraint.constant = 0
            //            if(modelName == "iPhone 5" || modelName == "iPhone 5s" || modelName == "iPhone 5c" || modelName == "iPhone SE" ){
            //                self.view.frame.origin.y = 60
            //            }else if (modelName == "iPhone 6 Plus" || modelName == "iPhone 6s Plus" || modelName == "iPhone 7 Plus" || modelName == "iPhone 8 Plus"){
            //                self.view.frame.origin.y = 60
            //            }else if(modelName == "iPhone XS Max"){
            //                self.view.frame.origin.y = 32
            //            }else if (modelName == "iPhone X" || modelName == "iPhone XS") {
            //                print("I m in iphone x")
            //                self.view.frame.origin.y = 32
            //            }else if(modelName == "iPhone XR"){
            //                self.view.frame.origin.y = 32
            //            }else if(modelName == "iPad Pro (12.9-inch) (2nd generation)"){
            //                self.view.frame.origin.y = 60
            //            }else{
            //                ChatViewBottomconstraint.constant = 0
            //            }
        }
    }
    
    
    
    @objc override func dismissKeyboard() {
        chatInputView.resignFirstResponder()
        if self.view.frame.origin.y != 0 {
            
            ChatViewBottomconstraint.constant = 0
            //            if(modelName == "iPhone 5" || modelName == "iPhone 5s" || modelName == "iPhone 5c" || modelName == "iPhone SE" ){
            //                self.view.frame.origin.y = 60
            //            }else if (modelName == "iPhone 6 Plus" || modelName == "iPhone 6s Plus" || modelName == "iPhone 7 Plus" || modelName == "iPhone 8 Plus"){
            //                self.view.frame.origin.y = 60
            //            }else if(modelName == "iPhone XS Max"){
            //                self.view.frame.origin.y = 32
            //            }else if (modelName == "iPhone X" || modelName == "iPhone XS") {
            //                print("I m in iphone x")
            //                self.view.frame.origin.y = 32
            //            }else if(modelName == "iPhone XR"){
            //                self.view.frame.origin.y = 32
            //            }else if(modelName == "iPad Pro (12.9-inch) (2nd generation)"){
            //                self.view.frame.origin.y = 60
            //            }else{
            //                ChatViewBottomconstraint.constant = 0
            //            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if chatInputView.text != ""{
            chatInputView.text = ""
            chatInputView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if chatInputView.text == ""{
            chatInputView.text = "Type a message..."
            chatInputView.textColor = UIColor.lightGray
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessage.count
    }
    
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = UITableViewCell()
        
        let messageData = chatMessage[indexPath.row]
        
        if(messageData.messageType == "text"){
            
            var textMessageCell = ChatTextMessageCell()
            print("added textCell")
            
            textMessageCell = tableView.dequeueReusableCell(withIdentifier: textCellID, for: indexPath) as! ChatTextMessageCell
            textMessageCell.chatMessage = messageData
            textMessageCell.selectionStyle = .none
            return textMessageCell
            
        }else if(messageData.messageType == "image"){
            print("added imageCell")
            var imageMessageCell = ChatImageMessageCell()
            imageMessageCell = tableView.dequeueReusableCell(withIdentifier: imageCellID , for: indexPath) as! ChatImageMessageCell
            imageMessageCell.chatMessage = messageData
            let url = NSURL(string: messageData.messageText.decodeUrl()!)
            imageMessageCell.chatImage.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_Pending"))
            imageMessageCell.selectionStyle = .none
            return imageMessageCell
            
        }else if(messageData.messageType == "video"){
            
            print("added videoCell")
            var videoMessageCell = ChatVideoMessageCell()
            videoMessageCell = tableView.dequeueReusableCell(withIdentifier: videoCellID , for: indexPath) as! ChatVideoMessageCell
            videoMessageCell.chatMessage = messageData
            videoMessageCell.selectionStyle = .none
            
            return videoMessageCell
            
        }else if(messageData.messageType == "file"){
            
            print("added fileCell")
            var fileCell = ChatFileMessageCell()
            fileCell = tableView.dequeueReusableCell(withIdentifier: "fileCell" , for: indexPath) as! ChatFileMessageCell
            let filename: String = messageData.messageText.decodeUrl()!
            let pathExtention = filename.pathExtension
            let pathPrefix = filename.lastPathComponent
            fileCell.userNameLabel.text = "\(messageData.userName):"
            fileCell.fileNameLabel.text = pathPrefix
            fileCell.fileTypeLabel.text = pathExtention.uppercased()
            fileCell.timeLabel.text = messageData.time
            fileCell.timeLabel1.text = messageData.time
            fileCell.chatMessage = messageData
            fileCell.isSelf = messageData.isSelf
            fileCell.isGroup = messageData.isGroup
            fileCell.selectionStyle = .none
            let url = NSURL(string: messageData.avatarURL.decodeUrl()!)
            fileCell.userAvtar.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_user"))
            return fileCell
        }else if(messageData.messageType == "audio"){
            
            print("added audioCell")
            var audioCell = ChatAudioMessageCell()
            audioCell = tableView.dequeueReusableCell(withIdentifier: "audioCell" , for: indexPath) as! ChatAudioMessageCell
            audioCell.chatMessage = messageData
            let url = NSURL(string: messageData.avatarURL.decodeUrl()!)
            audioCell.userNameLabel.text = "\(messageData.userName):"
            audioCell.timeLabel.text = messageData.time
            audioCell.timeLabel1.text = messageData.time
            audioCell.userAvtar.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_user"))
            audioCell.selectionStyle = .none
            return audioCell
        }else if(messageData.messageType == "action"){
            print("added actionCell")
            var actionCell = ChatActionMessageCell()
            actionCell = tableView.dequeueReusableCell(withIdentifier: "actionCell" , for: indexPath) as! ChatActionMessageCell
            actionCell.actionMessageLabel.text = messageData.messageText
            actionCell.selectionStyle = .none
            return actionCell
        }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectisWorking")
        let messageData = chatMessage[indexPath.row]
        
        if(messageData.messageType == "image"){
            
            let url = NSURL.fileURL(withPath:messageData.messageText.decodeUrl()!)
            previewURL = messageData.messageText.decodeUrl();
            
            let fileExtention = url.absoluteString.pathExtension
            let pathPrefix = url.absoluteString.lastPathComponent
            let fileName = URL(fileURLWithPath: pathPrefix).deletingPathExtension().lastPathComponent
            let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension(fileExtention)
            print("filePath 111: \(fileURL!.path)")
            previewQL.currentPreviewItemIndex = indexPath.row
            show(previewQL, sender: nil)
        
        }else if(messageData.messageType == "video"){
            
            print("Calling from Video Cell")
            let videoURL = URL(string: messageData.messageText.decodeUrl()!)
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }else if(messageData.messageType == "file"){
            
            let url = NSURL.fileURL(withPath:messageData.messageText.decodeUrl()!)
            previewURL = messageData.messageText.decodeUrl();
            
            let fileExtention = url.absoluteString.pathExtension
            let pathPrefix = url.absoluteString.lastPathComponent
            let fileName = URL(fileURLWithPath: pathPrefix).deletingPathExtension().lastPathComponent
            let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension(fileExtention)
            print("filePath 111: \(fileURL!.path)")
            previewQL.currentPreviewItemIndex = indexPath.row
            show(previewQL, sender: nil)
        }
    }
    
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
    
        
        let filenameWithExtention = previewURL.lastPathComponent;
        
        let filename = getDocumentsDirectory().appendingPathComponent(filenameWithExtention);
    
        if !(FileManager.default.fileExists(atPath: filename.absoluteString)) {
            
            var fileData: Data? = nil
            let url = previewURL.decodeUrl()
           
            do{
                try fileData = Data(contentsOf: (URL(string:url ?? "")!))
                try fileData?.write(to: filename, options:.atomicWrite);
            }catch{
                print(error)
            }
        }
        
        return filename as QLPreviewItem

}

    
    @IBAction func sendButton(_ sender: Any) {
        print(chatInputView.text!)
        
        let message:String = chatInputView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(message.count == 0 || message == "Type a message..."){
            print("error encountered")
        }else{
            sendMessage(toUserUID: buddyUID, message: message, isGroup: isGroup) { (message, error) in
                print("here the message is \(String(describing: message?.messages))")
                
                guard  let sendMessage =  message?.messages else{
                    return
                }
                self.chatMessage.append(sendMessage)
                
                DispatchQueue.main.async{
                    self.chatTableview.reloadData()
                    self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableViewScrollPosition.none, animated: true)
                    self.chatInputView.text = ""
                }
            }
        }
    }
    
    @IBAction func micButtonPressed(_ sender: Any) {
        //The code is written in TapANdHoldGestureRecognizer
    }
    
    
    
    @IBAction func attachementButtonPressed(_ sender: Any) {
        
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction: UIAlertAction = UIAlertAction(title: "Camera", style: .default) { action -> Void in
            
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photoAndVideo
            config.wordings.cancel = "Cancel"
            config.wordings.next = "Next"
            config.wordings.videoTitle = "Video"
            config.wordings.albumsTitle = "Albums"
            config.wordings.libraryTitle = "Library"
            config.wordings.cameraTitle = "Camera"
            config.wordings.cover = "Cover"
            config.wordings.ok = "Ok"
            config.wordings.done = "Done"
            config.wordings.save = "Save"
            config.wordings.processing = "Processing"
            config.wordings.trim = "Trim"
            config.wordings.cover = "Cover"
            config.wordings.filter = "Filter"
            config.wordings.crop = "Crop"
            config.wordings.warningMaxItemsLimit = "Limit Reached"
            config.wordings.libraryTitle = "Gallery"
            
            config.shouldSaveNewPicturesToAlbum = false
            
            /* Choose the videoCompression. Defaults to AVAssetExportPresetHighestQuality */
            config.video.compression = AVAssetExportPresetMediumQuality
            config.startOnScreen = .library
            config.screens = [.photo,.video]
            config.video.libraryTimeLimit = 500.0
            config.showsCrop = .none
            config.hidesStatusBar = false
            config.hidesBottomBar = false
            config.library.maxNumberOfItems = 5
            
            let picker = YPImagePicker(configuration: config)
            
            /* Multiple media implementation */
            picker.didFinishPicking { [unowned picker] items, cancelled in
                
                if cancelled {
                    print("Picker was canceled")
                    picker.dismiss(animated: true, completion: nil)
                    return
                }
                _ = items.map { print("🧀 \($0)") }
                self.selectedItems = items
                if let firstItem = items.first {
                    switch firstItem {
                    case .photo(let photo):
                        self.selectedImageV.image = photo.image
                        let imageData = UIImagePNGRepresentation(photo.image)!
                        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                        let imageURL = docDir.appendingPathComponent("tmp.png")
                        try! imageData.write(to: imageURL)
                        picker.dismiss(animated: true, completion: nil)
                        
                        
                        self.sendMediaMessage(toUserUID: self.buddyUID, mediaURL: imageURL.absoluteString, isGroup: self.isGroup, messageType: .image, completionHandler: { (message, error) in
                            
                            let sendMessage =  message?.messages
                            print("here the imageMessage is \(String(describing: sendMessage))")
                            self.chatMessage.append(sendMessage!)
                            print("ChatMessageArray:\(self.chatMessage)")
                            
                            DispatchQueue.main.async{
                                self.chatTableview.beginUpdates()
                                self.chatTableview.insertRows(at: [IndexPath.init(row: self.chatMessage.count-1, section: 0)], with: .automatic)
                                
                                self.chatTableview.endUpdates()
                                self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableViewScrollPosition.none, animated: true)
                                self.chatInputView.text = ""
                            }
                        })
                    case .video(let video):
                        self.selectedImageV.image = video.thumbnail
                        let assetURL = video.url
                        self.videoURL = video.url
                        
                        picker.dismiss(animated: true, completion: { [weak self] in
                            print("😀 \(String(describing: self?.resolutionForLocalVideo(url: assetURL)!))")
                        })
                    }
                }
            }
            
            self.present(picker, animated: true, completion: nil)
            
        }
        cameraAction.setValue(UIImage(named: "camera.png"), forKey: "image")
        
        let photoLibraryAction: UIAlertAction = UIAlertAction(title: "Photo & Video Library", style: .default) { action -> Void in
            
            
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photoAndVideo
            config.wordings.cancel = "Cancel"
            config.wordings.next = "Next"
            config.wordings.videoTitle = "Video"
            config.wordings.albumsTitle = "Albums"
            config.wordings.libraryTitle = "Library"
            config.wordings.cameraTitle = "Camera"
            config.wordings.cover = "Cover"
            config.wordings.ok = "Ok"
            config.wordings.done = "Done"
            config.wordings.save = "Save"
            config.wordings.processing = "Processing"
            config.wordings.trim = "Trim"
            config.wordings.cover = "Cover"
            config.wordings.filter = "Filter"
            config.wordings.crop = "Crop"
            config.wordings.warningMaxItemsLimit = "Limit Reached"
            config.wordings.libraryTitle = "Gallery"
            
            config.shouldSaveNewPicturesToAlbum = false
            
            /* Choose the videoCompression. Defaults to AVAssetExportPresetHighestQuality */
            config.video.compression = AVAssetExportPresetMediumQuality
            config.startOnScreen = .library
            config.screens = [.library]
            config.video.libraryTimeLimit = 500.0
            config.showsCrop = .none
            config.hidesStatusBar = false
            config.hidesBottomBar = true
            config.library.maxNumberOfItems = 5
            
            let picker = YPImagePicker(configuration: config)
            
            /* Multiple media implementation */
            picker.didFinishPicking { [unowned picker] items, cancelled in
                
                if cancelled {
                    print("Picker was canceled")
                    picker.dismiss(animated: true, completion: nil)
                    return
                }
                _ = items.map { print("🧀 \($0)") }
                self.selectedItems = items
                if let firstItem = items.first {
                    switch firstItem {
                    case .photo(let photo):
                        self.selectedImageV.image = photo.image
                        let imageData = UIImagePNGRepresentation(photo.image)!
                        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                        let imageURL = docDir.appendingPathComponent("tmp.png")
                        try! imageData.write(to: imageURL)
                        picker.dismiss(animated: true, completion: nil)
                        
                        self.sendMediaMessage(toUserUID: self.buddyUID, mediaURL: imageURL.absoluteString, isGroup: self.isGroup, messageType: .image, completionHandler: { (message, error) in
                            
                            let sendMessage =  message?.messages
                            print("here the imageMessage is \(String(describing: sendMessage))")
                            self.chatMessage.append(sendMessage!)
                            print("ChatMessageArray:\(self.chatMessage)")
                            
                            DispatchQueue.main.async{
                                self.chatTableview.beginUpdates()
                                self.chatTableview.insertRows(at: [IndexPath.init(row: self.chatMessage.count-1, section: 0)], with: .automatic)
                                
                                self.chatTableview.endUpdates()
                                self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableViewScrollPosition.none, animated: true)
                                self.chatInputView.text = ""
                            }
                        })
                    case .video(let video):
                        self.selectedImageV.image = video.thumbnail
                        let assetURL = video.url
                        self.videoURL = video.url
                        
                        picker.dismiss(animated: true, completion: { [weak self] in
                            print("😀 \(String(describing: self?.resolutionForLocalVideo(url: assetURL)!))")
                            
                            self!.sendMediaMessage(toUserUID: (self?.buddyUID)!, mediaURL: assetURL.absoluteString, isGroup: (self?.isGroup)!, messageType: .video, completionHandler: { (message, error) in
                                let sendMessage =  message?.messages
                                print("here the video is \(String(describing: sendMessage))")
                                self!.chatMessage.append(sendMessage!)
                                print("ChatMessageArray:\(self!.chatMessage)")
                                
                                DispatchQueue.main.async{
                                    self!.chatTableview.beginUpdates()
                                    self!.chatTableview.insertRows(at: [IndexPath.init(row: self!.chatMessage.count-1, section: 0)], with: .automatic)
                                    
                                    self!.chatTableview.endUpdates()
                                    self?.chatTableview.scrollToRow(at: IndexPath.init(row: self!.chatMessage.count-1, section: 0), at: UITableViewScrollPosition.none, animated: true)
                                    
                                }
                                
                            })
                        })
                        
                    }
                }
            }
            self.present(picker, animated: true, completion: nil)
        }
        photoLibraryAction.setValue(UIImage(named: "gallery.png"), forKey: "image")
        
        let documentAction: UIAlertAction = UIAlertAction(title: "Document", style: .default) { action -> Void in
            
            self.clickFunction()
            
        }
        documentAction.setValue(UIImage(named: "document.png"), forKey: "image")
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        actionSheetController.addAction(cameraAction)
        actionSheetController.addAction(photoLibraryAction)
        actionSheetController.addAction(documentAction)
        actionSheetController.addAction(cancelAction)
        
        if self.view.frame.origin.y != 0 {
            dismissKeyboard()
            present(actionSheetController, animated: true, completion: nil)
        }else{
            present(actionSheetController, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func audioCallPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CallingViewController = storyboard.instantiateViewController(withIdentifier: "callingViewController") as! CallingViewController
        CallingViewController.isAudioCall = "1"
        presentCalling(CallingViewController: CallingViewController)
        
    }
    @IBAction func videoCallPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CallingViewController = storyboard.instantiateViewController(withIdentifier: "callingViewController") as! CallingViewController
        CallingViewController.isAudioCall = "0"
        presentCalling(CallingViewController: CallingViewController);
        
    }
    
    func presentCalling(CallingViewController:CallingViewController) -> Void {
        CallingViewController.userAvtarImage = buddyAvtar
        CallingViewController.callingString = "Calling ..."
        CallingViewController.userNameString = buddyName.text
        CallingViewController.isIncoming = false
        CallingViewController.callerUID = buddyUID
        if(isGroup == "1"){
            CallingViewController.isGroupCall = true
        }else{
            CallingViewController.isGroupCall = false
        }
        self.present(CallingViewController, animated: true, completion: nil)
    }
    
    
    func hideKeyboardWhenTappedOnTableView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        chatTableview.addGestureRecognizer(tap)
    }
    
    
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
       
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        DispatchQueue.global(qos: .background).async {
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(1, 60) , actualTime: nil)
            DispatchQueue.main.async{
            return UIImage(cgImage: thumbnailImage)
            }
        } catch let error {
            print(error)
        }
        }
        return nil
    }
    
}

extension OneOnOneChatViewController : CometChatMessageDelegate {
    
    func onTextMessageReceived(textMessage: TextMessage?, error: CometChatException?) {
        
        switch textMessage!.messageCategory{
            
        case .message:
            print("Mesage is : \(String(describing: textMessage?.stringValue()))")
            
            var messageDict = [String : Any]()
            let date = Date(timeIntervalSince1970: TimeInterval(textMessage!.sentAt))
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "HH:mm a"
            dateFormatter1.timeZone = NSTimeZone.local
            let dateString : String = dateFormatter1.string(from: date)
            print("formatted date is =  \(dateString)")
            if(textMessage!.receiverType == CometChat.ReceiverType.group){
                messageDict["isGroup"] = true
            }else {
                messageDict["isGroup"] = false
            }
            messageDict["userID"] = textMessage!.receiverUid
            messageDict["userName"] = textMessage?.sender?.name
            messageDict["messageText"] = textMessage!.text
            messageDict["isSelf"] = false
            messageDict["time"] = dateString
            messageDict["messageType"] = "text"
            messageDict["avatarURL"] = textMessage?.sender?.avatar
            print("MessageDict \(messageDict)")
            
            print("buddyUID: \(String(describing: buddyUID))")
            print("receiverUid: \(textMessage!.receiverUid)")
            //if(buddyUID! == "\(textMessage!.sender?.uid)"){
            print("Iserting text Message")
            let receivedMessage = Message(dict: messageDict)
            self.chatMessage.append(receivedMessage!)
            
            DispatchQueue.main.async{
                self.chatTableview.reloadData()
                self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableViewScrollPosition.none, animated: true)
            }
        // }
        case .action:
            
            
            if let actionMessage = (textMessage as? ActionMessage){
                print("action Message is : \(String(describing: actionMessage.message))")
                var messageDict = [String : Any]()
                let date = Date(timeIntervalSince1970: TimeInterval(actionMessage.sentAt))
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "HH:mm a"
                
                dateFormatter1.timeZone = NSTimeZone.local
                let dateString : String = dateFormatter1.string(from: date)
                print("formatted date is =  \(dateString)")
                
                if(actionMessage.receiverType == CometChat.ReceiverType.group){
                    messageDict["isGroup"] = true
                }else {
                    messageDict["isGroup"] = false
                }
                messageDict["userID"] = actionMessage.receiverUid
                messageDict["userName"] = actionMessage.sender?.name
                messageDict["messageText"] = actionMessage.message
                messageDict["isSelf"] = false
                messageDict["time"] = dateString
                messageDict["messageType"] = "action"
                messageDict["avatarURL"] = actionMessage.sender?.avatar
                print("MessageDict \(messageDict)")
                
                print("buddyUID: \(String(describing: buddyUID))")
                print("receiverUid: \(textMessage!.receiverUid)")
                //if(buddyUID! == "\(textMessage!.sender?.uid)"){
                print("Iserting text Message")
                let receivedMessage = Message(dict: messageDict)
                self.chatMessage.append(receivedMessage!)
                
                DispatchQueue.main.async{
                    self.chatTableview.reloadData()
                    //                    self.chatTableview.beginUpdates()
                    //                    self.chatTableview.insertRows(at: [IndexPath.init(row: self.chatMessage.count-1, section: 0)], with: .automatic)
                    //
                    //                    self.chatTableview.endUpdates()
                    self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableViewScrollPosition.none, animated: true)
                }
            }
        case .call: break
            
        }
        
    }
    
    func onMediaMessageReceived(mediaMessage: MediaMessage?, error: CometChatException?)
    {
        var messageDict = [String : Any]()
        let date = Date(timeIntervalSince1970: TimeInterval(mediaMessage!.sentAt))
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "HH:mm a"
        
        dateFormatter1.timeZone = NSTimeZone.local
        let dateString : String = dateFormatter1.string(from: date)
        print("formatted date is =  \(dateString)")
        
        if(mediaMessage!.receiverType == CometChat.ReceiverType.group){
            messageDict["isGroup"] = true
        }else {
            messageDict["isGroup"] = false
        }
        messageDict["userID"] = mediaMessage!.receiverUid
        messageDict["userName"] = mediaMessage?.sender?.name
        messageDict["messageText"] = (mediaMessage!.url?.decodeUrl())!
        messageDict["isSelf"] = false
        messageDict["time"] = dateString
        
        if(mediaMessage?.messageType == CometChat.MessageType.image){
            messageDict["messageType"] = "image"
        }else if(mediaMessage?.messageType == CometChat.MessageType.video){
            messageDict["messageType"] = "video"
        }else if(mediaMessage?.messageType == CometChat.MessageType.audio){
            messageDict["messageType"] = "audio"
        }else if(mediaMessage?.messageType == CometChat.MessageType.file){
            messageDict["messageType"] = "file"
        }else{
            messageDict["messageType"] = ""
        }
        messageDict["avatarURL"] = mediaMessage?.sender?.avatar
        print("MessageDict \(messageDict)")
        
        //  if(buddyUID == mediaMessage?.receiverUid){
        let receivedMessage = Message(dict: messageDict)
        self.chatMessage.append(receivedMessage!)
        
        DispatchQueue.main.async{
            self.chatTableview.beginUpdates()
            self.chatTableview.insertRows(at: [IndexPath.init(row: self.chatMessage.count-1, section: 0)], with: .automatic)
            
            self.chatTableview.endUpdates()
            self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableViewScrollPosition.none, animated: true)
        }
        
    }
}

extension OneOnOneChatViewController : CometChatGroupDelegate {
    
    func onGroupMemberJoined(action: ActionMessage, joinedUser: User, joinedGroup: Group) {
        
    }
    
    func onGroupMemberLeft(action: ActionMessage, leftUser: User, leftGroup: Group) {
        
    }
    
    func onGroupMemberKicked(action: ActionMessage, kickedUser: User, kickedBy: User, kickedFrom: Group) {
        
    }
    
    func onGroupMemberBanned(action: ActionMessage, bannedUser: User, bannedBy: User, bannedFrom: Group) {
        
    }
    
    func onGroupMemberUnbanned(action: ActionMessage, unbannedUser: User, unbannedBy: User, unbannedFrom: Group) {
        
    }
    
    func onGroupMemberScopeChanged(action: ActionMessage, user: User, scopeChangedTo: String, scopeChangedFrom: String, group: Group) {
        
    }
    
   
    
}

extension OneOnOneChatViewController : CometChatUserDelegate {
    
    func onUserOnline(user: User) {
        print("user is online")
        if user.uid == buddyUID{
            if user.status == "online" {
                buddyStatus.text = "Online"
            }
        }
    }
    
    func onUserOffline(user: User) {
        print("user is offline")
        if user.uid == buddyUID{
            if user.status == "offline" {
                buddyStatus.text = "Offline"
            }
        }
    }
    
}

extension OneOnOneChatViewController {
    /* Gives a resolution for the video by URL */
    func resolutionForLocalVideo(url: URL) -> CGSize? {
        guard let track = AVURLAsset(url: url).tracks(withMediaType: AVMediaType.video).first else { return nil }
        let size = track.naturalSize.applying(track.preferredTransform)
        return CGSize(width: abs(size.width), height: abs(size.height))
    }
}


extension String {
    var fileURL: URL {
        return URL(fileURLWithPath: self)
    }
    var pathExtension: String {
        return fileURL.pathExtension
    }
    var lastPathComponent: String {
        return fileURL.lastPathComponent
    }
}

