//
//  RegisterViewController.swift
//  CoreData Show in Tableview
//
//  Created by Mac on 27/08/20.
//  Copyright © 2020 Gunde Ramakrishna Goud. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
   // CREATING IBOUTLETS
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileNoTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var collegeNameTF: UITextField!
    @IBOutlet weak var univercityTF: UITextField!
    @IBOutlet weak var save: UIButton!
    var isUpdate = false
    var indexRow = Int()
    var collegeDetail: Colleges?
    override func viewDidLoad() {
        super.viewDidLoad()
        // TEXTFIELDS RETURNING DATA
        nameTF.text = collegeDetail?.name
        emailTF.text = collegeDetail?.email
        mobileNoTF.text = collegeDetail?.mobileNo
        addressTF.text = collegeDetail?.address
        collegeNameTF.text = collegeDetail?.collegeName
        univercityTF.text = collegeDetail?.univercity
        //profileImage.image = UIImage(data: collegeDetail!.profileImage)
        if let collegeDetail = collegeDetail {
            profileImage.image = UIImage(data: collegeDetail.profileImage!)
        }
       
        // ROUND IMAGE AND BUTTION
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        profileImage.clipsToBounds = true
        save.layer.cornerRadius = save.frame.size.height / 2
        
        // CREATING TAPGESTURE
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(creatingUIImagePickerView))
            tapGesture.numberOfTapsRequired = 1
            profileImage.isUserInteractionEnabled = true
            profileImage.addGestureRecognizer(tapGesture)
        
        // TEXTFIELDS DELEGATES
        nameTF.delegate = self
        emailTF.delegate = self
        mobileNoTF.delegate = self
        addressTF.delegate = self
        collegeNameTF.delegate = self
        univercityTF.delegate = self
        
        // Do any additional setup after loading the view.
      }
     override func viewWillAppear(_ animated: Bool) {
        if isUpdate {
            save.setTitle("Update", for: .normal)
        }else{
            save.setTitle("Save", for: .normal)
        }
    }
    
    // CREATING TAPGESTURE TARGET ACTION FUNCTION
    @objc func creatingUIImagePickerView(){
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a Source", preferredStyle: .actionSheet)
    actionSheet.addAction(UIAlertAction(title: "Cemara", style: .default, handler: { (action:UIAlertAction) in
    if UIImagePickerController.isSourceTypeAvailable(.camera)
    {
    imagePickerController.sourceType = .camera
    self.present(imagePickerController, animated: true, completion: nil)
    }
    else
    {
    print("Cemara is not Availabel")
    }
    }))
    actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
    imagePickerController.sourceType = .photoLibrary
    self.present(imagePickerController, animated: true, completion: nil)
    }))
    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    self.present(actionSheet, animated: true, completion: nil)
    }
    //CREATING UIImagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        profileImage.image = image
        picker.dismiss(animated: true, completion: nil)
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        }
    
    
    //using textField function from delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
    if(textField == nameTF || textField == addressTF || textField == collegeNameTF || textField == univercityTF)
    {
    let allowedCharacter = CharacterSet.letters//allowing only letters
    let allowedCharacter1 = CharacterSet.whitespaces//allowing spaces
    let characterSet = CharacterSet(charactersIn: string)

    return allowedCharacter.isSuperset(of: characterSet) || allowedCharacter1.isSuperset(of: characterSet)
    }
    return true
    }
    
    
    //using textFieldShouldBeginEditing function from delegates
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
     {
       var returnValue = false
       //condition for first name
       if(textField == nameTF)
        {
          returnValue = true
        }
         //condition for last name
          else if(textField == emailTF)
            {
            if (nameTF.text!.count>1)//this condition satisfies then only next field editable
             {
                returnValue = true
             }
            else
             {
              returnValue = false
             }
        }
        //condition for email
        else if(textField == mobileNoTF)
            {
            if (nameTF.text!.count>1 && emailTF.text!.isValidEmail)//this condition satisfies then only next field editable
            {
            returnValue = true

            }
            else
            {

            returnValue = false
            }
               }
        //condition for mobileNumberTF
        else if(textField == addressTF)
          {
              if(nameTF.text!.count>1 && emailTF.text!.isValidEmail && mobileNoTF.text!.isValidPhoneNumber)//this condition satisfies then only next field editable
            {
                returnValue = true
            }
            else
             {
                returnValue = false
             }
            }
        //condition for password
        else if(textField == collegeNameTF)
          {
            
            if(nameTF.text!.count>1 && emailTF.text!.isValidEmail && mobileNoTF.text!.isValidPhoneNumber && addressTF.text!.count>1)//this condition satisfies then only next field editable
              {
                returnValue = true
              }
            else
              {
                returnValue = false
              }
           }
         //condition for repeat password
         else if(textField == univercityTF)
           {
            if(nameTF.text!.count>1 && emailTF.text!.isValidEmail && mobileNoTF.text!.isValidPhoneNumber && addressTF.text!.count>1 && collegeNameTF.text!.count>1)//this condition satisfies then only next field editable
               {
                 returnValue = true
               }
             else
               {
                 returnValue = false
               }
            }
           return returnValue
      }
         //using textFieldShouldEndEditing function from delegates
          func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
          {
            //operations for email
            if(textField == emailTF)
            {
            if (emailTF.text?.isValidEmail)!
            {
                        
            }
            else
            {
            //Display Alert Message
            displayMessage(title: "Warning", message: "Invalid Email")

            }
            }
            //operations for mobile number
            else if(textField == mobileNoTF)
            {
            if (mobileNoTF.text?.isValidPhoneNumber)!
            {
                    
            }
            else
            {
            //Display Alert Message
            displayMessage(title: "Warning", message: "Please Enter 10 digit Mobile Number")
            }
            }
            return true
            }
       //Alert Controller
       func displayMessage(title:String,message:String) -> Void
        {

           let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
          alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
              alert.dismiss(animated: true, completion: nil)

          }))

          self.present(alert,animated: true,completion: nil)
       }

}

// EXTENSION REGISTERVIEWCONTROLLER
extension RegisterViewController {
 // CREATING SAVE BUTTON IBACTION
@IBAction func onSaveBtn(_ sender: UIButton)
{
    let pngImageData = profileImage.image?.pngData() as! Data
        
    // TEXT FIELDS IN DICTIONARY FORMATS
    let dict = ["name":nameTF.text!,"email":emailTF.text!,"mobileNo":mobileNoTF.text!,"address":addressTF.text!,"collegeName":collegeNameTF.text!,"univercity":univercityTF.text!] as NSDictionary
    // IF IT ISUPDATE
    if isUpdate{
        DataManager.instance.updateData(receivedData: dict as NSDictionary, profileImage: pngImageData, index: indexRow)
        isUpdate = false
    }else{
        DataManager.instance.saveData(receivedData: dict as NSDictionary, profileImage: pngImageData)
    }
       nameTF.text = ""
       emailTF.text = ""
       mobileNoTF.text = ""
       addressTF.text = ""
       collegeNameTF.text = ""
       univercityTF.text = ""
    }
}
//string extension
extension String
 {
  var isValidEmail:Bool
   {
    let emailContains = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    let emailText = NSPredicate(format: "SELF MATCHES %@", emailContains)
    return emailText.evaluate(with: self)
   }

  //for phone number validation
  var isValidPhoneNumber:Bool
   {
     let numberContains = "^[0-9]{10,10}"
     let numberText = NSPredicate(format: "SELF MATCHES %@", numberContains)
     return numberText.evaluate(with: self)
   }
}
