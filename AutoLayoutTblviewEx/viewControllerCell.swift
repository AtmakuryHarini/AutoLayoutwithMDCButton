//
//  viewControllerCell.swift
//  AutoLayoutTblviewEx
//
//  Created by Atmakury Harish on 5/7/18.
//  Copyright © 2018 Atmakury Harini. All rights reserved.
//
import UIKit

class tableCell: UITableViewCell {
    
    
    lazy var cellLabel1:UILabel = {
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: label.font.fontName, size: 14)
        return label
    }()
    
    lazy var cellLabel2:UILabel = {
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: label.font.fontName, size: 14)
        return label
    }()

    lazy var cellLabel3:UILabel = {
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont(name: label.font.fontName, size: 14)
        return label
    }()
    
    lazy var stack:UIStackView = {
        let stack:UIStackView = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("test")
        setupViews()
        setupConstraints()
    }
    
    func setupViews(){
        
        contentView.addSubview(stack)
        stack.addArrangedSubview(cellLabel1)
        let spacer1:UIView = UIView()
        spacer1.translatesAutoresizingMaskIntoConstraints = true
        spacer1.heightAnchor.constraint(equalToConstant: 20)
        //stack.addArrangedSubview(spacer1)
        stack.addArrangedSubview(cellLabel2)
        let spacer2:UIView = UIView()
        spacer2.translatesAutoresizingMaskIntoConstraints = true
        spacer2.heightAnchor.constraint(equalToConstant: 20)
        //stack.addArrangedSubview(spacer2)
        stack.addArrangedSubview(cellLabel3)
        
    }
    
    func setupConstraints(){
        stack.topAnchor.constraint(equalTo: contentView.topAnchor,constant:15).isActive = true
        stack.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 5).isActive = true
        stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5).isActive = true
        stack.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant:-10).isActive = true
        stack.alignment = UIStackViewAlignment.fill
        stack.distribution = UIStackViewDistribution.fillEqually
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
