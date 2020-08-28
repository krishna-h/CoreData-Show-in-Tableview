//
//  ViewController.swift
//  CoreData Show in Tableview
//
//  Created by Mac on 27/08/20.
//  Copyright © 2020 Gunde Ramakrishna Goud. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var dataSourceArr = [Colleges]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //CALLING DATAMANAGER
        self.dataSourceArr = DataManager.instance.fetchData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        //CALLING DATAMANAGER
        self.dataSourceArr = DataManager.instance.fetchData()
        self.tableView.reloadData()
    }
    // CREATING ADD BUTTON IBACTION
    @IBAction func onAddBtn(_ sender: UIBarButtonItem) {
        let regVC = self.storyboard?.instantiateViewController(identifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(regVC, animated: true)
    }
    
   }
  
// EXTENSION VIEWCONTROLLER
   extension ViewController: UITableViewDelegate,UITableViewDataSource {
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArr.count
         }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
//        cell.img.image = UIImage(data: dataSourceArr[indexPath.row].profileImage!)
//        cell.nameLbl.text = dataSourceArr[indexPath.row].name
//        cell.addressLbl.text = dataSourceArr[indexPath.row].address
//        cell.universityLbl.text = dataSourceArr[indexPath.row].univercity
        cell.college = dataSourceArr[indexPath.row]
        
        return cell
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
     
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            dataSourceArr = DataManager.instance.deleteData(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        detailVC.collegeDetails = dataSourceArr[indexPath.row]
        detailVC.indexRow = indexPath.row
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}

