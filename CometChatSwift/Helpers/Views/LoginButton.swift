//
//  LoginButton.swift
//  CometChatSwift
//
//  Created by nabhodipta on 17/06/24.
//  Copyright © 2024 MacMini-03. All rights reserved.
//

import UIKit

class CustomLoginButton: UIView {
    
    private let imageViewSize: CGFloat = 24.0
    private let buttonHeight: CGFloat = 50.0
    private let buttonWidth: CGFloat = 161.8
    private let padding: CGFloat = 10.0
    
    private var onTap: (() -> Void)?
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private var leadingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        label.numberOfLines = 1
        label.lineBreakMode = .byClipping
        label.textAlignment = .left
        return label
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let backgroundImage = UIImage(named: "Background") {
            imageView.image = backgroundImage
        }
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.16
        return imageView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildUI()
    }
    
    func buildUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Add the background image view to the button
        addSubview(backgroundImageView)
        sendSubviewToBack(backgroundImageView)
        
        // Set constraints for the background image view
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        // adding leading avatar image view
        let imageBackground = UIView()
               imageBackground.translatesAutoresizingMaskIntoConstraints = false
               imageBackground.backgroundColor = .white
               imageBackground.layer.cornerRadius = 15.0
               imageBackground.layer.masksToBounds = true // Ensure the corners are clipped

        imageBackground.layer.borderColor = UIColor.lightGray.cgColor
        imageBackground.layer.borderWidth = 0.25
               imageBackground.addSubview(leadingImageView)
        addSubview(imageBackground)
        //setting constraints for the image and its background
        NSLayoutConstraint.activate([
                  
                   imageBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
                   imageBackground.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding+imageViewSize+6),
                   imageBackground.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                   imageBackground.widthAnchor.constraint(equalToConstant: imageViewSize+6),
                   imageBackground.heightAnchor.constraint(equalToConstant: imageViewSize+6),
                   leadingImageView.widthAnchor.constraint(equalToConstant: imageViewSize),
                
                   leadingImageView.heightAnchor.constraint(equalToConstant: imageViewSize),
                   leadingImageView.centerYAnchor.constraint(equalTo: imageBackground.centerYAnchor),
                   leadingImageView.centerXAnchor.constraint(equalTo: imageBackground.centerXAnchor),
               ])
        
        
        //adding title label for User name
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageBackground.trailingAnchor,constant: 5),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -5),
        ])
        

        addSubview(subtitleLabel)
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: imageBackground.trailingAnchor,constant: 5),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
        
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapped)))

    }
    
    @objc func onTapped() {
        if let tap = onTap {
            tap()
        }
    }
    
    @discardableResult
    public func set(title: String) -> Self {
        self.titleLabel.text = title
        return self
    }
    
    @discardableResult
    public func set(subtitle: String) -> Self {
        self.subtitleLabel.text = subtitle
        return self
    }
    
    @discardableResult
    public func set(avatar: String) -> Self {
        if let url = URL(string: avatar) {
            setLeadingImageView(from: url)
        }
        return self
    }

    
    @discardableResult
    public func set(onTap: @escaping (() -> Void)) -> Self {
        self.onTap = onTap
        return self
    }
    
    func setLeadingImageView(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async { [weak self] in
                self?.leadingImageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
}
