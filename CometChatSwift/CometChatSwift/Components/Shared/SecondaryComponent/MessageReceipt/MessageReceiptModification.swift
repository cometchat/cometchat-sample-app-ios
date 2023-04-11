//
//  MessageReceiptModification.swift
//  CometChatSwift
//
//  Created by admin on 24/08/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatUIKit
import CometChatPro

class MessageReceiptModification: UIViewController {

    //MARK: OUTLETS
    @IBOutlet weak var receiptTableView: UITableView!
    
    //MARK: VARIABLES
    var textMessage =  TextMessage(receiverUid: "superhero", text: "Good Morning", receiverType: .user)
    var identifier = "MessageReceiptCell"
    
    func setupView() {
        let blurredView = blurView(view: self.view)
        view.addSubview(blurredView)
        view.sendSubviewToBack(blurredView)
    }
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemFill
        setupTableView()
        setupView()
    }
    
    //MARK: FUNCTIONS
    private func setupTableView() {
        self.receiptTableView.delegate = self
        self.receiptTableView.dataSource = self
        self.receiptTableView.separatorStyle = .none
        let receiptCell  = UINib.init(nibName: identifier, bundle: nil)
        self.receiptTableView.register(receiptCell, forCellReuseIdentifier: identifier)
    }
    
    @IBAction func onCloseClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

//MARK: TABELVIEW DELEGATE AND DATASOURCE METHODS
extension MessageReceiptModification: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let receiptCell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MessageReceiptCell else { fatalError()}
        receiptCell.index = indexPath.row
        receiptCell.selectionStyle = .none
        return receiptCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
