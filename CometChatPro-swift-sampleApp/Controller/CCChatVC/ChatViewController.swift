//
//  ChatViewController.swift
//  CCPulse-CometChatUI-ios-master
//
//  Created by pushpsen airekar on 02/12/18.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.
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
import FastScroll

class ChatViewController: UIViewController,UITextViewDelegate,UITableViewDelegate, UITableViewDataSource, UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate,AVAudioPlayerDelegate,AVAudioRecorderDelegate,UIGestureRecognizerDelegate,QLPreviewControllerDataSource,QLPreviewControllerDelegate  {
    
    //Outlets Declarations:
    @IBOutlet weak var videoCallBtn: UIBarButtonItem!
    @IBOutlet weak var audioCallButton: UIBarButtonItem!
    @IBOutlet weak var attachmentBtn: UIButton!
    @IBOutlet weak var ChatViewBottomconstraint: NSLayoutConstraint!
    @IBOutlet weak var ChatViewWithComponents: UIView!
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var chatInputView: UITextView!
    @IBOutlet weak var chatTableview: FastScrollTableView!
    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
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
    var videoURL:URL!
    var audioURL:URL!
    var fileURL: URL?
    var chatMessage = [BaseMessage]()
    var refreshControl: UIRefreshControl!
    var previewURL:String!
    fileprivate let textCellID = "textCCell"
    fileprivate let imageCellID = "imageCell"
    fileprivate let videoCellID = "videoCell"
    fileprivate let actionCellID = "actionCell"
    fileprivate let mediaCellID = "mediaCell"
    var soundRecorder : AVAudioRecorder!
    var soundPlayer : AVAudioPlayer!
    var fileName: String = "audioFile2.m4a"
    var containView:UIView!
    var typingIndicator: TypingIndicator!
    var animation:CAKeyframeAnimation!
    let myUID = UserDefaults.standard.string(forKey: "LoggedInUserUID")
    

    private var messageRequest:MessagesRequest!
    var docController: UIDocumentInteractionController!
    var previewQL = QLPreviewController()
    public typealias sendMessageResponse = (_ success:[BaseMessage]? , _ error:CometChatException?) -> Void
    public typealias sendTextMessageResponse = (_ success:TextMessage? , _ error:CometChatException?) -> Void
    public typealias sendMediaMessageResponse = (_ success:MediaMessage? , _ error:CometChatException?) -> Void
    public typealias userMessageResponse = (_ user:[BaseMessage]? , _ error:CometChatException?) ->Void
    public typealias groupMessageResponse = (_ group:[BaseMessage]? , _ error:CometChatException?) ->Void
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        chatTableview.addSubview(refreshControl)
        
        //Function Calling
        self.handleOneOnOneChatVCApperance()
        self.hideKeyboardWhenTappedOnTableView()
        self.configFastScroll()
        
        self.chatView.layer.borderWidth = 1
        self.chatView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        self.chatView.layer.cornerRadius = 20.0
        self.chatView.clipsToBounds = true
        self.chatInputView.delegate = self
        chatInputView.text = NSLocalizedString("Type a message...", comment: "")
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
        chatTableview.register(ChatMediaMessageCell.self, forCellReuseIdentifier: mediaCellID)
        let actionNib  = UINib.init(nibName: "ChatActionMessageCell", bundle: nil)
        self.chatTableview.register(actionNib, forCellReuseIdentifier: actionCellID)
        
        //QickLookController
        
        previewQL.dataSource = self
        chatTableview.separatorStyle = .none
        
