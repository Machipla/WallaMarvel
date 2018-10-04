//
//  CharacterTableCell.swift
//  WallaMarvelUI
//
//  Created by Mario Plaza on 4/10/18.
//

import UIKit
import Eureka

final class CharacterTableCell: Cell<String>, CellType {
    @IBOutlet weak var detailImageView:UIImageView!
    @IBOutlet weak var titleLabel:UILabel!
    
    override func update() {
        super.update()
        titleLabel.text = row.title
        
        textLabel?.text = nil
        detailTextLabel?.text = nil
    }
}
