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

class ViewController: UICollectionViewController {
    private var model: ViewModel?

   
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 10)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.collectionViewLayout = layout
        self.model = ViewModel(viewDelegate: self)
        self.model!.bootstrap()
        self.collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numRows = self.model!.rowsItem.count
        if numRows > 0 {
            numRows = (self.model!.rowsItem.count)
        }else{
            numRows = 0
        }
        return numRows
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CategoryCell
        let photos = self.model!.rowsItem
        
        let headline = photos[indexPath.row]
        // print(headline.title!)
        cell.rowTitleLabel.text = headline.title
        cell.rowDescLabel.text = headline.description
         let imageValue:String = headline.imageHref
        print(headline.title)
     
            if imageValue.isEmpty {
                //                print("empty")
                cell.rowImageView.image = UIImage(named: "no-image-icon-23494")


            }else{
                Alamofire.request(headline.imageHref).responseData { (response) in
                    print(response.request?.url as Any)

                                if response.error == nil {
                        
                                        // Show the downloaded image:
                                        if let data = response.data {
                                            let imageValue :UIImage? = UIImage(data: data)
                                            if  imageValue != nil {
                                              cell.rowImageView.image = UIImage(data: data)
                                            }else{
                                                cell.rowImageView.image = UIImage(named: "no-image-icon-23494")
                                            }
                                        }else{
                                            cell.rowImageView.image = UIImage(named: "no-image-icon-23494")
                                    }
                                }else{
                                    cell.rowImageView.image = UIImage(named: "no-image-icon-23494")
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
extension ViewController :someProtocol{
    func loadDatas() {
        self.collectionView.reloadData()

    }
    
  
}
    
    
//    private func getValues() {
//        apiManager.getDaraFromUrl() { (apidetails, error) in
//            if error != nil {
//                return
//            }
//            guard let apiValues = apidetails  else { return }
//            self.swiftObj = apiValues
//            DispatchQueue.main.async {
//                self.collectionView .reloadData()
//            }
//        }
//    }
//
