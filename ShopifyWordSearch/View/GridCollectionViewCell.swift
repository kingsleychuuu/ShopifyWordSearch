//
//  GridCollectionViewCell.swift
//  ShopifyWordSearch
//
//  Created by admin on 5/3/19.
//  Copyright © 2019 Kingsley. All rights reserved.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    let textLabelView: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = .white
        textLabel.text = "A"
        textLabel.font = textLabel.font.withSize(15)
        textLabel.textAlignment = .center
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    func setupCell () {
        backgroundColor = .black
        addSubview(textLabelView)
        textLabelView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textLabelView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
