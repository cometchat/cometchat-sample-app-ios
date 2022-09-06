//
//  ThemeComponent.swift
//  CometChatSwift
//
//  Created by admin on 14/08/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatPro
import CometChatUIKit
class ThemeComponent: UIViewController {
  
    //MARK: Theme Outlets
   
    @IBOutlet weak var fontType: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var themeSelectionSegment: UISegmentedControl!
    @IBOutlet weak var colorTypeSegment: UISegmentedControl!
    @IBOutlet weak var themeViewContainer: UIView!
    
    
    var font: UIFont?
    var fontColor: UIColor?
    var palette = Palette()
    var typography = Typography()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        themeViewContainer.dropShadow()
    }
    

    @IBAction func colorTypeSegmentPressed(_ sender: UISegmentedControl) {

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
