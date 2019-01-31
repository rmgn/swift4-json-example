//
//  ViewController.swift
//  SwiftTest
//
//  Created by Ranjith Karuvadiyil on 31/01/19.
//  Copyright © 2019 mistybits. All rights reserved.
//

import UIKit
import SystemConfiguration
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var urlTableview: UITableView!

    private let apiManager = APIManager()
    var swiftObj :Swifter? = nil
    // pull to refresh control
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl.isHidden = false

        self.urlTableview.addSubview(self.refreshControl)

    }
    

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        // checking reachablity
        let reachability = SCNetworkReachabilityCreateWithName(nil, "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)
        let isReachable: Bool = flags.contains(.reachable)
        if  (isReachable){
            getValues()
        }else{
            let alert = UIAlertController(title: "Alert", message: "Network is not reachable", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    refreshControl.endRefreshing()
                    self.refreshControl.isHidden = true


                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            self.present(alert, animated: true, completion: nil)
        }
        
        refreshControl.endRefreshing()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //        return (self.swiftObj?.rows.count)!
        
        var numRows:Int = 0
        if var _ :Int = self.swiftObj?.rows.count{
            numRows = (self.swiftObj?.rows.count)!
        }else{
            numRows = 0
        }
//        print("numRows \(numRows)")
        return numRows
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:TableViewCells = (tableView.dequeueReusableCell(withIdentifier: "TableViewCells", for: indexPath) as? TableViewCells)!
        
        //         Configure the cell...
        let photos = self.swiftObj?.rows
        
        let headline = photos![indexPath.row]
        // print(headline.title!)
        cell.titleLabel?.text = headline.title
        cell.descriptionLabel?.text = headline.description
        DispatchQueue.global(qos: .background).async {
            let imageValue:String = headline.imageHref
//            print("title \(headline.title)")
//            print("image count\(imageValue.count)")
            if imageValue.isEmpty {
//                print("empty")
            }else{
                let url = URL(string:(imageValue))
                var data: NSData? = nil
                data = try? Data(contentsOf: url!) as NSData
                if data != nil{
                    let image: UIImage = UIImage(data: data! as Data)!
                    DispatchQueue.main.async {
                        cell.titleImage!.image = image
                    }
                }
            }
        }
        return cell
    }
}
// extending viewcontroller to call API
extension ViewController {
    private func getValues() {
        apiManager.getDaraFromUrl() { (apidetails, error) in
            if error != nil {
                return
            }
            guard let apiValues = apidetails  else { return }
            self.swiftObj = apiValues
            DispatchQueue.main.async {
                self.urlTableview .reloadData()
            }
        }
    }
    
}
