//
//  CategoryCell.swift
//  jhjjjjjhj
//
//  Created by Ranjith Karuvadiyil on 04/02/19.
//  Copyright © 2019 mistybits. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell{
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor.white
        let bcolor : UIColor = UIColor( red: 0.2, green: 0.2, blue:0.2, alpha: 0.3 )
        self.layer.borderColor = bcolor.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 3
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    fileprivate func setupViews() {
        contentView.addSubview(rowTitleLabel)
        rowTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        rowTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        rowTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true

        contentView.addSubview(rowDescLabel)
        rowDescLabel.topAnchor.constraint(equalTo: rowTitleLabel.bottomAnchor, constant: 10).isActive = true
        rowDescLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        rowDescLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true

        contentView.addSubview(rowImageView)
        rowImageView.topAnchor.constraint(equalTo: rowDescLabel.bottomAnchor, constant: 10).isActive = true
        rowImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        rowImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        rowImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        if let lastSubview = contentView.subviews.last {
            contentView.bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 10).isActive = true
        }
    }
    
    let rowTitleLabel: UILabel = {
        let rowTitleLabel = UILabel()
        rowTitleLabel.backgroundColor = .white
        rowTitleLabel.numberOfLines = 0
        rowTitleLabel.textAlignment = NSTextAlignment.center
        rowTitleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        rowTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return rowTitleLabel
    }()
    
    let rowDescLabel: UILabel = {
        let rowDescLabel = UILabel()
        rowDescLabel.backgroundColor = .white
        rowDescLabel.numberOfLines = 0
        rowDescLabel.translatesAutoresizingMaskIntoConstraints = false
        return rowDescLabel
    }()
    
    let rowImageView: UIImageView = {
        let rowImageView = UIImageView()
        rowImageView.translatesAutoresizingMaskIntoConstraints = false
        return rowImageView
    }()
    
}
