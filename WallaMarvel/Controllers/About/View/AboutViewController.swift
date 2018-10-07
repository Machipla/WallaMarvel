//
//  AboutViewController.swift
//  WallaMarvel
//
//  Created Mario Plaza on 7/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import SafariServices
import Eureka
import WallaMarvelKit
import WallaMarvelUI

final class AboutViewController: FormViewController{

    public weak var delegate:AboutViewControllerDelegate?
	var mediator: AboutMediatorProtocol!

    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    init(){
        super.init(nibName: type(of: self).loadNibName, bundle: type(of: self).loadBundle)
        AboutWirer.wireUp(viewController: self)
    }
    
	public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ABOUT_TITLE".localized(onBundleFor: self)
        
        setupForm()
    }
    
    public override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        if parent == nil{ mediator.dismissDone() }
    }
}

// MARK: - Setup/Draw methods
private extension AboutViewController{
    func setupForm(){
        let linkedInRow = MenuLabelRow(){ row in
            row.menuTitle = "ABOUT_ME_LINKEDIN_TITLE".localized(onBundleFor: self)
            row.menuImage = UIImage(named: "ic_menu_linkedin")!
            row.menuColor = AboutViewController.MenuOptionsColors.linkedIn
        }.onCellSelection{ _, _ in
            self.mediator.myLinkedInTapped()
        }
        
        let githubRow = MenuLabelRow(){ row in
            row.menuTitle = "ABOUT_ME_GITHUB_TITLE".localized(onBundleFor: self)
            row.menuImage = UIImage(named: "ic_menu_github")!
            row.menuColor = AboutViewController.MenuOptionsColors.gitHubContrast
        }.onCellSelection{ _, _ in
            self.mediator.myGithubTapped()
        }
        
        let aboutMeTitleSection = "ABOUT_ME_SECTION_TITLE".localized(onBundleFor: self)
        form +++ Section(aboutMeTitleSection) <<< linkedInRow <<< githubRow
        
        let wallapopRow = MenuLabelRow(){ row in
            row.menuTitle = "ABOUT_CREDITS_WALLAPOP_TITLE".localized(onBundleFor: self)
            row.menuImage = UIImage(named: "ic_menu_wallapop")!
            row.menuColor = UIColor.WallaMarvel.wallapop
        }.onCellSelection{ _, _ in
            self.mediator.wallapopTapped()
        }
        
        let marvelRow = MenuLabelRow(){ row in
            row.menuTitle = "ABOUT_CREDITS_MARVEL_TITLE".localized(onBundleFor: self)
            row.menuImage = UIImage(named: "ic_menu_marvel")!
            row.menuColor = UIColor.WallaMarvel.marvel
        }.onCellSelection{ _, _ in
            self.mediator.marvelTapped()
        }
        
        let iconsRow = MenuLabelRow(){ row in
            row.menuTitle = "ABOUT_CREDITS_ICONS_TITLE".localized(onBundleFor: self)
            row.menuImage = UIImage(named: "ic_menu_icons8")!
            row.menuColor = AboutViewController.MenuOptionsColors.icons8
        }.onCellSelection{ _, _ in
            self.mediator.iconsTapped()
        }
        
        let creditsTitleSection = "ABOUT_CREDITS_SECTION_TITLE".localized(onBundleFor: self)
        form +++ Section(creditsTitleSection) <<< wallapopRow <<< marvelRow <<< iconsRow
    }
}

// MARK: - AboutViewProtocol
extension AboutViewController: AboutViewProtocol{
    func display(_ url:URL){
        let safariController = SFSafariViewController(url: url)
        present(safariController, animated: true, completion: nil)
    }
}
