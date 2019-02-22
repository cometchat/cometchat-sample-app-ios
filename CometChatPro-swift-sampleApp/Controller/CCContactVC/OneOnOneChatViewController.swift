//
//  OneOnOneChatViewController.swift
//  CCPulse-CometChatUI-ios-master
//
//  Created by pushpsen airekar on 02/12/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit
import CometChatPro

class OneOnOneChatViewController: UIViewController,UITextViewDelegate,UITableViewDelegate, UITableViewDataSource {

    //Outlets Declarations
    @IBOutlet weak var videoCallBtn: UIBarButtonItem!
    @IBOutlet weak var audioCallButton: UIBarButtonItem!
    @IBOutlet weak var attachmentBtn: UIButton!
    @IBOutlet weak var ChatViewBottomconstraint: NSLayoutConstraint!
    @IBOutlet weak var ChatViewWithComponents: UIView!
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var chatInputView: UITextView!
    @IBOutlet weak var chatTableview: UITableView!
    
    // Variable Declarations
    var buddyUID:String!
    var buddyNameString:String!
    var buddyStatusString:String!
    var isGroup:String!
    var buddyAvtar:UIImage!
    var buddyName:UILabel!
    var buddyStatus:UILabel!
    let modelName = UIDevice.modelName
    var imagePicker = UIImagePickerController()
    var chatMessage = [Message]()
    fileprivate let cellID = "chatCell"
    fileprivate let imageCellID = "imageCell"
    private var messageRequest:MessagesRequest!
    public typealias sendMessageResponse = (_ success:getSendMessageResponse? , _ error:CometChatException?) -> Void
    public typealias userMessageResponse = (_ user:getMessageResponse? , _ error:CometChatException?) ->Void
    public typealias groupMessageResponse = (_ group:[BaseMessage]? , _ error:CometChatException?) ->Void
    

    override func viewDidLoad() {
        super.viewDidLoad()

        print("UID is: \(String(describing: buddyUID))")
        
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
        //registerCell
        chatTableview.register(ChatTextMessageCell.self, forCellReuseIdentifier: cellID)
       // chatTableview.register(ChatImageMessageCell.self, forCellReuseIdentifier: imageCellID)
        chatTableview.separatorStyle = .none
        chatTableview.allowsSelection = false
        
        fetchUserMessages(userUID: buddyUID, isGroup: isGroup) { (message, error) in
            let messages = message?.messages
            self.chatMessage = messages!
            DispatchQueue.main.async{
              self.chatTableview.reloadData()
            }
        }
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        
    }
    
