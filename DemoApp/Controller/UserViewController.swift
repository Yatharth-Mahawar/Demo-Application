//
//  UserViewController.swift
//  DemoApp
//
//  Created by Yatharth Mahawar on 1/8/21.
//

import UIKit

class UserViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var profileData = [Profile]()
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var myRemoveButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileData = DataBaseHelper.shareInstance.fetchData()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(UserViewController.refreshData), for: .valueChanged)
        tableView.addSubview(refreshControl)
        

        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- UIRefreshControl
    
    @objc func refreshData(){
        profileData = DataBaseHelper.shareInstance.fetchData()
        refreshControl.endRefreshing()
        self.tableView.reloadData()
    }
    
    
    //MARK:- TableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyTableViewCell
        cell.avatarImg.image = UIImage(data: profileData[indexPath.row].img!)
        cell.nameLabel.text = profileData[indexPath.row].firstName
        cell.genderLabel.text = profileData[indexPath.row].gender
        cell.ageLabel.text = profileData[indexPath.row].age
        cell.cityLabel.text = profileData[indexPath.row].homeTown
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            profileData = DataBaseHelper.shareInstance.deleteData(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
    }
    

}
