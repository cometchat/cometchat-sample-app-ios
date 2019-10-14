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
import XLActionController


class ChatViewController: UIViewController,UITextViewDelegate,UITableViewDelegate, UITableViewDataSource, UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate,AVAudioPlayerDelegate,AVAudioRecorderDelegate,UIGestureRecognizerDelegate,QLPreviewControllerDataSource,QLPreviewControllerDelegate, UISearchBarDelegate {
    
    //Outlets Declarations:
    @IBOutlet weak var videoCallBtn: UIBarButtonItem!
    @IBOutlet weak var audioCallButton: UIBarButtonItem!
    @IBOutlet weak var moreButton: UIBarButtonItem!
    @IBOutlet weak var attachmentBtn: UIButton!
    @IBOutlet weak var ChatViewBottomconstraint: NSLayoutConstraint!
    @IBOutlet weak var ChatViewWithComponents: UIView!
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var chatInputView: UITextView!
    @IBOutlet weak var chatTableview: UITableView!
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
    fileprivate let deletedCellID = "deleteCell"
    var soundRecorder : AVAudioRecorder!
    var soundPlayer : AVAudioPlayer!
    var fileName: String = "audioFile2.m4a"
    var containView:UIView!
    var typingIndicator: TypingIndicator!
    var animation:CAKeyframeAnimation!
    let myUID = UserDefaults.standard.string(forKey: "LoggedInUserUID")
    var editMessageFlag:Bool = false
    var editMessage:TextMessage?
    var deleteMessage:MediaMessage?
    var tableIndexPath:IndexPath?
    private var messageRequest:MessagesRequest!
    var docController: UIDocumentInteractionController!
    var previewQL = QLPreviewController()
    var searchController:UISearchController = UISearchController(searchResultsController: nil)
    public typealias sendMessageResponse = (_ success:[BaseMessage]? , _ error:CometChatException?) -> Void
    public typealias sendTextMessageResponse = (_ success:TextMessage? , _ error:CometChatException?) -> Void
    public typealias sendEditMessageResponse = (_ success:BaseMessage? , _ error:CometChatException?) -> Void
    public typealias sendMediaMessageResponse = (_ success:MediaMessage? , _ error:CometChatException?) -> Void
    public typealias userMessageResponse = (_ user:[BaseMessage]? , _ error:CometChatException?) ->Void
    public typealias groupMessageResponse = (_ group:[BaseMessage]? , _ error:CometChatException?) ->Void
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Function Calling
        self.handleOneOnOneChatVCApperance()
        self.hideKeyboardWhenTappedOnTableView()
        
        // Assigining CometChatPro Delegates
        CometChat.messagedelegate = self
        CometChat.userdelegate = self
        CometChat.groupdelegate = self
        
        //registering Cells
        chatTableview.register(ChatTextMessageCell.self, forCellReuseIdentifier: textCellID)
        chatTableview.register(ChatImageMessageCell.self, forCellReuseIdentifier: imageCellID)
        chatTableview.register(ChatVideoMessageCell.self, forCellReuseIdentifier: videoCellID)
        chatTableview.register(ChatMediaMessageCell.self, forCellReuseIdentifier: mediaCellID)
        chatTableview.register(ChatDeletedMessageCell.self, forCellReuseIdentifier: deletedCellID)
        let actionNib  = UINib.init(nibName: "ChatActionMessageCell", bundle: nil)
        self.chatTableview.register(actionNib, forCellReuseIdentifier: actionCellID)
        
        //QickLookController
        previewQL.dataSource = self
        chatTableview.separatorStyle = .none
        
        //Building MessagesRequest builder
        if(isGroup == "1"){
            messageRequest = MessagesRequest.MessageRequestBuilder().set(guid: buddyUID).hideMessagesFromBlockedUsers(true).set(limit: 20).build()
        }else{
            messageRequest = MessagesRequest.MessageRequestBuilder().set(uid: buddyUID).set(limit: 20).build()
        }
        
