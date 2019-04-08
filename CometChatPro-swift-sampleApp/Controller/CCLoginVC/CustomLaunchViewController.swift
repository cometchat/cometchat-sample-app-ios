//
//  CustomLaunchViewController.swift
//  CometChatUI
//
//  Created by pushpsen airekar on 17/11/18.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.
//

import UIKit

class CustomLaunchViewController: UIViewController {
    
    //Outlets Declarations
    @IBOutlet weak var cometChatLogo: UIImageView!
    @IBOutlet weak var bottomV: UIView!
    
    //Variable Declarations
    var CCtabBarViewController = CCTabbar()
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Funtion Calling
        self.handleCustomLaunchVCApperance()
    }
    
    //This method handles the UI customization for CustomLaunchVC
    func handleCustomLaunchVCApperance(){
        
        self.view.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.BACKGROUND_COLOR)
        cometChatLogo.image = cometChatLogo.image!.withRenderingMode(.alwaysTemplate)
        cometChatLogo.tintColor = UIColor.init(hexFromString: UIAppearanceColor.LOGO_TINT_COLOR)
        UIView.animate(withDuration: 2, animations: {
            self.cometChatLogo.frame.origin.y  -= 200
        }, completion: { (finished: Bool) in
            self.CCtabBarViewController = self.storyboard?.instantiateViewController(withIdentifier: "CCtabBar") as! CCTabbar
            self.present(self.CCtabBarViewController, animated: false, completion: nil)
        })
        
    }
    
}
