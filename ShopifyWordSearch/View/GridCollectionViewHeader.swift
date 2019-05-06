//
//  GridCollectionViewHeader.swift
//  ShopifyWordSearch
//
//  Created by admin on 5/3/19.
//  Copyright © 2019 Kingsley. All rights reserved.
//

import UIKit

class GridCollectionViewHeader: UICollectionViewCell {
    let scoreLabelView: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = .white
        textLabel.text = "Score: 0"
        textLabel.font = textLabel.font.withSize(14)
        textLabel.textAlignment = .left
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    let RemainingWordsLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = .white
        textLabel.text = "Remaining: 0"
        textLabel.font = textLabel.font.withSize(14)
        textLabel.textAlignment = .right
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    func setupCell () {
        addSubview(scoreLabelView)
        scoreLabelView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        scoreLabelView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addSubview(RemainingWordsLabel)
        RemainingWordsLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        RemainingWordsLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
