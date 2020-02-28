//
//  ViewController.swift
//  SearchAPI
//
//  Created by Ashish Singh Chauhan on 27/02/20.
//  Copyright © 2020 Ashish Singh Chauhan. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var productsTable: UITableView!
    
    let API_URL = "https://www.blibli.com/backend/search/products?searchTerm=sansui&start=0&itemPerPage=26"
    var productDataModel = ProductDataModel()
    var count: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.productsTable.delegate = self
        self.productsTable.dataSource = self
        let firstNib = UINib(nibName: "FirstProductView", bundle: nil)
        let secondNib = UINib(nibName: "SecondProductView", bundle: nil)
        self.productsTable.register(firstNib, forCellReuseIdentifier: "FirstProductView")
        self.productsTable.register(secondNib, forCellReuseIdentifier: "SecondProductView")
        
        getProductData(url: API_URL)
        productsTable.tableFooterView = UIView(frame: .zero)
    }
    
    //MARK: API Calling
    func getProductData(url: String) {
        Alamofire.request(url, method: .get).responseString { response in
            if response.result.isSuccess, let responseJSON = response.result.value {
                self.updateProductData(jsonString: responseJSON)
                self.productsTable.reloadData()
            } else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    //MARK: JSON Parsing
    func updateProductData(jsonString: String) {
        if let jsonData = jsonString.data(using: .utf8) {
            let decoder = JSONDecoder()
            do {
                productDataModel = try decoder.decode(ProductDataModel.self, from: jsonData)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: Delegate and DataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        var count = 0
        if let numberOfProducts = productDataModel.data?.products?.count {
            for index in 1...numberOfProducts {
                if index*(index+1) > numberOfProducts*2 {
                    count = index
                    break
                }
            }
        }
        self.count = count
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnedCell: UITableViewCell = UITableViewCell()
        
        let currentSection = indexPath.section
        let currentRow = indexPath.row
        let indexOfRow = (currentSection * (currentSection + 1))/2 + currentRow
        
        if let numberOfProducts = productDataModel.data?.products?.count {
            if indexOfRow < numberOfProducts {
                if indexOfRow % 2 == 0 {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "FirstProductView", for: indexPath) as? FirstProductView, let item = productDataModel.data?.products?[indexOfRow] {
                        cell.productTitle.text = item.name
                        let imageURL = URL(string: (item.images?[0])!)
                        cell.productImage.kf.setImage(with: imageURL)
                        returnedCell = cell
                    }
                } else {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "SecondProductView", for: indexPath) as? SecondProductView, let item = productDataModel.data?.products?[indexOfRow] {
                        cell.productTitle.text = item.name
                        let imageURL = URL(string: (item.images?[0])!)
                        cell.productImage.kf.setImage(with: imageURL)
                        returnedCell = cell
                    }
                }
            }
        }
        return returnedCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section + 1)"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCollectionView" {
            if let destinationVC = segue.destination as? CollectionViewController {
                destinationVC.productDataModel = self.productDataModel
            }
        }
    }
    
}
