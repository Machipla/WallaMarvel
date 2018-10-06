//
//  CharacterFiltersViewController.swift
//  WallaMarvel
//
//  Created Mario Plaza on 6/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import Eureka

public final class CharacterFiltersViewController: FormViewController{

    public weak var delegate:CharacterFiltersViewControllerDelegate?
	var mediator: CharacterFiltersMediatorProtocol!
    
    var mainSection:Section        { return form.allSections.first! }
    var nameRow:TextRow            { return mainSection[0] as! TextRow }
    var nameStartsByRow:TextRow    { return mainSection[1] as! TextRow }
    var modifiedSinceRow:DateRow   { return mainSection[2] as! DateRow }
    var orderByRow:PickerInputRow<CharacterOrderByDisplayData>  { return mainSection[3] as! PickerInputRow<CharacterOrderByDisplayData> }

    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    public init(config:CharacterFiltersControllerConfig){
        super.init(nibName: type(of: self).loadNibName, bundle: type(of: self).loadBundle)
        CharacterFiltersWirer.wireUp(viewController: self, config: config)
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

private extension CharacterFiltersViewController{
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
            row.value = Date()
            row.maximumDate = Date()
        }
        
        let orderByRow = PickerInputRow<CharacterOrderByDisplayData>(){ row in
            row.title = "CHARACTER_FILTERS_ORDER_BY_FIELD_TITLE".localized(onBundleFor: self)
            row.options = [.ascendingByName,.descendingByName,.ascendingByModified,.descendingByModified]
            row.value = row.options.first
            row.displayValueFor = { $0?.localizedString ?? "" }
        }
        
        form +++ Section() <<< nameRow <<< nameStartsByRow <<< modifiedSinceRow <<< orderByRow
    }
}

private extension CharacterFiltersViewController{
    @objc func cancelTapped(){
        mediator.cancelTapped()
    }
    
    @objc func doneTapped(){
        mediator.doneTapped()
    }
}

extension CharacterFiltersViewController:  CharacterFiltersViewProtocol{
    func display(_ data:CharacterFiltersDisplayData){
        nameRow.value = data.name
        nameStartsByRow.value = data.nameStartsWith
        modifiedSinceRow.value = data.modifiedSince
        orderByRow.value = data.orderBy
    }
}