        if(isGroup == "1"){
            messageRequest = MessagesRequest.MessageRequestBuilder().set(GUID: buddyUID).set(limit: 20).build()
        }else{
            messageRequest = MessagesRequest.MessageRequestBuilder().set(UID: buddyUID).set(limit: 20).build()
        }
        fetchPreviousMessages(messageReq: messageRequest) { (message, error) in
            
            guard  let sendMessage = message else{
                return
            }
            
            for msg in sendMessage{
                if msg.readAt <= 0 {
                    CometChat.markMessageAsRead(message: msg)
                }                
            }
            self.chatMessage = sendMessage
            DispatchQueue.main.async{
                self.chatTableview.reloadData()
            }
        }
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        setupRecorder()
        let audioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        }catch{CometChatLog.print(items:"\(error)")}
        
    }
    
    
    @objc func refresh(_ sender: Any) {
        
        fetchPreviousMessages(messageReq: messageRequest) { (message, error) in
            guard let messages = message else{
                return
            }
            let oldMessageArray =  messages
            self.chatMessage.insert(contentsOf: oldMessageArray, at: 0)
            DispatchQueue.main.async{
                self.chatTableview.reloadData()
            }
        }
        refreshControl.endRefreshing()
    }
    
    fileprivate func configFastScroll() {
        
        //bubble
        chatTableview.deactivateBubble = true
        
        //handle
        chatTableview.handleImage = UIImage.init(named: "cursor")
        chatTableview.handleHeight = 40.0
        chatTableview.handleWidth = 44.0
        chatTableview.handleRadius = 0.0
        chatTableview.handleMarginRight = 0
        chatTableview.handleColor = UIColor.clear
        
        //scrollbar
        chatTableview.scrollbarWidth = 0.0
        chatTableview.scrollbarMarginTop = 10.0
        chatTableview.scrollbarMarginBottom = 60.0
        chatTableview.scrollbarMarginRight = 10.0
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
            CometChatLog.print(items:error)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let myURL = url as URL
        CometChatLog.print(items:"import result : \(myURL)")
        
        self.sendMediaMessage(toUserUID: self.buddyUID, mediaURL: "\(myURL.absoluteString)", isGroup: self.isGroup, messageType: .file, completionHandler: { (message, error) in
            
            guard  let sendMessage =  message else{
                return
            }
            self.chatMessage.append(sendMessage)
            DispatchQueue.main.async {
                self.chatTableview.beginUpdates()
                self.chatTableview.insertRows(at: [IndexPath.init(row: self.chatMessage.count-1, section: 0)], with: .automatic)
                
                self.chatTableview.endUpdates()
                self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
                self.chatInputView.text = ""
            }
        })
    }
    
    
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func clickFunction(){
        
        let importMenu = UIDocumentMenuViewController(documentTypes: [kUTTypePDF as String], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ){
            
            if let currentPopoverpresentioncontroller = importMenu.popoverPresentationController{
                currentPopoverpresentioncontroller.sourceView = self.view
                currentPopoverpresentioncontroller.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                currentPopoverpresentioncontroller.permittedArrowDirections = []
                self.present(importMenu, animated: true, completion: nil)
            }
        }else{
            self.present(importMenu, animated: true, completion: nil)
        }
        
        
        //self.present(importMenu, animated: true, completion: nil)
    }
    
    func fetchPreviousMessages(messageReq:MessagesRequest, completionHandler:@escaping sendMessageResponse) {
        
        messageReq.fetchPrevious(onSuccess: { (messages) in
            
            for message in messages!{
                if message.deliveredAt != 0 && message.readAt == 0 && message.sender?.uid != self.myUID{
                    CometChat.markMessageAsRead(message: message)
                }
            }
            CometChatLog.print(items:"messages fetchPrevious: \(String(describing: messages))")
            completionHandler(messages,nil)
            
        }) { (error) in
            CometChatLog.print(items:"error fetchPrevious: \(String(describing: error))")
            completionHandler(nil,error)
            return
        }
    }
    
    
    func sendMessage(toUserUID: String, message : String ,isGroup : String,completionHandler:@escaping sendTextMessageResponse){
        
        var textMessage : TextMessage
        if(isGroup == "1"){
            textMessage = TextMessage(receiverUid: toUserUID, text: message, messageType: .text, receiverType: .group)
        }else {
            textMessage = TextMessage(receiverUid: toUserUID, text: message, messageType: .text, receiverType: .user)
        }
        CometChat.sendTextMessage(message: textMessage, onSuccess: { (message) in
            completionHandler(message,nil)
        }) { (error) in
            completionHandler(nil,error)
        }
    }
    
    func sendMediaMessage(toUserUID: String, mediaURL : String ,isGroup : String, messageType: CometChat.MessageType ,completionHandler:@escaping sendMediaMessageResponse){
        
        var mediaMessage : MediaMessage
        if(isGroup == "1"){
            mediaMessage = MediaMessage(receiverUid: toUserUID, fileurl: mediaURL, messageType: messageType, receiverType: .group)
        }else {
            mediaMessage = MediaMessage(receiverUid: toUserUID, fileurl: mediaURL, messageType: messageType, receiverType: .user)
        }
        CometChat.sendMediaMessage(message: mediaMessage, onSuccess: { (message) in
            CometChatLog.print(items:"sendMediaMessage onSuccess\(String(describing: (message as? MediaMessage)?.url))")
            completionHandler(message, nil)
        }) { (error) in
            CometChatLog.print(items:"sendMediaMessage error\(String(describing: error))")
            completionHandler(nil, error)
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    // MARK: - Notification oberserver methods
    
    @objc func didBecomeActive() {
        
    }
    
    @objc func willEnterForeground() {
        
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
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
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
        containView = UIView(frame: CGRect(x: -10 , y: 0, width: 38, height: 38))
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
        let  titleView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: (self.navigationController?.navigationBar.bounds.size.width)! - 200, height: 50))
        
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
        
        
        //TypingIndicator:
        if(isGroup == "1"){
            typingIndicator = TypingIndicator(receiverID: buddyUID, receiverType: .group)
        }else{
            typingIndicator = TypingIndicator(receiverID: buddyUID, receiverType: .user)
        }
    }
    
    @objc func backButtonPressed(){
        navigationController?.popViewController(animated: true)
        CometChat.endTyping(indicator: typingIndicator)
        let oneOne = ChatViewController()
        oneOne.removeFromParent()
        
    }
    
    @objc func audioRecord(_ sender: UIGestureRecognizer){
        
        if sender.state == .ended {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            soundRecorder.stop()
            count = 0
            self.setupPlayer()
            micButton.setImage(#imageLiteral(resourceName: "micNormal"), for: .normal)
            recordingLabel.isHidden = true
            
            self.chatInputView.text = NSLocalizedString("Type a message...", comment: "")
            let alertController = UIAlertController(
                title: NSLocalizedString("Send AudioFile", comment: ""), message:  NSLocalizedString("Are you sure want to send this Audio note.", comment: ""), preferredStyle: .alert)
            let OkAction = UIAlertAction(title: NSLocalizedString("Send", comment: ""), style: .default
                , handler: { (UIAlertAction) in
                    
                    CometChatLog.print(items: "AudioURL is : \(String(describing: self.audioURL))")
                    
                    self.sendMediaMessage(toUserUID: self.buddyUID, mediaURL: "\(String(describing: self.audioURL.absoluteString))", isGroup: self.isGroup, messageType: .audio, completionHandler: { (message, error) in
                        
                        guard  let sendMessage =  message else{
                            return
                        }
                        self.chatMessage.append(sendMessage)
                        DispatchQueue.main.async {
                            self.chatTableview.beginUpdates()
                            self.chatTableview.insertRows(at: [IndexPath.init(row: self.chatMessage.count-1, section: 0)], with: .automatic)
                            
                            self.chatTableview.endUpdates()
                            self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
                            self.chatInputView.text = ""
                        }
                    })
            })
            
            let defaultAction = UIAlertAction(
                title: NSLocalizedString("Cancel", comment: ""), style: .destructive, handler: nil)
            
            //you can add custom actions as well
            alertController.addAction(defaultAction)
            alertController.addAction(OkAction)
            
            
            present(alertController, animated: true, completion: nil)
            
            //Do Whatever You want on End of Gesture
        }
        else if sender.state == .began {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            soundRecorder.record()
            micButton.setImage(#imageLiteral(resourceName: "micSelected"), for: .normal)
            self.chatInputView.text = ""
            recordingLabel.isHidden = false
            recordingLabel.text = NSLocalizedString("Recording...", comment: "")
            
            //Do Whatever You want on Began of Gesture
        }
    }
    
    @objc func update() {
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
        UserProfileViewController.title = NSLocalizedString("View Profile", comment: "")
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
            let keyboardFrame = (userinfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            ChatViewBottomconstraint.constant = (keyboardFrame?.height)!
            
            
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            ChatViewBottomconstraint.constant = 0
        }
    }
    
    
    
    @objc override func dismissKeyboard() {
        chatInputView.resignFirstResponder()
        if self.view.frame.origin.y != 0 {
            ChatViewBottomconstraint.constant = 0
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
            chatInputView.text = NSLocalizedString("Type a message...", comment: "")
            chatInputView.textColor = UIColor.lightGray
            CometChat.endTyping(indicator: typingIndicator)
        }
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        CometChat.startTyping(indicator: typingIndicator)
        
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
        
        switch messageData.messageCategory {
            
        case .message:
            
            switch messageData.messageType {
                
            case .text:
                var textMessageCell = ChatTextMessageCell()
                textMessageCell = tableView.dequeueReusableCell(withIdentifier: textCellID, for: indexPath) as! ChatTextMessageCell
                textMessageCell.chatMessage = (messageData as? TextMessage)!
                textMessageCell.selectionStyle = .none
                return textMessageCell
                
            case .image:
                
                var imageMessageCell = ChatImageMessageCell()
                imageMessageCell = tableView.dequeueReusableCell(withIdentifier: imageCellID , for: indexPath) as! ChatImageMessageCell
                imageMessageCell.chatMessage = (messageData as? MediaMessage)!
                let url = NSURL(string: (messageData as? MediaMessage)!.url!)
                imageMessageCell.chatImage.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_Pending"))
                imageMessageCell.selectionStyle = .none
                return imageMessageCell
                
            case .video:
                
                var videoMessageCell = ChatVideoMessageCell()
                videoMessageCell = tableView.dequeueReusableCell(withIdentifier: videoCellID , for: indexPath) as! ChatVideoMessageCell
                videoMessageCell.chatMessage = (messageData as? MediaMessage)!
                videoMessageCell.selectionStyle = .none
                return videoMessageCell
                
            case .audio:
                
                var mediaMessageCell = ChatMediaMessageCell()
                mediaMessageCell = tableView.dequeueReusableCell(withIdentifier: mediaCellID, for: indexPath) as! ChatMediaMessageCell
                mediaMessageCell.chatMessage = (messageData as? MediaMessage)!
                mediaMessageCell.selectionStyle = .none
                mediaMessageCell.fileIconImageView.image = #imageLiteral(resourceName: "play")
                return mediaMessageCell
                
            case .file:
                
                var mediaMessageCell = ChatMediaMessageCell()
                mediaMessageCell = tableView.dequeueReusableCell(withIdentifier: mediaCellID, for: indexPath) as! ChatMediaMessageCell
                mediaMessageCell.chatMessage = (messageData as? MediaMessage)!
                mediaMessageCell.selectionStyle = .none
                mediaMessageCell.fileIconImageView.image = #imageLiteral(resourceName: "file")
                return mediaMessageCell
                
            case .groupMember: break
                
            case .custom: break
                
            }
            
        case .action:
            
            var actionCell = ChatActionMessageCell()
            let actionMessage = (messageData as? ActionMessage)!
            actionCell = tableView.dequeueReusableCell(withIdentifier: actionCellID, for: indexPath) as! ChatActionMessageCell
            actionCell.actionMessageLabel.text = actionMessage.message
            actionCell.selectionStyle = .none
            return actionCell
            
        case .call:
            
            var actionCell = ChatActionMessageCell()
            let callMessage = (messageData as? Call)!
            actionCell = tableView.dequeueReusableCell(withIdentifier: actionCellID , for: indexPath) as! ChatActionMessageCell
            
            switch callMessage.callStatus{
                
            case .initiated:
                actionCell.actionMessageLabel.text = NSLocalizedString("Call Initiated", comment: "")
            case .ongoing:
                actionCell.actionMessageLabel.text = NSLocalizedString("Call Ongoing", comment: "")
            case .unanswered:
                actionCell.actionMessageLabel.text = NSLocalizedString("Call Unanswered", comment: "")
            case .rejected:
                actionCell.actionMessageLabel.text = NSLocalizedString("Call Rejected", comment: "")
            case .busy:
                actionCell.actionMessageLabel.text = NSLocalizedString("Call Busy", comment: "")
            case .cancelled:
                actionCell.actionMessageLabel.text = NSLocalizedString("Call Cancelled", comment: "")
            case .ended:
                actionCell.actionMessageLabel.text = NSLocalizedString("Call Ended", comment: "")
            }
            
            actionCell.selectionStyle = .none
            return actionCell
            
        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let messageData = chatMessage[indexPath.row]
        
        switch messageData.messageType{
            
        case .text: break
            
        case .image:
            
            let imageCell:ChatImageMessageCell = tableView.cellForRow(at: indexPath) as! ChatImageMessageCell
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let profileAvtarViewController = storyboard.instantiateViewController(withIdentifier: "ccprofileAvtarViewController") as! CCprofileAvtarViewController
            navigationController?.pushViewController(profileAvtarViewController, animated: true)
            profileAvtarViewController.profileAvtar =  imageCell.chatImage.image
            profileAvtarViewController.hidesBottomBarWhenPushed = true
            
        case .video:
            
            let videoMessage = (messageData as? MediaMessage)
            var player = AVPlayer()
            if let videoURL = videoMessage?.url?.decodeUrl(),
                let url = URL(string: videoURL) {
                player = AVPlayer(url: url)
            }
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        case .audio:

            let audioMessage = (messageData as? MediaMessage)
            let url = NSURL.fileURL(withPath:audioMessage!.url!.decodeUrl() ?? "")
            previewURL = audioMessage!.url!.decodeUrl()!
            let fileExtention = url.pathExtension
            let pathPrefix = url.lastPathComponent
            let fileName = URL(fileURLWithPath: pathPrefix).deletingPathExtension().lastPathComponent
            let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension(fileExtention)
            previewQL.refreshCurrentPreviewItem()
            previewQL.currentPreviewItemIndex = indexPath.row
            show(previewQL, sender: nil)
            
            
        case .file:
            
            let fileMessage = (messageData as? MediaMessage)
            let url = NSURL.fileURL(withPath:fileMessage!.url!.decodeUrl() ?? "")
            previewURL = fileMessage!.url!.decodeUrl()!
            let fileExtention = url.pathExtension
            let pathPrefix = url.lastPathComponent
            let fileName = URL(fileURLWithPath: pathPrefix).deletingPathExtension().lastPathComponent
            let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension(fileExtention)
            previewQL.refreshCurrentPreviewItem()
            previewQL.currentPreviewItemIndex = indexPath.row
            show(previewQL, sender: nil)
            
        case .groupMember: break
            
        case .custom: break
            
        }
        
    }
    
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        
        
        let filenameWithExtention = previewURL.lastPathComponent
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
        
        if(message.count == 0 || message == NSLocalizedString("Type a message...", comment: "")){
            
        }else{
            sendMessage(toUserUID: buddyUID, message: message, isGroup: isGroup) { (message, error) in
                
                guard  let sendMessage =  message else{
                    return
                }
                CometChat.endTyping(indicator: self.typingIndicator)
                self.chatMessage.append(sendMessage)
                DispatchQueue.main.async{
                    self.chatInputView.text = ""
                    self.chatTableview.reloadData()
                    self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
                    
                }
            }
        }
    }
    
    @IBAction func micButtonPressed(_ sender: Any) {
        //The code is written in TapAndHoldGestureRecognizer
    }
    
    
    
    @IBAction func attachementButtonPressed(_ sender: Any) {
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default) { action -> Void in
            
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photoAndVideo
            config.wordings.cancel = NSLocalizedString("Cancel", comment: "")
            config.wordings.next = NSLocalizedString("Next", comment: "")
            config.wordings.videoTitle = NSLocalizedString("Video", comment: "")
            config.wordings.albumsTitle = NSLocalizedString("Albums", comment: "")
            config.wordings.libraryTitle = NSLocalizedString("Library", comment: "")
            config.wordings.cameraTitle = NSLocalizedString("Camera", comment: "")
            config.wordings.cover = NSLocalizedString("Cover", comment: "")
            config.wordings.ok = NSLocalizedString("Ok", comment: "")
            config.wordings.done = NSLocalizedString("Done", comment: "")
            config.wordings.save = NSLocalizedString("Save", comment: "")
            config.wordings.processing = NSLocalizedString("Processing", comment: "")
            config.wordings.trim = NSLocalizedString("Trim", comment: "")
            config.wordings.cover = NSLocalizedString("Cover", comment: "")
            config.wordings.filter = NSLocalizedString("Filter", comment: "")
            config.wordings.crop = NSLocalizedString("Crop", comment: "")
            config.wordings.warningMaxItemsLimit = NSLocalizedString("Limit Reached", comment: "")
            config.wordings.libraryTitle = NSLocalizedString("Gallery", comment: "")
            
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
                    picker.dismiss(animated: true, completion: nil)
                    return
                }
                _ = items.map { print("🧀 \($0)") }
                self.selectedItems = items
                if let firstItem = items.first {
                    switch firstItem {
                    case .photo(let photo):
                        self.selectedImageV.image = photo.image
                        let imageData = photo.image.pngData()!
                        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                        let imageURL = docDir.appendingPathComponent("tmp.png")
                        try! imageData.write(to: imageURL)
                        picker.dismiss(animated: true, completion: nil)
                        
                        self.sendMediaMessage(toUserUID: self.buddyUID, mediaURL: imageURL.absoluteString, isGroup: self.isGroup, messageType: .image, completionHandler: { (message, error) in
                            
                            guard  let sendMessage =  message else{
                                return
                            }
                            self.chatMessage.append(sendMessage)
                            DispatchQueue.main.async {
                                self.chatTableview.beginUpdates()
                                self.chatTableview.insertRows(at: [IndexPath.init(row: self.chatMessage.count-1, section: 0)], with: .automatic)
                                
                                self.chatTableview.endUpdates()
                                self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
                                self.chatInputView.text = ""
                            }
                        })
                        
                    case .video(let video):
                        self.selectedImageV.image = video.thumbnail
                        let assetURL = video.url
                        self.videoURL = video.url
                        
                        picker.dismiss(animated: true, completion: { [weak self] in
                            CometChatLog.print(items: "😀 \(String(describing: self?.resolutionForLocalVideo(url: assetURL)!))")
                            
                            self!.sendMediaMessage(toUserUID: self!.buddyUID, mediaURL:  self!.videoURL.absoluteString, isGroup: self!.isGroup, messageType: .video, completionHandler: { (message, error) in
                                
                                guard  let sendMessage =  message else{
                                    return
                                }
                                self!.chatMessage.append(sendMessage)
                                DispatchQueue.main.async {
                                    self!.chatTableview.beginUpdates()
                                    self!.chatTableview.insertRows(at: [IndexPath.init(row: self!.chatMessage.count-1, section: 0)], with: .automatic)
                                    
                                    self!.chatTableview.endUpdates()
                                    self!.chatTableview.scrollToRow(at: IndexPath.init(row: self!.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
                                    self!.chatInputView.text = ""
                                }
                            })
                        })
                    }
                }
            }
            self.present(picker, animated: true, completion: nil)
            
        }
        cameraAction.setValue(UIImage(named: "camera.png"), forKey: "image")
        
        let photoLibraryAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Photo & Video Library", comment: ""), style: .default) { action -> Void in
            
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photoAndVideo
            config.wordings.cancel =  NSLocalizedString("Cancel", comment: "")
            config.wordings.next = NSLocalizedString("Next", comment: "")
            config.wordings.videoTitle = NSLocalizedString("Video", comment: "")
            config.wordings.albumsTitle = NSLocalizedString("Albums", comment: "")
            config.wordings.libraryTitle = NSLocalizedString("Library", comment: "")
            config.wordings.cameraTitle = NSLocalizedString("Camera", comment: "")
            config.wordings.cover = NSLocalizedString("Cover", comment: "")
            config.wordings.ok = NSLocalizedString("Ok", comment: "")
            config.wordings.done = NSLocalizedString("Done", comment: "")
            config.wordings.save = NSLocalizedString("Save", comment: "")
            config.wordings.processing = NSLocalizedString("Processing", comment: "")
            config.wordings.trim = NSLocalizedString("Trim", comment: "")
            config.wordings.cover = NSLocalizedString("Cover", comment: "")
            config.wordings.filter = NSLocalizedString("Filter", comment: "")
            config.wordings.crop = NSLocalizedString("Crop", comment: "")
            config.wordings.warningMaxItemsLimit = NSLocalizedString("Limit Reached", comment: "")
            config.wordings.libraryTitle = NSLocalizedString("Gallery", comment: "")
            
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
                    picker.dismiss(animated: true, completion: nil)
                    return
                }
                _ = items.map { print("🧀 \($0)") }
                self.selectedItems = items
                if let firstItem = items.first {
                    switch firstItem {
                    case .photo(let photo):
                        self.selectedImageV.image = photo.image
                        let imageData = photo.image.pngData()!
                        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                        let imageURL = docDir.appendingPathComponent("tmp.png")
                        try! imageData.write(to: imageURL)
                        picker.dismiss(animated: true, completion: nil)
                        
                        self.sendMediaMessage(toUserUID: self.buddyUID, mediaURL: imageURL.absoluteString, isGroup: self.isGroup, messageType: .image, completionHandler: { (message, error) in
                            
                            guard  let sendMessage =  message else{
                                return
                            }
                            self.chatMessage.append(sendMessage)
                            DispatchQueue.main.async {
                                self.chatTableview.beginUpdates()
                                self.chatTableview.insertRows(at: [IndexPath.init(row: self.chatMessage.count-1, section: 0)], with: .automatic)
                                
                                self.chatTableview.endUpdates()
                                self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
                                self.chatInputView.text = ""
                            }
                        })
                        
                    case .video(let video):
                        self.selectedImageV.image = video.thumbnail
                        let assetURL = video.url
                        self.videoURL = video.url
                        
                        picker.dismiss(animated: true, completion: { [weak self] in
                            CometChatLog.print(items:"😀 \(String(describing: self?.resolutionForLocalVideo(url: assetURL)!))")
                            
                            self!.sendMediaMessage(toUserUID: self!.buddyUID, mediaURL: assetURL.absoluteString, isGroup: self!.isGroup, messageType: .video, completionHandler: { (message, error) in
                                
                                guard  let sendMessage =  message else{
                                    return
                                }
                                self!.chatMessage.append(sendMessage)
                                DispatchQueue.main.async {
                                    self!.chatTableview.beginUpdates()
                                    self!.chatTableview.insertRows(at: [IndexPath.init(row: self!.chatMessage.count-1, section: 0)], with: .automatic)
                                    
                                    self!.chatTableview.endUpdates()
                                    self!.chatTableview.scrollToRow(at: IndexPath.init(row: self!.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
                                    self!.chatInputView.text = ""
                                }
                            })
                        })
                        
                    }
                }
            }
            self.present(picker, animated: true, completion: nil)
        }
        photoLibraryAction.setValue(UIImage(named: "gallery.png"), forKey: "image")
        
        let documentAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Document", comment: ""), style: .default) { action -> Void in
            
            self.clickFunction()
            
        }
        documentAction.setValue(UIImage(named: "document.png"), forKey: "image")
        
        let cancelAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
        }
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        actionSheetController.addAction(cameraAction)
        actionSheetController.addAction(photoLibraryAction)
        actionSheetController.addAction(documentAction)
        actionSheetController.addAction(cancelAction)
        
        if self.view.frame.origin.y != 0 {
            dismissKeyboard()

            if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ){
                
                if let currentPopoverpresentioncontroller = actionSheetController.popoverPresentationController{
                    currentPopoverpresentioncontroller.sourceView = sender as? UIView
                    currentPopoverpresentioncontroller.sourceRect = (sender as AnyObject).bounds
                    self.present(actionSheetController, animated: true, completion: nil)
                }
            }else{
                self.present(actionSheetController, animated: true, completion: nil)
            }
        }else{
            if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ){
                
                if let currentPopoverpresentioncontroller = actionSheetController.popoverPresentationController{
                    currentPopoverpresentioncontroller.sourceView = sender as? UIView
                    currentPopoverpresentioncontroller.sourceRect = (sender as AnyObject).bounds
                    self.present(actionSheetController, animated: true, completion: nil)
                }
            }else{
                self.present(actionSheetController, animated: true, completion: nil)
            }
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
        CallingViewController.callingString = NSLocalizedString("Calling ...", comment: "")
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
    
}

