//
//  HomeMenuController.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 23/11/23.
//

import UIKit
import Combine
protocol HomeMenuControllerCoordinator{
    func didSelectMenuCell(model : MenuItem)
}

class HomeMenuController: UICollectionViewController  {
    
    private let viewModel : HomeMenuViewModel
    
    private var cancellable = Set<AnyCancellable>()
    
    private let homeCoordinator : HomeMenuControllerCoordinator
    
    init(viewModel: HomeMenuViewModel, layout : UICollectionViewFlowLayout, coordinator : HomeMenuControllerCoordinator) {
        self.viewModel = viewModel
        self.homeCoordinator = coordinator
        super.init(collectionViewLayout: layout)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configUI()
        configCollectionView()
        stateController()
        viewModel.viewDidLoad()
        
    }
    
    private func stateController(){
        viewModel.state.sink{ [weak self] state in
            self?.hideSpinner()
            switch state {
            case .success:
                self?.collectionView.reloadData()
            case .loading:
                self?.showSpinner()
                print("loading")
            case .fail(error: let error):
                self?.presentAlert(message: error, title: AppLocalized.error)
                print("error: \(error)")
            }
        }.store(in: &cancellable)
    }
    
    
    private func configUI(){
        view.backgroundColor = .systemBackground
    }
    
    private func configCollectionView(){
        collectionView.register(ItemHomeMenuCell.self, forCellWithReuseIdentifier: ItemHomeMenuCell.reuseIdentifier)
    }


}

extension HomeMenuController{
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemHomeMenuCell.reuseIdentifier, for: indexPath) as! ItemHomeMenuCell
        
        let viewModelCell = viewModel.getItemMenuViewModel(indexPath: indexPath)
        cell.configData(viewModel: viewModelCell)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.menuItemCount
    }
    
    
}

extension HomeMenuController{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.viewModel.getMenuItem(indexPath: indexPath)
        self.homeCoordinator.didSelectMenuCell(model: item)
    }
}

extension HomeMenuController : SpinnerDisplayable{}

extension HomeMenuController : MessageDisplayable{}

