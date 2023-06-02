//
//  Localisation+Component.swift
//  CometChatSwift
//
//  Created by admin on 01/09/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatUIKit

class LocalisationComponent: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var setLanguage: UISegmentedControl!
    @IBOutlet weak var componentDescription: UILabel!
    @IBOutlet weak var gradientBackground: GradientImageView!
    
    func setupView() {
        DispatchQueue.main.async {
            let blurredView = self.blurView(view: self.view)
            self.view.addSubview(blurredView)
            self.view.sendSubviewToBack(blurredView)
        }
    }
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemFill
        containerView.dropShadow()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            let gradLayers = self.gradientBackground.layer.sublayers?.compactMap { $0 as? CAGradientLayer }
            gradLayers?.first?.frame = self.gradientBackground.bounds
        }
    }
    
    //MARK: FUNCTIONS
    @IBAction func onCloseClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func launchWithChangedLanguage(_ sender: UIButton) {
        switch setLanguage.selectedSegmentIndex {
        case 0:
            CometChatLocalize.set(locale: .english)
        case 1:
            CometChatLocalize.set(locale: .hindi)
        default:
            break
        }
        let cometchatDetail = CometChatConversationsWithMessages()
        let navigationController = UINavigationController(rootViewController: cometchatDetail)
        self.present(navigationController, animated: true)
    }
    
    @IBAction func setLanguageSelected(_ sender: UISegmentedControl) {
    }
}