extension ChatViewController : CometChatMessageDelegate {
    
    func onTextMessageReceived(textMessage: TextMessage?, error: CometChatException?) {
        if textMessage?.sender?.uid == buddyUID && textMessage?.receiverType.rawValue == Int(isGroup){
            CometChat.markMessageAsRead(message: textMessage!)
            self.chatMessage.append(textMessage!)
            DispatchQueue.main.async{
                self.chatTableview.reloadData()
                self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
            }
            
        }else if textMessage?.receiverUid == buddyUID && textMessage?.receiverType.rawValue == Int(isGroup){
            CometChat.markMessageAsRead(message: textMessage!)
            self.chatMessage.append(textMessage!)
            DispatchQueue.main.async{
                self.chatTableview.reloadData()
                self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
            }
        }
    }
    
    func onMediaMessageReceived(mediaMessage: MediaMessage?, error: CometChatException?)
    {
        if mediaMessage?.sender?.uid == buddyUID && mediaMessage?.receiverType.rawValue == Int(isGroup){
            CometChat.markMessageAsRead(message: mediaMessage!)
            self.chatMessage.append(mediaMessage!)
            DispatchQueue.main.async{
                self.chatTableview.reloadData()
                self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
            }
        }else if mediaMessage?.receiverUid == buddyUID && mediaMessage?.receiverType.rawValue == Int(isGroup){
            CometChat.markMessageAsRead(message: mediaMessage!)
            self.chatMessage.append(mediaMessage!)
            DispatchQueue.main.async{
                self.chatTableview.reloadData()
                self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
            }
        }
    }
    