    func fetchUserMessages(userUID: String, isGroup: String, completionHandler:@escaping userMessageResponse) {
        
        if(isGroup == "1"){
            messageRequest = MessagesRequest.MessageRequestBuilder().set(GUID: userUID).set(limit: 20).build()
        }else{
            messageRequest = MessagesRequest.MessageRequestBuilder().set(UID: userUID).set(limit: 20).build()
        }
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            let userMessagesArray = messages
            
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
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
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBTN
        backBTN.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
        //Video Button:
        videoCallBtn.image =  UIImage.init(named: "video_call.png")
        videoCallBtn.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        
        //Audio Button:
        audioCallButton.image =  UIImage.init(named: "audio_call.png")
        audioCallButton.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        
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
        UserProfileViewController.getUserProfileAvtar = buddyAvtar
        UserProfileViewController.getUserName = buddyName.text
        UserProfileViewController.getUserStatus = buddyStatus.text
        if (isGroup == "1") {
            UserProfileViewController.isDisplayType = "GroupView"
            UserProfileViewController.guid = buddyUID
        }
        else{
            UserProfileViewController.isDisplayType = "OneOneOneViewProfile"
        }
        UserProfileViewController.hidesBottomBarWhenPushed = true
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let userinfo = notification.userInfo
        {
            let keyboardFrame = (userinfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            
            if(modelName == "iPhone 5" || modelName == "iPhone 5s" || modelName == "iPhone 5c" || modelName == "iPhone SE" ){
                 self.view.frame.origin.y = -keyboardFrame!.height + 60;
            }else if (modelName == "iPhone 6 Plus" || modelName == "iPhone 6s Plus" || modelName == "iPhone 7 Plus" || modelName == "iPhone 8 Plus"){
                self.view.frame.origin.y = -keyboardFrame!.height + 60;
            }else if(modelName == "iPhone XS Max"){
               self.view.frame.origin.y = -keyboardFrame!.height + 32;
            }else if (modelName == "iPhone X" || modelName == "iPhone XS") {
                print("I m in iphone x")
                self.view.frame.origin.y = -keyboardFrame!.height + 32;
            }else if(modelName == "iPhone XR"){
                self.view.frame.origin.y = -keyboardFrame!.height + 32;
            }else if(modelName == "iPad Pro (12.9-inch) (2nd generation)"){
                self.view.frame.origin.y = -keyboardFrame!.height + 60;
            }else{
                self.view.frame.origin.y = -keyboardFrame!.height + 60;
            }
           
        }
        
       
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        print("In keyboardWillHide")
        if self.view.frame.origin.y != 0 {
            if(modelName == "iPhone 5" || modelName == "iPhone 5s" || modelName == "iPhone 5c" || modelName == "iPhone SE" ){
               self.view.frame.origin.y = 60
            }else if (modelName == "iPhone 6 Plus" || modelName == "iPhone 6s Plus" || modelName == "iPhone 7 Plus" || modelName == "iPhone 8 Plus"){
                self.view.frame.origin.y = 60
            }else if(modelName == "iPhone XS Max"){
                self.view.frame.origin.y = 32
            }else if (modelName == "iPhone X" || modelName == "iPhone XS") {
                print("I m in iphone x")
                self.view.frame.origin.y = 32
            }else if(modelName == "iPhone XR"){
                self.view.frame.origin.y = 32
            }else if(modelName == "iPad Pro (12.9-inch) (2nd generation)"){
                self.view.frame.origin.y = 60
            }else{
                self.view.frame.origin.y = 60
            }
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatTextMessageCell
        
        cell.selectionStyle = .none
        
        let messageData = chatMessage[indexPath.row]

        if(messageData.messageType == "media"){
            
            cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatTextMessageCell
            
        }
        
        cell.chatMessage = messageData
        //cell.isIncomingMessage = messageData.isSelf
        return cell
        
    }
    
    
    @IBAction func sendButton(_ sender: Any) {
        print(chatInputView.text!)

        let message:String = chatInputView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(message.count == 0 || message == "Type a message..."){
            print("error encountered")
        }else{

           sendMessage(toUserUID: buddyUID, message: message, isGroup: isGroup) { (message, error) in
                
                print("here the message is \(String(describing: message?.messages))")
                let sendMessage =  message?.messages
                self.chatMessage.append(sendMessage!)
                
                DispatchQueue.main.async{
                    self.chatTableview.beginUpdates()
                    self.chatTableview.insertRows(at: [IndexPath.init(row: self.chatMessage.count-1, section: 0)], with: .automatic)
                    
                    self.chatTableview.endUpdates()
                    self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableViewScrollPosition.none, animated: true)
                    self.chatInputView.text = ""
                }
            }
        }
    }
    
    @IBAction func attachementButtonPressed(_ sender: Any) {
        
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction: UIAlertAction = UIAlertAction(title: "Camera", style: .default) { action -> Void in

            self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            //imag.mediaTypes = [kUTTypeImage];
            self.imagePicker.allowsEditing = false
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        cameraAction.setValue(UIImage(named: "camera.png"), forKey: "image")
        
        let photoLibraryAction: UIAlertAction = UIAlertAction(title: "Photo & Video Library", style: .default) { action -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
                
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
                //imag.mediaTypes = [kUTTypeImage];
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            
        }
        photoLibraryAction.setValue(UIImage(named: "gallery.png"), forKey: "image")
        
        let documentAction: UIAlertAction = UIAlertAction(title: "Document", style: .default) { action -> Void in
            
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
        CallingViewController.isAudioCall = true
        presentCalling(CallingViewController: CallingViewController)
        
    }
    @IBAction func videoCallPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CallingViewController = storyboard.instantiateViewController(withIdentifier: "callingViewController") as! CallingViewController
        CallingViewController.isAudioCall = false
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
    
    @objc override func dismissKeyboard() {
        chatInputView.resignFirstResponder()
        if self.view.frame.origin.y != 0 {
            if(modelName == "iPhone 5" || modelName == "iPhone 5s" || modelName == "iPhone 5c" || modelName == "iPhone SE" ){
                self.view.frame.origin.y = 60
            }else if (modelName == "iPhone 6 Plus" || modelName == "iPhone 6s Plus" || modelName == "iPhone 7 Plus" || modelName == "iPhone 8 Plus"){
                self.view.frame.origin.y = 60
            }else if(modelName == "iPhone XS Max"){
                self.view.frame.origin.y = 32
            }else if (modelName == "iPhone X" || modelName == "iPhone XS") {
                print("I m in iphone x")
                self.view.frame.origin.y = 32
            }else if(modelName == "iPhone XR"){
                self.view.frame.origin.y = 32
            }else if(modelName == "iPad Pro (12.9-inch) (2nd generation)"){
                self.view.frame.origin.y = 60
            }else{
                self.view.frame.origin.y = 60
            }
        }
    }
}

extension OneOnOneChatViewController : CometChatMessageDelegate {
    
    func onTextMessageReceived(textMessage: TextMessage?, error: CometChatException?) {
        
        var messageDict = [String : Any]()
        let date = Date(timeIntervalSince1970: TimeInterval(textMessage!.sentAt))
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "HH:mm a"
        
        dateFormatter1.timeZone = NSTimeZone.local
        let dateString : String = dateFormatter1.string(from: date)
        print("formatted date is =  \(dateString)")
        
        if(textMessage!.receiverType == CometChat.receiverType.group){
            
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
        
        let receivedMessage = Message(dict: messageDict)
        self.chatMessage.append(receivedMessage!)
        
        DispatchQueue.main.async{
            self.chatTableview.beginUpdates()
            self.chatTableview.insertRows(at: [IndexPath.init(row: self.chatMessage.count-1, section: 0)], with: .automatic)
            
            self.chatTableview.endUpdates()
            self.chatTableview.scrollToRow(at: IndexPath.init(row: self.chatMessage.count-1, section: 0), at: UITableViewScrollPosition.none, animated: true)
        }
        
    }
    
    func onMediaMessageReceived(mediaMessage: MediaMessage?, error: CometChatException?)
    {
        
        
        
    }
}