        //Fetching Previous Messages
        fetchPreviousMessages(messageReq: messageRequest) { (message, error) in
            guard  let sendMessage = message else{
                return
            }
           var messages = [BaseMessage]()
            for msg in sendMessage{
                
                if (((msg as? ActionMessage) != nil) && ((msg as? ActionMessage)?.message == "Message is edited.") ||  ((msg as? ActionMessage)?.message == "Message is deleted.")){
                    
                    //Ignoring action messages for Delete and edit action
                    CometChat.markMessageAsRead(message: msg)
                }else{
                    
                    //Appending Other Messages
                    messages.append(msg)
                    print("messages are \(String(describing: (msg as? TextMessage)?.stringValue()))")
                    if msg.readAt == 0 && msg.senderUid != self.myUID{
                        CometChat.markMessageAsRead(message: msg)
                    }
                }
            }
            self.chatMessage = messages
            DispatchQueue.main.async{
                self.chatTableview.reloadData()
            }
        }
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        setupRecorder()
        let audioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        }catch{ CometChatLog.print(items:"\(error)") }
    }
    
    // Fetching Old/Previous messages
    @objc func refresh(_ sender: Any) {
        fetchPreviousMessages(messageReq: messageRequest) { (message, error) in
            guard let messages = message else{ return }
            var oldMessages = [BaseMessage]()
            for msg in messages{
                if (((msg as? ActionMessage) != nil) && ((msg as? ActionMessage)?.message == "Message is edited.") ||  ((msg as? ActionMessage)?.message == "Message is deleted.")){
                    //Ignoring action messages for Delete and edit action
                    CometChat.markMessageAsRead(message: msg)
                }else{
                    //Appending Other Messages
                    oldMessages.append(msg)
                    print("messages are \(String(describing: (msg as? TextMessage)?.stringValue()))")
                    if msg.readAt == 0 && msg.senderUid != self.myUID{
                        CometChat.markMessageAsRead(message: msg)
                    }
                }
            }
            let oldMessageArray =  oldMessages
            self.chatMessage.insert(contentsOf: oldMessageArray, at: 0)
            DispatchQueue.main.async{
                self.chatTableview.reloadData()
            }
        }
        refreshControl.endRefreshing()
    }
    
    // This function setup the Document Directory
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // This function setup the Audio Recorder for recording audio for type of Audio Message
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
    
    // This function setup the player for playing audio file
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
    
    //AVAudioRecorder: audioRecorderDidFinishRecording
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
    }
    
    //AVAudioPlayer: audioPlayerDidFinishPlaying
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    }
    
    
    // This function pick the document i.e .pdf, .pptx etc. and send the message of type as file.
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
    
    //UIDocumentMenuViewController: documentPicker
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    //UIDocumentMenuViewController: documentPickerWasCancelled
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    //UIDocumentMenuViewController: documentPickerWasCancelled
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
        
    }
    
    // Function for fetching Previous Messages
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
    
    // Function for sending Text Messages
    func sendMessage(toUserUID: String, message : String ,isGroup : String,completionHandler:@escaping sendTextMessageResponse){
        var textMessage : TextMessage
        if(isGroup == "1"){
            textMessage = TextMessage(receiverUid: toUserUID, text: message,  receiverType: .group)
        }else {
            textMessage = TextMessage(receiverUid: toUserUID, text: message, receiverType: .user)
        }
        CometChat.sendTextMessage(message: textMessage, onSuccess: { (message) in
            completionHandler(message,nil)
        }) { (error) in
            completionHandler(nil,error)
        }
    }
    
    // Function for editing Messages
    func editMessage(toUserUID: String,messageID: Int, message : String ,isGroup : String,completionHandler:@escaping sendEditMessageResponse){
        
        var textMessage : TextMessage
        if(isGroup == "1"){
            textMessage = TextMessage(receiverUid: toUserUID, text: message, receiverType: .group)
        }else {
            textMessage = TextMessage(receiverUid: toUserUID, text: message, receiverType: .user)
        }
        textMessage.id = messageID
        
        CometChat.edit(message: textMessage, onSuccess: { (editedMessage) in
            completionHandler(editedMessage,nil)
        }) { (error) in
            print("edit(message: \(error.errorDescription)")
            completionHandler(nil,error)
            
        }
    }
    
    // Function for sending  Media Messages
    func sendMediaMessage(toUserUID: String, mediaURL : String ,isGroup : String, messageType: CometChat.MessageType ,completionHandler:@escaping sendMediaMessageResponse){
        
        var mediaMessage : MediaMessage
        if(isGroup == "1"){
            mediaMessage = MediaMessage(receiverUid: toUserUID, fileurl: mediaURL, messageType: messageType, receiverType: .group)
        }else {
            mediaMessage = MediaMessage(receiverUid: toUserUID, fileurl: mediaURL, messageType: messageType, receiverType: .user)
        }
        CometChat.sendMediaMessage(message: mediaMessage, onSuccess: { (message) in
            CometChatLog.print(items:"sendMediaMessage onSuccess: \(String(describing: (message as? MediaMessage)?.url))")
            completionHandler(message, nil)
        }) { (error) in
            CometChatLog.print(items:"sendMediaMessage error\(String(describing: error))")
            completionHandler(nil, error)
        }
    }
    
    // Function called when viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // Function called when viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // Function called when viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    // This function hadles the UI appearance for OneOnOneChatVC
    func handleOneOnOneChatVCApperance(){
        
        // connfiguring ChatView
        self.chatView.layer.borderWidth = 1
        self.chatView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        self.chatView.layer.cornerRadius = 20.0
        self.chatView.clipsToBounds = true
        self.chatInputView.delegate = self
        chatInputView.text = NSLocalizedString("Type a message...", comment: "")
        chatInputView.textColor = UIColor.lightGray
        
        chatTableview.delegate = self
        chatTableview.dataSource = self
        
        
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
        
        // SearchBar Apperance
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_TITLE_COLOR)
        
        if(UIAppearanceColor.SEARCH_BAR_STYLE_LIGHT_CONTENT == true){
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Search Message", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.5)])
        }else{
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Search Message", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 0, alpha: 0.5)])
        }
        
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let SearchImageView = UIImageView.init()
        let SearchImage = UIImage(named: "icons8-search-30")!.withRenderingMode(.alwaysTemplate)
        SearchImageView.image = SearchImage
        SearchImageView.tintColor = UIColor.init(white: 1, alpha: 0.5)
        
        searchController.searchBar.setImage(SearchImageView.image, for: UISearchBar.Icon.search, state: .normal)
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.white
            if let backgroundview = textfield.subviews.first{
                
                // Background color
                backgroundview.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
                // Rounded corner
                backgroundview.layer.cornerRadius = 10
                backgroundview.clipsToBounds = true;
            }
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
        buddyName = UILabel(frame: CGRect(x:0,y: 3,width: 120 ,height: 21))
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
        
        // Added Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        chatTableview.addSubview(refreshControl)
        
        
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
        
        if (self.navigationController?.viewControllers.filter({$0.isKind(of: OneOnOneListViewController.self)}).first as? OneOnOneListViewController) != nil {
            self.navigationController?.popViewController(animated: true, completion: {
                
            })
        }
        
        if (self.navigationController?.viewControllers.filter({$0.isKind(of: GroupListViewController.self)}).first as? GroupListViewController) != nil {
            self.navigationController?.popViewController(animated: true, completion: {
            })
        }
        CometChat.endTyping(indicator: typingIndicator)
        let oneOne = ChatViewController()
        oneOne.removeFromParent()
    }
    
    // This function Called when we  long press on audio icon for Recording audio file.
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
            alertController.addAction(defaultAction)
            alertController.addAction(OkAction)
            present(alertController, animated: true, completion: nil)
            
        }
        else if sender.state == .began {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            soundRecorder.record()
            micButton.setImage(#imageLiteral(resourceName: "micSelected"), for: .normal)
            self.chatInputView.text = ""
            recordingLabel.isHidden = false
            recordingLabel.text = NSLocalizedString("Recording...", comment: "")
        }
    }
    
    // This function called when we tap on UserAvtar in Navigation bar.
    @objc func UserAvtarClicked(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileAvtarViewController = storyboard.instantiateViewController(withIdentifier: "ccprofileAvtarViewController") as! CCprofileAvtarViewController
        navigationController?.pushViewController(profileAvtarViewController, animated: true)
        profileAvtarViewController.title = buddyNameString
        profileAvtarViewController.profileAvtar = buddyAvtar
        profileAvtarViewController.hidesBottomBarWhenPushed = true
    }
    
    // This function called when we tap on TitleView in Navigation bar.
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
    
    // This function called when keyboard is presented.
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let userinfo = notification.userInfo
        {
            let keyboardFrame = (userinfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            
            if (modelName == "iPhone X" || modelName == "iPhone XS" || modelName == "iPhone XR"){
                ChatViewBottomconstraint.constant = (keyboardFrame?.height)! + 20
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                }
            }else{
                ChatViewBottomconstraint.constant = (keyboardFrame?.height)!
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                }
            }
        }
        
    }
    
    
    // This function called when keyboard is dismissed.
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            ChatViewBottomconstraint.constant = 0
            UIView.animate(withDuration: 0.25
            ) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    // This function dismiss the  keyboard
    @objc override func dismissKeyboard() {
        chatInputView.resignFirstResponder()
        if self.view.frame.origin.y != 0 {
            ChatViewBottomconstraint.constant = 0
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // This function called when textViewDidBeginEditing
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if chatInputView.text != "" && editMessageFlag == false{
            chatInputView.text = ""
            chatInputView.textColor = UIColor.black
        }
        
    }
    
    // This function called when textViewDidEndEditing
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if chatInputView.text == ""{
            chatInputView.text = NSLocalizedString("Type a message...", comment: "")
            chatInputView.textColor = UIColor.lightGray
            CometChat.endTyping(indicator: typingIndicator)
        }
    }
    
    // This function called when textViewDidChange
    func textViewDidChange(_ textView: UITextView) {
        
        CometChat.startTyping(indicator: typingIndicator)
        
    }
    
    // TableView Methods: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chatMessage.count
        
    }
    
    // TableView Methods: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = UITableViewCell()
        let messageData = chatMessage[indexPath.row]
        
        
        
        switch messageData.messageCategory {
            
        case .message:
            
            switch messageData.messageType{
                
            case .text:
                
                // Forms Cell for message type of TextMessage
                var textMessageCell = ChatTextMessageCell()
                textMessageCell = tableView.dequeueReusableCell(withIdentifier: textCellID, for: indexPath) as! ChatTextMessageCell
                textMessageCell.chatMessage = (messageData as? TextMessage)!
                textMessageCell.selectionStyle = .none
                textMessageCell.isUserInteractionEnabled = true
                return textMessageCell
                
            case .image where messageData.deletedAt > 0.0:
                
                // Forms Cell for message type of image Message when the message is deleted
                var deletedCell = ChatDeletedMessageCell()
                deletedCell = tableView.dequeueReusableCell(withIdentifier: deletedCellID, for: indexPath) as! ChatDeletedMessageCell
                deletedCell.chatMessage = (messageData as? MediaMessage)!
                deletedCell.selectionStyle = .none
                deletedCell.isUserInteractionEnabled = false
                return deletedCell
                
            case .image:
                
                // Forms Cell for message type of image Message
                var imageMessageCell = ChatImageMessageCell()
                imageMessageCell = tableView.dequeueReusableCell(withIdentifier: imageCellID , for: indexPath) as! ChatImageMessageCell
                imageMessageCell.chatMessage = (messageData as? MediaMessage)!
                let url = NSURL(string: (messageData as? MediaMessage)!.url!)
                imageMessageCell.chatImage.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_Pending"))
                imageMessageCell.selectionStyle = .none
                return imageMessageCell
                
            case .video where messageData.deletedAt > 0.0:
                
                // Forms Cell for message type of video Message when the message is deleted
                var deletedCell = ChatDeletedMessageCell()
                deletedCell = tableView.dequeueReusableCell(withIdentifier: deletedCellID, for: indexPath) as! ChatDeletedMessageCell
                deletedCell.chatMessage = (messageData as? MediaMessage)!
                deletedCell.selectionStyle = .none
                deletedCell.isUserInteractionEnabled = false
                return deletedCell
                
            case .video:
                
                // Forms Cell for message type of video Message
                var videoMessageCell = ChatVideoMessageCell()
                videoMessageCell = tableView.dequeueReusableCell(withIdentifier: videoCellID , for: indexPath) as! ChatVideoMessageCell
                videoMessageCell.chatMessage = (messageData as? MediaMessage)!
                videoMessageCell.selectionStyle = .none
                return videoMessageCell
                
            case .audio where messageData.deletedAt > 0.0:
                
                // Forms Cell for message type of audio Message when the video is deleted
                var deletedCell = ChatDeletedMessageCell()
                deletedCell = tableView.dequeueReusableCell(withIdentifier: deletedCellID, for: indexPath) as! ChatDeletedMessageCell
                deletedCell.chatMessage = (messageData as? MediaMessage)!
                deletedCell.selectionStyle = .none
                deletedCell.isUserInteractionEnabled = false
                return deletedCell
                
            case .audio:
                
                // Forms Cell for message type of audio Message
                var mediaMessageCell = ChatMediaMessageCell()
                mediaMessageCell = tableView.dequeueReusableCell(withIdentifier: mediaCellID, for: indexPath) as! ChatMediaMessageCell
                mediaMessageCell.chatMessage = (messageData as? MediaMessage)!
                mediaMessageCell.selectionStyle = .none
                mediaMessageCell.fileIconImageView.image = #imageLiteral(resourceName: "play")
                return mediaMessageCell
                
            case .file where messageData.deletedAt > 0.0:
                
                // Forms Cell for message type of file Message when the video is deleted
                var deletedCell = ChatDeletedMessageCell()
                deletedCell = tableView.dequeueReusableCell(withIdentifier: deletedCellID, for: indexPath) as! ChatDeletedMessageCell
                deletedCell.chatMessage = (messageData as? MediaMessage)!
                deletedCell.selectionStyle = .none
                deletedCell.isUserInteractionEnabled = false
                return deletedCell
                
            case .file:
                
                // Forms Cell for message type of file Message
                var mediaMessageCell = ChatMediaMessageCell()
                mediaMessageCell = tableView.dequeueReusableCell(withIdentifier: mediaCellID, for: indexPath) as! ChatMediaMessageCell
                mediaMessageCell.chatMessage = (messageData as? MediaMessage)!
                mediaMessageCell.selectionStyle = .none
                mediaMessageCell.fileIconImageView.image = #imageLiteral(resourceName: "file")
                return mediaMessageCell
                
            case .custom: break
                
            case .groupMember: break
                
            }
            
        case .action:
            
            // Forms Cell for message type of action Message
            var actionCell = ChatActionMessageCell()
            let actionMessage = (messageData as? ActionMessage)!
            actionCell = tableView.dequeueReusableCell(withIdentifier: actionCellID, for: indexPath) as! ChatActionMessageCell
            actionCell.actionMessageLabel.text = actionMessage.message
            actionCell.selectionStyle = .none
            actionCell.isUserInteractionEnabled = false
            return actionCell
            
        case .call:
            
            // Forms Cell for message type of action Message for calls
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
            actionCell.isUserInteractionEnabled = false
            return actionCell
         
        case .custom:break
        }
        return cell
    }
    
    
    // TableView Methods: didSelectRowAt: This function called when tap on TableView Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let messageData = chatMessage[indexPath.row]
        
        let textMessage =  messageData as? TextMessage
        switch messageData.messageType{
            
        case .text where messageData.sender?.uid == myUID:
            // Persent actionSheet when tap on TextMessage
            let actionController = SkypeActionController()
            actionController.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_COLOR)
            let messageInfoAction = Action("Message Info", style: .default, handler: { action in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let messageInfoView = storyboard.instantiateViewController(withIdentifier: "messageInfoView") as! messageInfoView
                messageInfoView.title = "Message Info"
                messageInfoView.message = messageData
                self.navigationController?.pushViewController(messageInfoView, animated: true)
            })
            let editAction = Action("Edit Message", style: .default, handler: { action in
                self.editMessageFlag = true
                self.chatInputView.text = textMessage?.text
                self.chatInputView.textColor = UIColor.black
                self.editMessage = textMessage
            })
            let deleteTextAction = Action("Delete Message", style: .default, handler: { action in
                CometChat.delete(messageId: messageData.id, onSuccess: { (baseMessage) in
                    let textMessage:TextMessage = (baseMessage as? ActionMessage)?.actionOn as! TextMessage
                    self.chatMessage[(self.tableIndexPath?.row)!] = textMessage
                    DispatchQueue.main.async {
                        self.chatTableview.reloadRows(at: [self.tableIndexPath!], with: .automatic)
                    }
                }) { (error) in
                    print("delete message failed with error : \(error.errorDescription)")
                }
            })
            actionController.addAction(messageInfoAction)
            actionController.addAction(editAction)
            actionController.addAction(deleteTextAction)
            actionController.addAction(Action("Cancel", style: .cancel, handler: nil))
            present(actionController, animated: true, completion: nil)
            
        case .text: break
            
        case .image where messageData.sender?.uid == myUID:
            
            // Persent actionSheet when hold on imageMessage
            let imageMessage = messageData as? MediaMessage
            self.deleteMessage = imageMessage
            self.tableIndexPath = indexPath
            let tapAndHold = UILongPressGestureRecognizer(target: self, action: #selector(deleteActionTriggered))
            self.view.addGestureRecognizer(tapAndHold)
            
            // Persent DetailView when tap on imageMessage
            let imageCell:ChatImageMessageCell = tableView.cellForRow(at: indexPath) as! ChatImageMessageCell
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let profileAvtarViewController = storyboard.instantiateViewController(withIdentifier: "ccprofileAvtarViewController") as! CCprofileAvtarViewController
            navigationController?.pushViewController(profileAvtarViewController, animated: true)
            profileAvtarViewController.profileAvtar =  imageCell.chatImage.image
            profileAvtarViewController.hidesBottomBarWhenPushed = true
            
            
        case .image:
            // Persent DetailView when tap on imageMessage
            let imageCell:ChatImageMessageCell = tableView.cellForRow(at: indexPath) as! ChatImageMessageCell
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let profileAvtarViewController = storyboard.instantiateViewController(withIdentifier: "ccprofileAvtarViewController") as! CCprofileAvtarViewController
            navigationController?.pushViewController(profileAvtarViewController, animated: true)
            profileAvtarViewController.profileAvtar =  imageCell.chatImage.image
            profileAvtarViewController.hidesBottomBarWhenPushed = true
            
            
        case .video where messageData.sender?.uid == myUID:
            
            // Persent actionSheet when hold on videoMessage
            let videoMessage = messageData as? MediaMessage
            self.deleteMessage = videoMessage
            self.tableIndexPath = indexPath
            let tapAndHold = UILongPressGestureRecognizer(target: self, action: #selector(deleteActionTriggered))
            self.view.addGestureRecognizer(tapAndHold)
            
            // Persent AVPlayer when tap on videoMessage
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
            
        case .video:
            
            // Persent AVPlayer when tap on videoMessage
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
            
        case .audio where messageData.sender?.uid == myUID:
            
            // Persent actionsheer when hold on audioMessage
            let audioMessage = messageData as? MediaMessage
            self.deleteMessage = audioMessage
            self.tableIndexPath = indexPath
            let tapAndHold = UILongPressGestureRecognizer(target: self, action: #selector(deleteActionTriggered))
            self.view.addGestureRecognizer(tapAndHold)
            
            // Persent previewPlayer when tap on audioMessage
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
            
        case .audio:
            
            // Persent QuickLook when tap on audioMessage
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
            
        case .file where messageData.sender?.uid == myUID:
            
            // Persent actionsheet when hold on fileMessage
            let fileMessage = messageData as? MediaMessage
            self.deleteMessage = fileMessage
            self.tableIndexPath = indexPath
            let tapAndHold = UILongPressGestureRecognizer(target: self, action: #selector(deleteActionTriggered))
            self.view.addGestureRecognizer(tapAndHold)
            
            // Persent QuickLook when tap on fileMessage
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
            
            
        case .file:
            
            // Persent QuickLook when tap on fileMessage
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
            
        case .custom: break
        case .groupMember:break
        }
        
    }
    
    //This function present the action sheet on hold and delete the selected message on deleteMediaAction
    @objc func deleteActionTriggered(sender: UILongPressGestureRecognizer)
    {
        if(sender.state == .began){
            let actionController = SkypeActionController()
            actionController.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
            let messageInfoAction = Action("Message Info", style: .default, handler: { action in
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let messageInfoView = storyboard.instantiateViewController(withIdentifier: "messageInfoView") as! messageInfoView
                messageInfoView.title = "Message Info"
                messageInfoView.message = self.deleteMessage
                self.navigationController?.pushViewController(viewController: messageInfoView, animated: true, completion: {
                    
                })
            })
            
            let deleteMediaAction = Action("Delete Message", style: .default, handler: { action in
                
                CometChat.delete(messageId: self.deleteMessage!.id, onSuccess: { (baseMessage) in
                    let mediaMessage:MediaMessage = (baseMessage as? ActionMessage)?.actionOn as! MediaMessage
                    self.chatMessage[(self.tableIndexPath?.row)!] = mediaMessage
                    DispatchQueue.main.async {
                        self.chatTableview.reloadRows(at: [self.tableIndexPath!], with: .automatic)
                    }
                }) { (error) in
                    print("delete message failed with error : \(error.errorDescription)")
                }
            })
            actionController.addAction(messageInfoAction)
            actionController.addAction(deleteMediaAction)
            actionController.addAction(Action("Cancel", style: .destructive, handler: nil))
            present(actionController, animated: true, completion: nil)
        }
        //Different code
    }
    
    // QLPreviewController: numberOfPreviewItems
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    // QLPreviewController: previewItemAt
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
    
    
    // This function sends or edit the Message when send button pressed
    @IBAction func sendButton(_ sender: Any) {
        print(chatInputView.text!)
        
        let message:String = chatInputView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(message.count == 0 || message == NSLocalizedString("Type a message...", comment: "")){
            
        }else if editMessageFlag == true{
            
            editMessage(toUserUID: editMessage!.receiverUid, messageID: editMessage!.id, message: message + " (Edited) ", isGroup: isGroup) { (message, error) in
                
                print("sendMessage: \(String(describing: (message as? ActionMessage)))")
                guard  let sendMessage =  message else{
                    return
                }
                self.editMessageFlag = false
                self.editMessage = nil
                DispatchQueue.main.async{
                    self.chatInputView.text = ""
                    let editedMessage:TextMessage = (sendMessage as? ActionMessage)?.actionOn as! TextMessage
                    print("editedMessage \(editedMessage.stringValue())")
                    self.chatMessage[(self.tableIndexPath?.row)!] = editedMessage
                    self.chatTableview.reloadRows(at: [self.tableIndexPath!], with: .automatic)
                    self.tableIndexPath = nil
                }
            }
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
        //The code is written in audioRecord(_ sender: UIGestureRecognizer)
    }
    
    
    //This method present the action sheet and send the media message according to action.
    @IBAction func attachementButtonPressed(_ sender: Any) {
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // -----------  Present the Camera --------------//
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
                        var imageURL = docDir.appendingPathComponent("temp.png")
                        try! imageData.write(to: imageURL)
                        picker.dismiss(animated: true, completion: nil)
                        
                        self.sendMediaMessage(toUserUID: self.buddyUID, mediaURL: imageURL.absoluteString, isGroup: self.isGroup, messageType: .image, completionHandler: { (message, error) in
                            imageURL.removeAllCachedResourceValues()
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
        // -----------  Present the Camera  End--------------//
        
        // -----------  Present the PhotoLibrary --------------//
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
        
        // -----------  Present the PhotoLibrary End--------------//
        
        
        // -----------  Present the DocumentLibrary --------------//
        let documentAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Document", comment: ""), style: .default) { action -> Void in
            
            self.clickFunction()
            
        }
        documentAction.setValue(UIImage(named: "document.png"), forKey: "image")
        // -----------  Present the DocumentLibrary End --------------//
        
        let cancelAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
        }
        
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        actionSheetController.addAction(cameraAction)
        actionSheetController.addAction(photoLibraryAction)
        actionSheetController.addAction(documentAction)
        actionSheetController.addAction(cancelAction)
        
        // Added ActionSheet support for iPad
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
    
    // This function present the audioCall Screen
    @IBAction func audioCallPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CallingViewController = storyboard.instantiateViewController(withIdentifier: "callingViewController") as! CallingViewController
        CallingViewController.isAudioCall = "1"
        presentCalling(CallingViewController: CallingViewController)
        
    }
    
    // This function present the videoCall Screen
    @IBAction func videoCallPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CallingViewController = storyboard.instantiateViewController(withIdentifier: "callingViewController") as! CallingViewController
        CallingViewController.isAudioCall = "0"
        presentCalling(CallingViewController: CallingViewController);
        
    }
    
    @IBAction func moreButtonPressed(_ sender: Any) {
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let searchAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Search Message", comment: ""), style: .default) { action -> Void in
            
            if #available(iOS 11.0, *) {
                self.navigationItem.searchController = self.searchController
            } else {
                
            }
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
            
        }
        
        actionSheetController.addAction(searchAction)
        actionSheetController.addAction(cancelAction)
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ){
            
            if let currentPopoverpresentioncontroller = actionSheetController.popoverPresentationController{
                currentPopoverpresentioncontroller.sourceView = self.view
                currentPopoverpresentioncontroller.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                currentPopoverpresentioncontroller.permittedArrowDirections = []
            }
            self.present(actionSheetController, animated: true, completion: nil)
        }else{
            self.present(actionSheetController, animated: true, completion: nil)
        }
        
    }
    
    
    // Function presentCalling
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
    
    
    // Function hideKeyboardWhenTappedOnTableView
    func hideKeyboardWhenTappedOnTableView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        chatTableview.addGestureRecognizer(tap)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = nil
            self.ChatViewBottomconstraint.constant = 0
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
            
        } else {
            // Fallback on earlier versions
        }
    }
    
}

