//
//  ResultsViewController.swift
//  
//
//  Created by Li Yu on 9/22/14.
//
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var filterButton: UIButton!

    @IBOutlet weak var bizTable: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    
    var client = YelpClient.sharedInstance
    var businesses: [NSDictionary] = []
//    var prototypeCell : BusinessCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bizTable.dataSource = self
        bizTable.delegate = self
        bizTable.rowHeight =  UITableViewAutomaticDimension
        //Put the search bar ontn the navbar
        navigationItem.titleView = searchBar

        searchBar.text = "food"
        businesses = []
        searchForQuery(searchBar.text)

        bizTable.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.businesses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell") as BusinessCell
        configureCell(cell, forRowAtIndexPath: indexPath)
        return cell
        // Additional data used for segue...
//        cell.businessId = business["id"] as String

    }
    func configureCell (cell: BusinessCell, forRowAtIndexPath indexPath: NSIndexPath) -> Void{
        if cell.isKindOfClass(BusinessCell) {
            var business = businesses[indexPath.row]
            cell.bizNameLabel.text = business["name"] as? String
            
            var thumbnailImageUrl = business["image_url"] as String
            cell.bizImage.setImageWithURL(NSURL(string: thumbnailImageUrl))
            
            var ratingImageUrl = business["rating_img_url_large"] as String
            cell.ratingImage.setImageWithURL(NSURL(string: ratingImageUrl))
            
            var location = business["location"] as NSDictionary
            var addressParts = location["address"] as [String]
            var address = " ".join(addressParts)
            var city = location["city"] as String
            if address != ""{
                cell.bizAddressLabel.text = "\(address), \(city)"
            }else{
                cell.bizAddressLabel.text = "\(city)"
            }
            
            var categories = business["categories"] as [NSArray]

            var categoriesLabels: [String] = categories.reduce([]) {
                var currentValue = $0 as [String]
                var category = $1 as [String]
                var label = category[0]
                currentValue.append(label)
                return currentValue
            }

            cell.categoryLabel.text = ", ".join(categoriesLabels)
            
            var reviewCount = business["review_count"] as Int
            cell.reviewLabel.text = "\(reviewCount) reviews"
        }
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        bizTable.reloadData()
        searchForQuery(searchBar.text)
    }

    func searchForQuery(query: String) {
        client.search(query, category: "", sort: 0, radius: 3, deal: true) {
            (response, error) -> Void in
            
            if error == nil {
                var object = response as NSDictionary
                self.businesses = object["businesses"] as [NSDictionary]
                self.bizTable.reloadData()
            } else {
                var alert = UIAlertController(title: "Error", message: "Error", preferredStyle: UIAlertControllerStyle.Alert)
                self.presentViewController(alert, animated: false, completion: nil)
            }
        }
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        self.configureCell(self.getPrototypeCell(), forRowAtIndexPath: indexPath)
//        
//        
//        // Need to set the width of the prototype cell to the width of the table view
//        // as this will change when the device is rotated.
//        
//        self.prototypeCell.bounds = CGRectMake(0.0, 0.0, CGRectGetWidth(bizTable.bounds), CGRectGetHeight(self.prototypeCell.bounds));
//        self.prototypeCell.layoutIfNeeded()
//        
//        var size:CGSize = self.prototypeCell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
//        println("\(size.height)")
//        return size.height+1;
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
