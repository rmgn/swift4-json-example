//
//  UsersViewModel.swift
//  simple-mvvm-example
//
//  Created by Nishadh Shanker Shrestha on 15/04/18.
//  Copyright © 2018 Nishadh Shrestha. All rights reserved.
//

import Foundation

protocol someProtocol {
    func loadDatas()
}
class ViewModel {
    
    var rowsItem = [Rows]()
    var apiManagerObj = APIManager()
    var delegate: someProtocol
    init?() {
        self.rowsItem = [Rows]()
        return nil
    }
    init(viewDelegate:someProtocol) {
        delegate = viewDelegate
    }
    func bootstrap() {
        loadData()
    }
    private func loadData() {
        self.apiManagerObj.getDaraFromUrl() { (apidetails, error) in
            if error != nil {
                return
            }
            guard let apiValues = apidetails  else { return }
            self.rowsItem = apiValues.rows
            self.delegate.loadDatas()
        }
    }
}