extension ChatViewController : CometChatMessageDelegate {
    
    // This event triggers when new text Message receives.
    func onTextMessageReceived(textMessage: TextMessage) {
      //  if textMessage.sender?.uid == buddyUID && textMessage.receiverType.rawValue == Int(isGroup){
            CometChat.markMessageAsRead(message: textMessage)
            self.chatMessage.append(textMessage)
            DispatchQueue.main.async{
                self.chatTableview.reloadData()
                self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
           // }
            
//        }else if textMessage.receiverUid == buddyUID && textMessage.receiverType.rawValue == Int(isGroup) && textMessage.senderUid != myUID {
//            CometChat.markMessageAsRead(message: textMessage)
//            self.chatMessage.append(textMessage)
//            DispatchQueue.main.async{
//                self.chatTableview.reloadData()
//                self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
//            }
        }
    }
    
    func onMessageEdited(message: BaseMessage) {
         print("onMessageEdited --> \(message)")
        if let row = self.chatMessage.firstIndex(where: {$0.id == message.id}) {
            chatMessage[row] = message
            let indexPath = IndexPath(row: row, section: 0)
             DispatchQueue.main.async{
                self.chatTableview.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func onMessageDeleted(message: BaseMessage) {
        print("onMessageDeleted --> \(message)")
        if let row = self.chatMessage.firstIndex(where: {$0.id == message.id}) {
            chatMessage[row] = message
            let indexPath = IndexPath(row: row, section: 0)
             DispatchQueue.main.async{
                self.chatTableview.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    
    // This event triggers when new Media Message receives.
    func onMediaMessageReceived(mediaMessage: MediaMessage){
        if mediaMessage.sender?.uid == buddyUID && mediaMessage.receiverType.rawValue == Int(isGroup){
            CometChat.markMessageAsRead(message: mediaMessage)
            self.chatMessage.append(mediaMessage)
            DispatchQueue.main.async{
                self.chatTableview.reloadData()
                self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
            }
        }else if mediaMessage.receiverUid == buddyUID && mediaMessage.receiverType.rawValue == Int(isGroup){
            CometChat.markMessageAsRead(message: mediaMessage)
            self.chatMessage.append(mediaMessage)
            DispatchQueue.main.async{
                self.chatTableview.reloadData()
                self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
            }
        }
    }
    
    
    // This event triggers when user is started Typing.
    func onTypingStarted(_ typingDetails : TypingIndicator) {
         DispatchQueue.main.async{
            if typingDetails.sender?.uid == self.buddyUID && typingDetails.receiverType == .user{
                self.buddyStatus.text = NSLocalizedString("Typing...", comment: "")
            }else if typingDetails.receiverType == .group  && self.isGroup == "1"{
            let user = typingDetails.sender?.name
                self.buddyStatus.text = NSLocalizedString("\(user!) is Typing...", comment: "")
        }
        }
    }
    
    // This event triggers when user is ended Typing.
    func onTypingEnded(_ typingDetails : TypingIndicator) {
        // received typing indicator:
         DispatchQueue.main.async{
            if typingDetails.sender?.uid == self.buddyUID && typingDetails.receiverType == .user{
                self.buddyStatus.text = NSLocalizedString("Online", comment: "")
            }else if typingDetails.receiverType == .group  && self.isGroup == "1"{
                self.buddyStatus.text = NSLocalizedString("", comment: "")
        }
        }
    }
    
    // This event triggers when message is delivered to the user.
    func onMessageDelivered(receipt : MessageReceipt) {
        let receipts:MessageReceipt?
        receipts = receipt
        guard let deliveredReceipt = receipts else{
            return
        }
        if let row = self.chatMessage.firstIndex(where: {$0.id == Int(deliveredReceipt.messageId)}) {
            if deliveredReceipt.receiptType == .delivered {
                chatMessage[row].deliveredToMeAt = Double(deliveredReceipt.timeStamp)
            }
            
            if deliveredReceipt.receiverType == .user{
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                self.chatTableview.reloadRows(at: [indexPath], with: .none)
                self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: false)
            }
            }
        }
     }
    
    // This event triggers when user reads the message.
    func onMessageRead(receipt : MessageReceipt) {
        let receipts:MessageReceipt?
        receipts = receipt
        guard let readReceipt = receipts else{
            return
        }
        if let row = self.chatMessage.firstIndex(where: {$0.id == Int(readReceipt.messageId)}) {
            if readReceipt.receiptType == .read {
                chatMessage[row].readByMeAt = Double(readReceipt.timeStamp)
            }
            if readReceipt.receiverType == .user{
                let indexPath = IndexPath(row: row, section: 0)
                DispatchQueue.main.async {
                    self.chatTableview.reloadRows(at: [indexPath], with: .none)
                    self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: false)
                }
            }
        }
    }
    
}


extension ChatViewController : CometChatGroupDelegate {
  
    // This event triggers when scope of the user chaged to other scope in group.
    func onGroupMemberScopeChanged(action: ActionMessage, scopeChangeduser: User, scopeChangedBy: User, scopeChangedTo: String, scopeChangedFrom: String, group: Group) {
        if action.receiverUid == buddyUID && action.receiverType.rawValue == Int(isGroup){
                    self.chatMessage.append(action)
                    DispatchQueue.main.async{
                        self.chatTableview.reloadData()
                        self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
                    }
                }
    }
    
    
    // This event triggers when new member is added in the group
    func onAddedToGroup(action: ActionMessage, addedBy: User, addedTo: Group) {
        
        if action.receiverUid == buddyUID && action.receiverType.rawValue == Int(isGroup){
        self.chatMessage.append(action)
        DispatchQueue.main.async{
            self.chatTableview.reloadData()
            self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
        }
        }
    }
    // This event triggers when new member is added in the group
    func onMemberAddedToGroup(action: ActionMessage, addedBy: User, addedUser: User, addedTo: Group) {
        
        if action.receiverUid == buddyUID && action.receiverType.rawValue == Int(isGroup){
        self.chatMessage.append(action)
        DispatchQueue.main.async{
            self.chatTableview.reloadData()
            self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
        }
        }
    }
    
    
    // This event triggers when user joins to group.
    func onGroupMemberJoined(action: ActionMessage, joinedUser: User, joinedGroup: Group) {
        
        if action.receiverUid == buddyUID && action.receiverType.rawValue == Int(isGroup){
        self.chatMessage.append(action)
        DispatchQueue.main.async{
            self.chatTableview.reloadData()
            self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
        }
        }
    }
    
    // This event triggers when user lefts the group.
    func onGroupMemberLeft(action: ActionMessage, leftUser: User, leftGroup: Group) {
        
        if action.receiverUid == buddyUID && action.receiverType.rawValue == Int(isGroup){
        self.chatMessage.append(action)
        DispatchQueue.main.async{
            self.chatTableview.reloadData()
            self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
        }
        }
    }
    
    // This event triggers when user kicked from the group.
    func onGroupMemberKicked(action: ActionMessage, kickedUser: User, kickedBy: User, kickedFrom: Group) {
        
        if action.receiverUid == buddyUID && action.receiverType.rawValue == Int(isGroup){
        self.chatMessage.append(action)
        
        DispatchQueue.main.async{
            self.chatTableview.reloadData()
            self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
        }
        }
        
    }
    
    // This event triggers when user banned from the group.
    func onGroupMemberBanned(action: ActionMessage, bannedUser: User, bannedBy: User, bannedFrom: Group) {
        
        if action.receiverUid == buddyUID && action.receiverType.rawValue == Int(isGroup){
        self.chatMessage.append(action)
        
        DispatchQueue.main.async{
            self.chatTableview.reloadData()
            self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
        }
        }
    }
    
    // This event triggers when user unbanned from the group.
    func onGroupMemberUnbanned(action: ActionMessage, unbannedUser: User, unbannedBy: User, unbannedFrom: Group) {
        
        if action.receiverUid == buddyUID && action.receiverType.rawValue == Int(isGroup){
        self.chatMessage.append(action)
        
        DispatchQueue.main.async{
            self.chatTableview.reloadData()
            self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
        }
        }
    }
    
    // This event triggers when user changes the scope of the user for the group.
    
}

extension ChatViewController : CometChatUserDelegate {
    
    // This event triggers when user is Online.
    func onUserOnline(user: User) {
        if user.uid == buddyUID{
            if user.status == .online {
                DispatchQueue.main.async {
                    self.buddyStatus.text = NSLocalizedString("Online", comment: "")
                }
            }
        }
    }
    
    // This event triggers when user is Offline.
    func onUserOffline(user: User) {
        if user.uid == buddyUID{
            if user.status == .offline {
                 DispatchQueue.main.async {
                    self.buddyStatus.text = NSLocalizedString("Offline", comment: "")
                }
            }
        }
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

// This is we need to make it looks as a popup window on iPhone
extension ChatViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
       
        if(isGroup == "1"){
            messageRequest = MessagesRequest.MessageRequestBuilder().set(guid: buddyUID).set(limit: 20).set(searchKeyword: searchController.searchBar.text!).build()
        }else{
            messageRequest = MessagesRequest.MessageRequestBuilder().set(uid: buddyUID).set(searchKeyword: searchController.searchBar.text!).set(limit: 20).build()
        }
        
        //Fetching Previous Messages
        fetchPreviousMessages(messageReq: messageRequest) { (message, error) in
            guard  let sendMessage = message else{
                return
            }
            var messages = [BaseMessage]()
            for msg in sendMessage{
                
                if (((msg as? ActionMessage) != nil) && ((msg as? ActionMessage)?.message == "Message is edited.") ||  ((msg as? ActionMessage)?.message == "Message is deleted.")){
                    
                }else{
                    //Appending Other Messages
                    messages.append(msg)
                }
            }
            self.chatMessage = messages
            DispatchQueue.main.async{
                self.chatTableview.reloadData()
            }
        }
    }
}
