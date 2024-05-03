//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 9/03/24.
//

import Foundation
import UIKit
import Combine

protocol CharacterDetailViewControllerCoordinator {
    func didTapOriginButton()
    func didTapLocationButton()
}
final class CharacterDetailViewController : UIViewController{
    
    private let viewModel : CharacterDetailViewModel
    private var cancellable = Set<AnyCancellable>()
    private let coordinator : CharacterDetailViewControllerCoordinator
    
    
    private let imageCharacter : UIImageView = {
        let imageView = UIImageView()
        imageView.addImageDefault()
        imageView.contentMode = .scaleAspectFit
        imageView.setHeightConstraint(with: UIScreen.main.bounds.width)
        return imageView
    }()
    
    private let containerView : UIView = {
       let containerView = UIView()
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = ViewValues.defaultCornerRadius * 2
        return containerView
    }()
    
    private let nameLabel : UILabel = {
       let labelView = UILabel()
        labelView.text = "Name Here"
        labelView.font = UIFont.preferredFont(forTextStyle: .title2)
        labelView.textAlignment = .center
        return labelView
    }()
    
    private lazy var statusLabel : UILabel = makeGrayLabel(text : "Status : Alive")
    
    private lazy var specieLabel : UILabel = makeGrayLabel(text : "Specie : Alien")
    
    private lazy var genderLabel : UILabel = makeGrayLabel(text : "Gender : Male")
    
    private lazy var originButton : UIButton = makeTitleSubtitleBlueButton(title: "Origin", subtitle: "Unknowm")
    
    private lazy var locationButton : UIButton = makeTitleSubtitleBlueButton(title: "Location", subtitle: "Citadel of Ricks")
    
    private func makeGrayLabel(text : String) -> UILabel {
       let statusLabel = UILabel()
        statusLabel.text = text
        statusLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        statusLabel.textColor = .systemGray
        statusLabel.textAlignment = .center
        return statusLabel
    }
    
    private func makeTitleSubtitleBlueButton(title : String, subtitle : String) -> UIButton{
        let button = UIButton(type: .system)
        var configuracion = UIButton.Configuration.filled()
        configuracion.title = title
        configuracion.subtitle = subtitle
        configuracion.cornerStyle = .large
        configuracion.buttonSize = .small
        configuracion.titleAlignment = .center
        configuracion.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .headline)
            return outgoing
        }
        
        configuracion.subtitleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .subheadline)
            return outgoing
        }
        
        button.configuration = configuracion
        return button
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stateController()
        configurationInterface()
        addTargets()
        viewModel.viewDidLoad()
    }
    
    private func stateController(){
        viewModel.state.receive(on: RunLoop.main).sink{ [weak self] state in
            self?.hideSpinner()
            switch state {
                
            case .success:
                self?.configData()
            case .loading:
                self?.showSpinner()
            case .fail(error: let error):
                self?.presentAlert(message: error, title: "Error")
                print("Error here: ", error)
            }
        }.store(in: &cancellable)
    }
    
    private func configData(){
        nameLabel.text = self.viewModel.nameCharacter
        statusLabel.text = self.viewModel.status
        specieLabel.text = self.viewModel.specie
        imageCharacter.setUIImageFromData(data: self.viewModel.imageData!)
        originButton.configuration?.subtitle = viewModel.origin
        locationButton.configuration?.subtitle = viewModel.location
    }
    
    private func addTargets(){
        originButton.addTarget(
            self,
            action: #selector(didTapOriginButton),
            for: .touchUpInside)
        locationButton.addTarget(
            self,
            action: #selector(didTapLocationButton), 
            for: .touchUpInside)
    }
    
    @objc func didTapOriginButton(){
        coordinator.didTapOriginButton()
    }
    
    @objc func didTapLocationButton(){
        coordinator.didTapLocationButton()
    }
    
    private func configurationInterface(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(imageCharacter)
        imageCharacter.setConstraints(
            top: view.topAnchor,
            right: view.rightAnchor,
            left: view.leftAnchor
        )
        view.addSubview(containerView)
        containerView.setConstraints(
            top: imageCharacter.bottomAnchor,
            right: view.rightAnchor,
            bottom: view.bottomAnchor,
            left: view.leftAnchor,
            pTop: ViewValues.containerDetailPadding
        )
        
        containerView.addSubview(nameLabel)
        nameLabel.setConstraints(
            top: containerView.topAnchor,
            right: containerView.rightAnchor,
            left: containerView.leftAnchor,
            pTop: ViewValues.normalPadding
        )
        
        containerView.addSubview(statusLabel)
        statusLabel.setConstraints(
            top: nameLabel.bottomAnchor,
            right: containerView.rightAnchor,
            left: containerView.leftAnchor,
            pTop: ViewValues.smallPadding
        )
        
        containerView.addSubview(specieLabel)
        specieLabel.setConstraints(
            top: statusLabel.bottomAnchor,
            right: containerView.rightAnchor,
            left: containerView.leftAnchor,
            pTop: ViewValues.smallPadding
        )
        
        containerView.addSubview(genderLabel)
        genderLabel.setConstraints(
            top: specieLabel.bottomAnchor,
            right: containerView.rightAnchor,
            left: containerView.leftAnchor,
            pTop: ViewValues.smallPadding
        )
        
        let containerStack = UIStackView(arrangedSubviews: [originButton, locationButton])
        containerStack.axis = .vertical
        containerStack.spacing = ViewValues.normalPadding
        containerView.addSubview(containerStack)
        containerStack.setConstraints(
            top: genderLabel.bottomAnchor,
            right: containerView.rightAnchor,
            left: containerView.leftAnchor,
            pTop: ViewValues.normalPadding,
            pRight: ViewValues.largePadding,
            pLeft: ViewValues.largePadding
        )
        
    }
    
    init(viewModel: CharacterDetailViewModel, coordinator : CharacterDetailViewControllerCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacterDetailViewController : SpinnerDisplayable{}
extension CharacterDetailViewController : MessageDisplayable{}
