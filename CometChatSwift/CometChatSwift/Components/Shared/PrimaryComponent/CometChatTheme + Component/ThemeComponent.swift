//
//  ThemeComponent.swift
//  CometChatSwift
//
//  Created by admin on 14/08/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatSDK
import CometChatUIKitSwift

class ThemeComponent: UIViewController {
  
    //MARK: OUTLETS
    @IBOutlet weak var gradientBackground: GradientImageView!
    @IBOutlet weak var themeSelectionSegment: UISegmentedControl!
    @IBOutlet weak var themeViewContainer: UIView!
    
    //MARK: VARIABLES
    var font: UIFont?
    var fontColor: UIColor?
    var palette = Palette()
    var typography = Typography()
    
    func setupView() {
        DispatchQueue.main.async {
            let blurredView = self.blurView(view: self.view)
            self.view.addSubview(blurredView)
            self.view.sendSubviewToBack(blurredView)
        }
    }
    
    //MARK: LIFE CYLCE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemFill
        themeViewContainer.dropShadow()
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
    
    @IBAction func buttonModifyPressed(_ sender: UIButton) {
        switch themeSelectionSegment.selectedSegmentIndex {
        case 0:
            CometChatTheme.defaultAppearance()
        case 1:
            palette.set(background: .black)
            palette.set(primary: .green)
            palette.set(secondary: .darkGray)
            palette.set(accent: .green)
            palette.set(success: .green)
            palette.set(error: .red)
            
            let cometChatFontFamily = CometChatFontFamily(regular: "AmericanTypewriter",
                                                          medium: "AmericanTypewriter-Semibold",
                                                          semibold: "AmericanTypewriter-Semibold",
                                                          bold: "AmericanTypewriter-Bold")
            typography.overrideFont(family: cometChatFontFamily)
            CometChatTheme(typography: typography, palatte: palette)
        default:
            break
        }
        
        let cometchatDetail = CometChatConversations()
        let navigationController = UINavigationController(rootViewController: cometchatDetail)
        self.present(navigationController, animated: true)
    }
    
}
