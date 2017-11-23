//
//  JsonDataViewerVC.swift
//  Pinboard
//
//  Created by Nikhlesh bagdiya on 22/11/17.
//  Copyright © 2017 Nikhlesh bagdiya. All rights reserved.
//

import UIKit

class JsonDataViewerViewController: UIViewController {

    //  MARK: - IBOutlet Declarations.
    @IBOutlet weak var tableView: UITableView!
    
    //  MARK: - Variable Declarations.
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.black
        
        return refreshControl
    }()
    
    
    //  MARK: - UIViewController Override Methods.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupInitilView()
    }
    
    //  MARK: - setup Initial View Methode.
    private func setupInitilView() {
        
        //Remove tableview extra seprator lines.
        tableView.tableFooterView = UIView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.addSubview(self.refreshControl)
    }
    
    //  MARK: - Refresh controller handler Methode.
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        
//        let newHotel = Hotels(name: "Montage Laguna Beach", place:
//            "California south")
//        hotels.append(newHotel)
//        
//        hotels.sort() { $0.name < $0.place }
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

    // MARK: - Memory Warning handle Methode.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UITableViewDelegate and UITableViewDataSource Methods.
extension JsonDataViewerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        var cell:UITableViewCell? =
            tableView.dequeueReusableCell(withIdentifier: Identifiers.kJsonTableCell)
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle,
                                   reuseIdentifier: Identifiers.kJsonTableCell)
        }
        
        cell?.selectionStyle = .none
        
        // At this point, we definitely have a cell -- either dequeued or newly created,
        // so let's force unwrap the optional into a UITableViewCell
        cell?.textLabel?.text = "John Deo"
        cell?.detailTextLabel?.text = "Nature"
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // self.tableView.estimatedRowHeight = 50
        return 80//UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
