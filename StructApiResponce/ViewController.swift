//
//  ViewController.swift
//  StructApiResponce
//
//  Created by Mac on 16/10/23.
//

import UIKit
import SDWebImage
import Kingfisher
import SwiftUI
class ViewController: UIViewController {
    var products : [Product] = []
    @IBOutlet weak var productTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        productTableView.delegate = self
        productTableView.dataSource = self
        Register()
        dataFetch()
    }
    func Register(){
        let nibName = UINib(nibName: "productTableViewCell", bundle: nil)
        self.productTableView.register(nibName, forCellReuseIdentifier: "productTableViewCell")
    }
    func dataFetch(){
        let url = URL(string: "https://dummyjson.com/products")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        let urlSession  = URLSession(configuration: .default)
        let dataTask = urlSession.dataTask(with: urlRequest){
            data,response,error in
            guard let extractedData = data else{ return}
            guard let extractResponse = response else
            {return}
            print(response)
            
        let jsonResponse = try!
            JSONSerialization.jsonObject(with: extractedData) as! [String:Any]
            let productResponce = jsonResponse["products"] as! [[String:Any]]
            
            let total = jsonResponse["total"] as! Int
            let skip = jsonResponse["skip"] as! Int
            let limit = jsonResponse["limit"] as! Int
            
            for eachProductFromResponce in productResponce{
                let eachProductId = eachProductFromResponce["id"] as! Int
                let eachProductTitle = eachProductFromResponce["title"] as! String
                let eachProductDiscription = eachProductFromResponce["description"] as! String
                let eachProductPrice = eachProductFromResponce["price"] as! Int
                let eachProductDiscount = eachProductFromResponce["discountPercentage"] as! Double
                let eachProductRating = eachProductFromResponce["rating"] as! Double
                let eachProductStock = eachProductFromResponce["stock"] as! Double
                let eachProductBrand = eachProductFromResponce["brand"] as! String
                let eachProductCategory = eachProductFromResponce["category"] as! String
                let eachProducThumbnail = eachProductFromResponce["thumbnail"] as! String
                let imageUrl = eachProductFromResponce["images"] as! [String]
                
                let newProductObject = Product(id: eachProductId, title: eachProductTitle, description: eachProductDiscription, price: eachProductPrice, discountPercentage: Float(eachProductDiscount), rating: eachProductRating, stock: eachProductStock, brand: eachProductBrand, category: eachProductCategory, thumbnail: eachProducThumbnail, images: imageUrl)
                
                self.products.append(newProductObject)
            }
            DispatchQueue.main.async {
                self.productTableView.reloadData()
            }
        }
        dataTask.resume()
    }
}
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.productTableView.dequeueReusableCell(withIdentifier: "productTableViewCell", for: indexPath) as? productTableViewCell
        cell?.productIdLabel.text = String(products[indexPath.row].id)
        cell?.productTitleLabel.text = products[indexPath.row].title
        cell?.productDescriptionLabel.text = products[indexPath.row].description
        cell?.productPriceLabel.text = String(products[indexPath.row].price)
        cell?.productRatingLabel.text = String(products[indexPath.row].rating)
        cell?.productStockLabel.text = String(products[indexPath.row].rating)
        cell?.productBrandLabel.text = products[indexPath.row].brand
        cell?.productCategoryLabel.text = products[indexPath.row].category
       // cell?.productThumbailImageView.sd_setImage(with:products[indexPath.row].thumbnail)
        for eachImageURLString  in products[indexPath.row].images {
                    let eachProductUrl = URL(string: eachImageURLString)
            cell?.productImageImagesView.kf.setImage(with: eachProductUrl)
            cell?.productThumbailImageView.kf.setImage(with: eachProductUrl)
                }

      return cell!
    }
}
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600.0
      }
}
