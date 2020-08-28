//
//  DetailsViewController.swift
//  CoreData Show in Tableview
//
//  Created by Mac on 28/08/20.
//  Copyright © 2020 Gunde Ramakrishna Goud. All rights reserved.
//

import UIKit

class DetailsViewController: UITableViewController {

    //CREATING OUTLETS
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var mobileNoLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var collegeNameLbl: UILabel!
    @IBOutlet weak var univercityLbl: UILabel!
    
    var collegeDetails: Colleges?
    var indexRow = Int()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //ROUND IMAGE
        img.layer.cornerRadius = img.frame.size.height / 2
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        NameLbl.text = collegeDetails?.name
        emailLbl.text = collegeDetails?.email
        mobileNoLbl.text = collegeDetails?.mobileNo
        addressLbl.text = collegeDetails?.address
        collegeNameLbl.text = collegeDetails?.collegeName
        univercityLbl.text = collegeDetails?.univercity 
        img.image = UIImage(data: collegeDetails!.profileImage!)
    }
    
    // IBACTION EDITING BUTTON
    @IBAction func onEditBtn(_ sender: UIBarButtonItem)
    {
        let registerVC = self.storyboard?.instantiateViewController(identifier: "RegisterViewController") as! RegisterViewController
        registerVC.isUpdate = true
        registerVC.collegeDetail = collegeDetails
        registerVC.indexRow = indexRow
        self.navigationController?.pushViewController(registerVC, animated: false)
    }
    
   

}
