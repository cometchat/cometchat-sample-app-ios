//
//  Splash.swift
//  CometChatSwift
//
//  Created by admin on 27/09/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit

class Splash: UIViewController {

    //MARK: OUTLETS
    @IBOutlet weak var gradientImage: GradientImageView!
    @IBOutlet weak var titleSuplimentoryText: UILabel!
    @IBOutlet weak var titleText: UILabel!
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            let gradLayers = self.gradientImage.layer.sublayers?.compactMap { $0 as? CAGradientLayer }
            gradLayers?.first?.frame = self.gradientImage.bounds
        }
    }
    
    //MARK: FUNCTIONS
    func setupUI() {
        navigationController?.isNavigationBarHidden = true
        titleSuplimentoryText.font = FontKit.roundedFont(ofSize: 24, weight: .bold)
        titleText.font = FontKit.roundedFont(ofSize: 90, weight: .bold)
    }
    
    @IBAction func btnGetStarted_Pressed(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Login") as? Login
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
