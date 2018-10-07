//
//  CharactersFilterViewController.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import Eureka
import WallaMarvelAPI

public final class CharactersFilterViewController: FormViewController{

    public weak var delegate:CharactersFilterViewControllerDelegate?
	var mediator: CharactersFilterMediatorProtocol!
    
    var mainSection:Section        { return form.allSections.first! }
    var resetSection:Section       { return form.allSections.last! }
    var nameRow:TextRow            { return mainSection[0] as! TextRow }
    var nameStartsByRow:TextRow    { return mainSection[1] as! TextRow }
    var modifiedSinceRow:DateRow   { return mainSection[2] as! DateRow }
    var orderByRow:PickerInputRow<CharactersOrderByDisplayData>  { return mainSection[3] as! PickerInputRow<CharactersOrderByDisplayData> }

    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    public init(config:CharactersFilterControllerConfig){
        super.init(nibName: type(of: self).loadNibName, bundle: type(of: self).loadBundle)
        CharactersFilterWirer.wireUp(viewController: self, config: config)
    }
    
	public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "CHARACTER_FILTERS_TITLE".localized(onBundleFor: self)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        
        setupForm()
        mediator.reloadData()
    }
}

private extension CharactersFilterViewController{
    func setupForm(){
        let nameRow = TextRow(){ row in
            row.title = "CHARACTER_FILTERS_NAME_FIELD_TITLE".localized(onBundleFor: self)
            row.placeholder = "CHARACTER_FILTERS_NAME_FIELD_PLACEHOLDER".localized(onBundleFor: self)
        }
        
        let nameStartsByRow = TextRow(){ row in
            row.title = "CHARACTER_FILTERS_NAME_STARTS_BY_FIELD_TITLE".localized(onBundleFor: self)
            row.placeholder = "CHARACTER_FILTERS_NAME_STARTS_BY_FIELD_PLACEHOLDER".localized(onBundleFor: self)
        }
        
        let modifiedSinceRow = DateRow(){ row in
            row.title = "CHARACTER_FILTERS_MODIFIED_SINCE_FIELD_TITLE".localized(onBundleFor: self)
            row.maximumDate = Date()
            row.value = Date()
        }
        
        let orderByRow = PickerInputRow<CharactersOrderByDisplayData>(){ row in
            row.title = "CHARACTER_FILTERS_ORDER_BY_FIELD_TITLE".localized(onBundleFor: self)
            row.options = [.ascendingByName,.descendingByName,.ascendingByModified,.descendingByModified]
            row.value = row.options.first
            row.displayValueFor = { $0?.localizedString ?? "" }
        }

        let appearsInRow = LabelRow(){ row in
            row.title = "CHARACTER_FILTERS_APPEARS_IN_FIELD_TITLE".localized(onBundleFor: self)
            row.cell.accessoryType = .disclosureIndicator
        }.onCellSelection { cell, row in
            self.mediator.comicsFilterTapped()
        }
        
        form +++ Section() <<< nameRow <<< nameStartsByRow <<< modifiedSinceRow <<< orderByRow <<< appearsInRow
        
        let clearFiltersRow = LabelRow(){ row in
            row.title = "CHARACTER_FILTERS_CLEAR_ALL_BTN_TITLE".localized(onBundleFor: self)
            row.cellStyle = .default
        }.cellUpdate{ cell, row in
            cell.textLabel?.textColor = UIColor.WallaMarvel.destroyBehavior
            cell.textLabel?.textAlignment = .center
        }.onCellSelection { _, _ in
            self.clearFiltersTapped()
        }
        
        form +++ Section() <<< clearFiltersRow
    }
}

private extension CharactersFilterViewController{
    @objc func cancelTapped(){
        mediator.cancelTapped()
    }
    
    @objc func doneTapped(){
        mediator.doneTapped()
    }
    
    func clearFiltersTapped(){
        mediator.clearFiltersTapped()
    }
}

extension CharactersFilterViewController:  CharactersFilterViewProtocol{
    func display(_ data:CharactersFilterDisplayData){
        nameRow.value = data.name
        nameStartsByRow.value = data.nameStartsWith
        modifiedSinceRow.value = data.modifiedSince
        orderByRow.value = data.orderBy
        
        mainSection.reload(with: .none)
    }
    
    func displayComicsSelectorPreselectingComicsWithIDs(_ comicsIDs:[String]){
        let config = ComicsListControllerConfig(preSelectedComicsIDs: comicsIDs)
        let comicsController = ComicsListViewController(config: config)
        comicsController.delegate = self
        
        navigationController?.pushViewController(comicsController, animated: true)
    }
}

extension CharactersFilterViewController: ComicsListViewControllerDelegate{
    public func comicsListViewController(_ controller: ComicsListViewController, hasSelectedComicsWithIDs comicIDs: [String]) {
        mediator.comicsSelected(comicIDs)
    }
}
