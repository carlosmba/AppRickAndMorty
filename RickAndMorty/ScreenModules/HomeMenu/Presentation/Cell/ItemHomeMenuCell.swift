//
//  ItemHomeMenuCell.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 27/11/23.
//

import Foundation
import UIKit
class ItemHomeMenuCell: UICollectionViewCell {
    private let mainContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        view.layer.cornerRadius = ViewValues.defaultCornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    private let characterImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Images.defaultImage)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleCategoryLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Has Not been Implemented")
    }
    
    private func configUI(){
        addSubview(mainContainer)
        mainContainer.fillSuperView(widthPadding: ViewValues.normalPadding)
        mainContainer.addSubview(characterImage)
        characterImage.fillSuperView()
        configGradientForTitle()
        mainContainer.addSubview(titleCategoryLabel)
        titleCategoryLabel.setConstraints(
            right: mainContainer.rightAnchor,
            bottom: mainContainer.bottomAnchor,
            left: mainContainer.leftAnchor,
            pRight: ViewValues.normalPadding,
            pBottom: ViewValues.normalPadding,
            pLeft: ViewValues.normalPadding)
        
        
    }
    
    private func configGradientForTitle(){
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = self.bounds
        gradientMaskLayer.colors = [UIColor.clear.cgColor, UIColor.darkGray.cgColor]
        gradientMaskLayer.locations = [ViewValues.gradientTitleInit, ViewValues.gradientTitleEnd]
        mainContainer.layer.addSublayer(gradientMaskLayer)
    }
    
    func configData(viewModel : ItemHomeMenuViewModel){
        titleCategoryLabel.text = viewModel.title
        characterImage.image = UIImage(named: viewModel.imageName)
    }
}


extension ItemHomeMenuCell : Reusable{}
