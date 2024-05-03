//
//  ItemCharacterViewCell.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 26/12/23.
//

import Foundation
import UIKit
final class ItemCharacterViewCell : UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemGroupedBackground
        view.setHeightConstraint(with: ViewValues.defaultHeightConstraintCell)
        view.layer.cornerRadius = ViewValues.defaultCornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    private let characterImageView : UIImageView = {
        let image = UIImageView()
        image.setWidthConstraint(with: ViewValues.defaultHeightConstraintCell)
        image.contentMode = .scaleAspectFill
        
        return image
        
    }()
    
    private let containerStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let nameLabel : UILabel = {
        let labelView = UILabel()
        labelView.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: UITraitCollection(legibilityWeight: .bold))
        labelView.textColor = .systemBlue
        return labelView
    }()
    
    
    private let specieLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        return label
    }()
    
    private let statusLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        return label
    }()
    
    private var task : Task<Void, Never>?
    
    
    private func configUI(){
        selectionStyle = .none
        addSubview(containerView)
        containerView.setConstraints(
            top: topAnchor,
            right: rightAnchor,
            bottom: bottomAnchor,
            left: leftAnchor,
            pRight: ViewValues.doublePadding,
            pBottom: ViewValues.doublePadding,
            pLeft: ViewValues.doublePadding)
        
        containerView.addSubview(characterImageView)
        characterImageView.setConstraints(
            top: containerView.topAnchor,
            bottom: containerView.bottomAnchor,
            left: containerView.leftAnchor)
        
        containerView.addSubview(containerStackView)
        containerStackView.setConstraints(
            top: containerView.topAnchor,
            right: containerView.rightAnchor,
            bottom: containerView.bottomAnchor,
            left: characterImageView.rightAnchor,
            pTop: ViewValues.normalPadding,
            pRight: ViewValues.doublePadding,
            pBottom: ViewValues.doublePadding,
            pLeft: ViewValues.doublePadding)
        
        [nameLabel, specieLabel, statusLabel].forEach{
            containerStackView.addArrangedSubview($0)
        }
    }
    
    func configData(viewModel : ItemCharacterViewModel){
        self.nameLabel.text = viewModel.name
        self.specieLabel.text = viewModel.specie
        self.statusLabel.text = viewModel.status
        setImage(viewModel: viewModel)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        
    }
    func setImage(viewModel : ItemCharacterViewModel){
        characterImageView.addImageDefault()
        if let data = viewModel.imageData {
            characterImageView.setUIImageFromData(data: data)
        }else{
           task = Task{
               if let data = await viewModel.getImageDataRemote(){
                   characterImageView.setUIImageFromData(data: data)
               }
            }
        }
    }
    
    
}

extension ItemCharacterViewCell : Reusable{
    
}
