//
//  GridCollectionViewFooter.swift
//  ShopifyWordSearch
//
//  Created by admin on 5/3/19.
//  Copyright © 2019 Kingsley. All rights reserved.
//

import UIKit

class GridCollectionViewFooter: UICollectionViewCell {
    let scoreLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = .white
        textLabel.text = "Score: 0"
        textLabel.font = textLabel.font.withSize(15)
        textLabel.textAlignment = .left
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    let remainingWordsCountLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = .white
        textLabel.text = "Remaining: 0"
        textLabel.font = textLabel.font.withSize(15)
        textLabel.textAlignment = .right
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    let remainingWordsLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = .white
        textLabel.text = ""
        textLabel.font = textLabel.font.withSize(20)
        textLabel.textAlignment = .center
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.numberOfLines = 0
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    func setupCell () {
        backgroundColor = .black
        addSubview(scoreLabel)
        scoreLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        scoreLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        
        addSubview(remainingWordsCountLabel)
        remainingWordsCountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        remainingWordsCountLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        
        addSubview(remainingWordsLabel)
        remainingWordsLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 10).isActive = true
        remainingWordsLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
