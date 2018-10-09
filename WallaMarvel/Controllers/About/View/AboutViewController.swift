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
    internal private(set) weak var safariController:SFSafariViewController?
    internal private(set) var safariPresentation:(() -> Void)?
    
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

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if parent == nil{ mediator.dismissDone() }
    }
    
    public override var shouldAutorotate: Bool{
        guard isAllowedToRotate else { return false }
        return true
    }
    
    private var isAllowedToRotate:Bool{
        // XXX: SFSafariViewController doesnt seem to update his constraints on rotation if modalPresentationStyle is overCurrentContext so we disable it if it's the case
        // There seems to be no way to make SFSafariViewController to redraw neither
        guard !(safariController?.isModallyPresented ?? false) || safariController?.modalPresentationStyle != .overCurrentContext else { return false }
        return true
    }
}

// MARK: - Setup/Draw methods
private extension AboutViewController{
    func setupForm(){
        let linkedInRow = MenuLabelRow(){ row in
            row.menuTitle = "ABOUT_ME_LINKEDIN_TITLE".localized(onBundleFor: self)
            row.menuImage = UIImage(named: "ic_menu_linkedin")!
            row.menuColor = AboutViewController.MenuOptionsColors.linkedIn
            row.cell.selectionStyle = .none
        }.onCellSelection{ [weak self] _, _ in
            self?.mediator.myLinkedInTapped()
        }
        
        let githubRow = MenuLabelRow(){ [weak self] row in
            row.menuTitle = "ABOUT_ME_GITHUB_TITLE".localized(onBundleFor: self!)
            row.menuImage = UIImage(named: "ic_menu_github")!
            row.menuColor = AboutViewController.MenuOptionsColors.gitHubContrast
            row.cell.selectionStyle = .none
        }.onCellSelection{ [weak self] _, _ in
            self?.mediator.myGithubTapped()
        }
        
        let aboutMeTitleSection = "ABOUT_ME_SECTION_TITLE".localized(onBundleFor: self)
        form +++ Section(aboutMeTitleSection) <<< linkedInRow <<< githubRow
        
        let wallapopRow = MenuLabelRow(){ row in
            row.menuTitle = "ABOUT_CREDITS_WALLAPOP_TITLE".localized(onBundleFor: self)
            row.menuImage = UIImage(named: "ic_menu_wallapop")!
            row.menuColor = UIColor.WallaMarvel.wallapop
            row.cell.selectionStyle = .none
        }.onCellSelection{ [weak self] _, _ in
            self?.mediator.wallapopTapped()
        }

        let marvelRow = MenuLabelRow(){ row in
            row.menuTitle = "ABOUT_CREDITS_MARVEL_TITLE".localized(onBundleFor: self)
            row.menuImage = UIImage(named: "ic_menu_marvel")!
            row.menuColor = UIColor.WallaMarvel.marvel
            row.cell.selectionStyle = .none
        }.onCellSelection{ [weak self] _, _ in
            self?.mediator.marvelTapped()
        }

        let iconsRow = MenuLabelRow(){ row in
            row.menuTitle = "ABOUT_CREDITS_ICONS_TITLE".localized(onBundleFor: self)
            row.menuImage = UIImage(named: "ic_menu_icons8")!
            row.menuColor = AboutViewController.MenuOptionsColors.icons8
            row.cell.selectionStyle = .none
        }.onCellSelection{ [weak self] _, _ in
            self?.mediator.iconsTapped()
        }

        let creditsTitleSection = "ABOUT_CREDITS_SECTION_TITLE".localized(onBundleFor: self)
        form +++ Section(creditsTitleSection) <<< wallapopRow <<< marvelRow <<< iconsRow
    }
}

// MARK: - AboutViewProtocol
extension AboutViewController: AboutViewProtocol{
    func display(_ url:URL){
        let safariController = SFSafariViewController(url: url)
        safariController.delegate = self
        if #available(iOS 11.0, *){ safariController.dismissButtonStyle = .close }
        self.safariController = safariController
        
        if delegate != nil{
            safariPresentation = { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.present(strongSelf.safariController!, animated: true, completion: nil)
            }
            
            mediator.webWillBePresented()
        }else{
            mediator.webWillBePresented()
            present(safariController, animated: true, completion: nil)
        }
    }
}

// MARK: - Delegates
extension AboutViewController: SFSafariViewControllerDelegate{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        safariPresentation = nil
        mediator.webDismissed()
    }
}