    func onTypingStarted(_ typingDetails : TypingIndicator) {
        
        animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1.0, 1.2, 1.0]
        animation.keyTimes = [0, 0.5, 1]
        animation.duration = 1.5
        animation.repeatCount = Float.infinity
        // received typing indicator:
        
        switch typingDetails.receiverType {
        case .user:
            buddyStatus.text = NSLocalizedString("Typing...", comment: "")
            containView.layer.add(animation, forKey: nil)
    
        case .group:break

        }
    }
    
    func onTypingEnded(_ typingDetails : TypingIndicator) {
        
        // received typing indicator:
        
        switch typingDetails.receiverType {
        case .user:
            buddyStatus.text = NSLocalizedString("Online", comment: "")
            containView.layer.removeAllAnimations()
        case .group:break
        }
    }
    
    func onMessageDelivered(receipt : MessageReceipt) {
        
        
        if let row = self.chatMessage.index(where: {$0.id == Int(receipt.messageId)}) {
            
            chatMessage[row].deliveredAt = Double(receipt.timeStamp)
            let indexPath = IndexPath(row: row, section: 0)
   
        }
        
        
    }
    
    func onMessageRead(receipt : MessageReceipt) {
        
        if let row = self.chatMessage.index(where: {$0.id == Int(receipt.messageId)}) {
            
            if receipt.receiptType == .read {
                chatMessage[row].readAt = Double(receipt.timeStamp)
            }
            let indexPath = IndexPath(row: row, section: 0)
            chatTableview.reloadRows(at: [indexPath], with: .none)
            self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: false)
        }
        
        
    }
    
}


