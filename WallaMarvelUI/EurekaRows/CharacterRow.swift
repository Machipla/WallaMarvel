//
//  CharacterRow.swift
//  PetSpotCoreUI
//
//  Created by Mario Plaza on 4/10/18.
//

import Foundation
import Eureka

final class CharacterRow: Row<CharacterTableCell>, RowType{
    
    var imageURL:URL?{
        didSet{ cell.detailImageView.setImage(withURL: imageURL, imageTransition: .crossDissolve(0.4)) }
    }
    
    public required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<CharacterTableCell>(nibName: Cell.nibName, bundle: Bundle(for: Cell.self))
    }
}
