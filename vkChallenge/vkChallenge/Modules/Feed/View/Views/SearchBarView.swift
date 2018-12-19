//
//  SearchBarView.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 11/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

class SearchBarView: View {
    
    static let contentHeight: CGFloat = 81
    private let containerSearchImageWidth: CGFloat = 24
    private let sideViewSize: CGFloat = 14
    private let searchHeight: CGFloat = 36
    
    var onReturn: Action?
    var onChange: ((String) -> Void)?
    
    private lazy var containerSearchFrame: CGRect = {
        return CGRect(x: 0,
                      y: 0,
                      width: self.containerSearchImageWidth,
                      height: self.searchHeight)
    }()
    
    private lazy var sideViewFrame: CGRect = {
        return CGRect(x: 0,
                      y: (self.searchHeight - self.sideViewSize) / 2,
                      width: self.sideViewSize,
                      height: self.sideViewSize)
    }()
    
    private lazy var searchImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Search_16").withRenderingMode(.alwaysTemplate))
        imageView.tintColor = Color.counterIcon.value
        imageView.frame = self.sideViewFrame
        return imageView
    }()
    
    private lazy var containerSearchImageView: UIView = {
        let view = UIView(frame: self.containerSearchFrame)
        view.addSubview(self.searchImageView)
        return view
    }()
    
    private lazy var imageView = CircledImageView()
    
    private lazy var underlayTextFieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = Color.searchBar.value
        return view
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.clear
        textField.textColor = UIColor.white
        textField.textAlignment = .left
        textField.rightViewMode = .never
        textField.layer.masksToBounds = true
        textField.leftViewMode = .always
        textField.tintColor = UIColor.white
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        let attributedString = CustomFont.searchPlaceholder.attributesWithParagraph.make(string: L10n.search)
        textField.attributedPlaceholder = attributedString
        textField.leftView = self.containerSearchImageView
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        textField.returnKeyType = .search
        textField.defaultTextAttributes = CustomFont.searchText.attributesWithParagraph
        textField.tintColor = Color.postText.value
        textField.delegate = self
        return textField
    }()
    
    @objc
    func textFieldEditingChanged(sender: UITextField) {
        self.onChange?(self.text)
    }
    
    @objc
    func textFieldDidBeginEditing(sender: UITextField) {
        
    }
    
    @objc
    func textFieldDidEndEditing(sender: UITextField) {
        
    }
    
    var text: String {
        return self.textField.text ?? ""
    }
    
    override func initialSetup() {
        super.initialSetup()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.imageView)
        self.addSubview(self.underlayTextFieldView)
        self.underlayTextFieldView.addSubview(self.textField)
    }
    
    func configure(avatarUrl: URL?) {
        self.imageView.setImage(url: avatarUrl)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 36).isActive = true
        self.imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: 36).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        self.underlayTextFieldView.topAnchor.constraint(equalTo: self.topAnchor, constant: 36).isActive = true
        self.underlayTextFieldView.rightAnchor.constraint(equalTo: self.imageView.leftAnchor, constant: -12).isActive = true
        self.underlayTextFieldView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        self.underlayTextFieldView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        self.textField.topAnchor.constraint(equalTo: self.underlayTextFieldView.topAnchor).isActive = true
        self.textField.rightAnchor.constraint(equalTo: self.underlayTextFieldView.rightAnchor, constant: -14).isActive = true
        self.textField.leftAnchor.constraint(equalTo: self.underlayTextFieldView.leftAnchor, constant: 14).isActive = true
        self.textField.bottomAnchor.constraint(equalTo: self.underlayTextFieldView.bottomAnchor).isActive = true
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: SearchBarView.contentHeight)
    }
}

extension SearchBarView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.onReturn?()
        return true
    }
}
