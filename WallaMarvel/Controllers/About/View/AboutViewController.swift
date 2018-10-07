//
//  AboutViewController.swift
//  WallaMarvel
//
//  Created Mario Plaza on 7/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import Eureka
import WallaMarvelKit
import WallaMarvelUI

final class AboutViewController: FormViewController{

    public weak var delegate:AboutViewControllerDelegate?
	var mediator: AboutMediatorProtocol!

    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    init(){ super.init(nibName: type(of: self).loadNibName, bundle: type(of: self).loadBundle) }
    
	public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ABOUT_TITLE".localized(onBundleFor: self)
        
        setupForm()
    }
}

// MARK: - Setup/Draw methods
private extension AboutViewController{
    func setupForm(){
        let linkedInRow = MenuLabelRow(){ row in
            row.menuTitle = "ABOUT_ME_LINKEDIN_TITLE".localized(onBundleFor: self)
            row.menuImage = UIImage(named: "ic_menu_linkedin")!
            row.menuColor = AboutViewController.MenuOptionsColors.linkedIn
        }
        
        let githubRow = MenuLabelRow(){ row in
            row.menuTitle = "ABOUT_ME_GITHUB_TITLE".localized(onBundleFor: self)
            row.menuImage = UIImage(named: "ic_menu_github")!
            row.menuColor = AboutViewController.MenuOptionsColors.gitHubContrast
        }
        
        let aboutMeTitleSection = "ABOUT_ME_SECTION_TITLE".localized(onBundleFor: self)
        form +++ Section(aboutMeTitleSection) <<< linkedInRow <<< githubRow
    }
}

// MARK: - AboutViewProtocol
extension AboutViewController: AboutViewProtocol{
    
}
