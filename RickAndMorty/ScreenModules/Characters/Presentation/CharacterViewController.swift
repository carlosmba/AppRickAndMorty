//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 20/12/23.
//

import Foundation
import UIKit
import Combine

protocol CharacterViewControllerCoordinator {
    func didSelectMenuCell(urlDetail : String)
}
final class CharacterViewController: UITableViewController {
    
    private let viewModel : CharactersViewModel
    private var cancellable = Set<AnyCancellable>()
    private let coordinator : CharacterViewControllerCoordinator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        configTableView()
        stateController()
        
    }
    
    init(viewModel : CharactersViewModel, coordinator : CharacterViewControllerCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configTableView (){
        tableView.separatorStyle = .none
        
        tableView.register(ItemCharacterViewCell.self, forCellReuseIdentifier: ItemCharacterViewCell.reuseIdentifier)
        addSpinnerLastCell()
    }
    
    private func stateController(){
        viewModel.state.receive(on: RunLoop.main).sink{ [weak self] state in
            switch state {
                
            case .success:
                self?.tableView.reloadData()
            case .loading:
                break
            case .fail(error: let error):
                self?.presentAlert(message: error, title: AppLocalized.error)
                print("Error here: ", error)
            }
        }.store(in: &cancellable)
    }
}

extension CharacterViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCharacterViewCell.reuseIdentifier, for: indexPath) as! ItemCharacterViewCell
        let itemViewModel = viewModel.getItemMenuViewModel(row: indexPath.row)
        cell.configData(viewModel: itemViewModel)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.tableFooterView?.isHidden = viewModel.lastPage
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemCharactersCount
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = viewModel.getUrlDetail(row: indexPath.row)
        self.coordinator.didSelectMenuCell(urlDetail: url)
    }
}
extension CharacterViewController : MessageDisplayable{}