extension ChatViewController : CometChatGroupDelegate {
    
    func onGroupMemberJoined(action: ActionMessage, joinedUser: User, joinedGroup: Group) {
        
        self.chatMessage.append(action)
        
        DispatchQueue.main.async{
            self.chatTableview.reloadData()
            self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
        }
    }
    
    func onGroupMemberLeft(action: ActionMessage, leftUser: User, leftGroup: Group) {
        
        self.chatMessage.append(action)
        
        DispatchQueue.main.async{
            self.chatTableview.reloadData()
            self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
        }
    }
    
    func onGroupMemberKicked(action: ActionMessage, kickedUser: User, kickedBy: User, kickedFrom: Group) {
        
        self.chatMessage.append(action)
        
        DispatchQueue.main.async{
            self.chatTableview.reloadData()
            self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
        }
        
    }
    
    func onGroupMemberBanned(action: ActionMessage, bannedUser: User, bannedBy: User, bannedFrom: Group) {
        
        self.chatMessage.append(action)
        
        DispatchQueue.main.async{
            self.chatTableview.reloadData()
            self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
        }
    }
    
    func onGroupMemberUnbanned(action: ActionMessage, unbannedUser: User, unbannedBy: User, unbannedFrom: Group) {
        
        self.chatMessage.append(action)
        
        DispatchQueue.main.async{
            self.chatTableview.reloadData()
            self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
        }
    }
    
