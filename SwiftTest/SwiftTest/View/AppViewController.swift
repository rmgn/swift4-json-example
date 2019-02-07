//
//  ViewController.swift
//  SwiftTest
//
//  Created by Ranjith Karuvadiyil on 31/01/19.
//  Copyright © 2019 mistybits. All rights reserved.
//

import UIKit
import SystemConfiguration
import Alamofire

class AppViewController: UIViewController {
    private var model: ViewModel?
    let networkReachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")

    let imageCache = NSCache<AnyObject, AnyObject>()
    var refreshControl   = UIRefreshControl()
    var appCollectionview: UICollectionView!

    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 10)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // adding collection view to viewcontroller
        appCollectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        appCollectionview.dataSource = self
        appCollectionview.delegate = self
        appCollectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        appCollectionview.dataSource = self
        appCollectionview.delegate = self
        appCollectionview.register(CategoryCell.self, forCellWithReuseIdentifier: "cellId")
        appCollectionview.showsVerticalScrollIndicator = false
        appCollectionview.backgroundColor = UIColor.white
        appCollectionview.collectionViewLayout = layout
        self.view.addSubview(appCollectionview)
        // adding layout anchors
        appCollectionview.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        appCollectionview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        appCollectionview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        appCollectionview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        // adding pull to refresh control
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        appCollectionview.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: Any) {
        // check rechability here after reload tableview.
        if isNetworkReachable(){
            self.model = ViewModel(viewDelegate: self)
            self.model!.bootstrap()
            appCollectionview.reloadData()
        }
        else{
            let alert = UIAlertController(title: "No internet connection", message: ".", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        (sender as AnyObject).endRefreshing()
    }
}
   
extension AppViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numRows = 10
        if (self.model != nil) {
             numRows = self.model!.rowsItem.count
            if numRows > 0 {
                numRows = (self.model!.rowsItem.count)
            }else{
                numRows = 0
            }
        }
        return numRows
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CategoryCell
       if (model != nil) {
        let photos = self.model!.rowsItem
        let headline = photos[indexPath.row]
        // print(headline.title!)
        cell.rowTitleLabel.text = headline.title
        cell.rowDescLabel.text = headline.description
         let imageValue:String = headline.imageHref
      //  print(headline.title)
            if imageValue.isEmpty {
                cell.rowImageView.image = UIImage(named: "no-image-icon-23494")
            }else{
                Alamofire.request(headline.imageHref).responseData { (response) in
                    print(response.request?.url as Any)
                    let imageToCache = UIImage(data: response.data!)
                    if (imageToCache != nil){
                        self.imageCache.setObject(imageToCache!, forKey: headline.imageHref as AnyObject)
                        cell.rowImageView.image = imageToCache
                    }else{
                        cell.rowImageView.image = UIImage(named: "no-image-icon-23494")
                    }
                }
            }
        }
        return cell
}
  
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: 10)
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        layout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: 10)
        layout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
}

// extending viewcontroller to call API
extension AppViewController :someProtocol{
    func loadDatas() {
        appCollectionview.reloadData()
    }
    func isNetworkReachable() -> Bool {
        return networkReachabilityManager?.isReachable ?? false
    }
  
}
    

