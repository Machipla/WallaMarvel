//
//  CharacterDetailViewController.swift
//  WallaMarvel
//
//  Created Mario Plaza on 4/10/18.
//  Copyright © 2018 Mario Plaza. All rights reserved.
//

import UIKit
import Eureka
import AXPhotoViewer

public final class CharacterDetailViewController: FormViewController{

    @IBOutlet private weak var imageView:UIImageView!
    private var headerView:ParallaxTableHeader{ return tableView.tableHeaderView as! ParallaxTableHeader }
    
    public weak var delegate:CharacterDetailViewControllerDelegate?
	var mediator: CharacterDetailMediatorProtocol!

    private var characterSection:Section{ return form.allSections[0] }
    private var dataSection:Section{ return form.allSections[1] }
    
    
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    public init(config:CharacterDetailControllerConfig){
        super.init(nibName: type(of: self).loadNibName, bundle: type(of: self).loadBundle)
        CharacterDetailWirer.wireUp(viewController: self, config: config)
    }
    
	public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "HERO_DETAIL_TITLE".localized(onBundleFor: self)
        
        let headerView = ParallaxTableHeader.fromNib()
        headerView?.delegate = self
        tableView.tableHeaderView = headerView
        
        form +++ Section()
        form +++ Section("HERO_DETAIL_INFO_SECTION_TITLE".localized(onBundleFor: self))
        
        if #available(iOS 10.0, *){
            tableView.refreshControl = UIRefreshControl()
            tableView.refreshControl?.addTarget(self, action: #selector(refreshTriggered), for: .valueChanged)
        }
        
        mediator.reloadData()
    }

}

private extension CharacterDetailViewController{
    @objc func refreshTriggered(){
        mediator.refreshTriggered()
    }
    
    @IBAction func imageTapped(){
        mediator.imageTapped()
    }
}

extension CharacterDetailViewController{
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView.updateParallaxOnScroll(of: tableView)
    }
}

extension CharacterDetailViewController:  CharacterDetailViewProtocol{
    func display(_ data:CharacterDetailDisplayData){
        characterSection.removeAll()
        characterSection <<< LabelRow(){ row in
            row.title = data.name
            row.cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        }
        
        characterSection <<< TextAreaRow(){ row in
            row.value = data.description
            row.textAreaMode = .readOnly
            row.textAreaHeight = .dynamic(initialTextViewHeight: 0)
            row.cell.textView.font = UIFont.preferredFont(forTextStyle: .body)
        }
        
        if data.mustShowComicsField{
            dataSection <<< LabelRow(){ row in
                row.title = "HERO_DETAIL_COMICS_FIELD".localized(onBundleFor: self)
                row.value = String(data.comicsCount)
            }
        }
        
        headerView.imageView.setImage(withURL: data.imageURL, placeholderImage: UIImage(named: "im_placeholder", in: Bundle(forClassOfInstance: self)), imageTransition: .crossDissolve(0.4))
        imageView.setImage(withURL: data.imageURL, placeholderImage: UIImage(named: "im_placeholder", in: Bundle(forClassOfInstance: self)), imageTransition: .crossDissolve(0.4))
        tableView.layoutTableHeaderView()
        
        drawCut(height: 60, on: headerView)
    }
    
    func displayImage(with data:CharacterImageDetailDisplayData){
        var attributedTitle:NSAttributedString? = nil
        var attributedDescription:NSAttributedString? = nil
        if let title = data.title{ attributedTitle = NSAttributedString(string: title) }
        if let description = data.description{ attributedDescription = NSAttributedString(string: description) }
        
        let originView = imageView.isInstalled ? imageView : headerView.imageView
        
        let photo = AXPhoto(attributedTitle: attributedTitle, attributedDescription: attributedDescription, url: data.imageURL)
        let transitionInfo = AXTransitionInfo(interactiveDismissalEnabled: true, startingView: originView, endingView: { _, _ in originView })
        let photosDataSource = AXPhotosDataSource(photos: [photo])
        let photosController = AXPhotosViewController(dataSource: photosDataSource, pagingConfig: nil, transitionInfo: transitionInfo)
        self.present(photosController, animated: true, completion: nil)
    }
    
    func drawRefreshProgressView() {
        guard #available(iOS 10.0, *) else { return }
        tableView.refreshControl?.beginRefreshing()
    }
    
    func hideRefreshProgressView() {
        guard #available(iOS 10.0, *) else { return }
        tableView.refreshControl?.endRefreshing()
    }
}

extension CharacterDetailViewController: ParallaxTableHeaderDelegate{
    public func parallaxTableHeaderHasBeenTapped(_ header: ParallaxTableHeader) {
        mediator.imageTapped()
    }
}

extension CharacterDetailViewController: ViewCutDrawer{}