    func onGroupMemberScopeChanged(action: ActionMessage, user: User, scopeChangedTo: String, scopeChangedFrom: String, group: Group) {
        
        self.chatMessage.append(action)
        
        DispatchQueue.main.async{
            self.chatTableview.reloadData()
            self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
        }
    }
}

extension ChatViewController : CometChatUserDelegate {
    
    func onUserOnline(user: User) {
        if user.uid == buddyUID{
            if user.status == .online {
                buddyStatus.text = NSLocalizedString("Online", comment: "")
            }
        }
    }
    
    func onUserOffline(user: User) {
        
        if user.uid == buddyUID{
            if user.status == .offline {
                buddyStatus.text = NSLocalizedString("Offline", comment: "")
            }
        }
    }
}

extension ChatViewController {
    /* Gives a resolution for the video by URL */
    func resolutionForLocalVideo(url: URL) -> CGSize? {
        guard let track = AVURLAsset(url: url).tracks(withMediaType: AVMediaType.video).first else { return nil }
        let size = track.naturalSize.applying(track.preferredTransform)
        return CGSize(width: abs(size.width), height: abs(size.height))
    }
}


extension ChatViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView : UIScrollView) {
        chatTableview.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView : UIScrollView) {
        chatTableview.scrollViewWillBeginDragging(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView : UIScrollView) {
        chatTableview.scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView : UIScrollView, willDecelerate decelerate : Bool) {
        chatTableview.scrollViewDidEndDragging(scrollView, willDecelerate : decelerate)
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

