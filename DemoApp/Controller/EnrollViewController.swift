//
//  EnrollViewController.swift
//  DemoApp
//
//  Created by Yatharth Mahawar on 1/8/21.
//

import UIKit

class EnrollViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {

    let genderData = ["Female","Male"]
    var profiledata = [Profile]()
    var phoneNumberData = [String]()
    
    //MARK:- Outlets
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var addUser: UIButton!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var Country: UITextField!
    @IBOutlet weak var State: UITextField!
    @IBOutlet weak var homeTown: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var teleNumber: UITextField!
    let datePicker = UIDatePicker()
    let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarImage.layer.cornerRadius = self.avatarImage.frame.size.width/2
        addUser.layer.cornerRadius = 10
        createDatePicker()
        gender.inputView = picker
        picker.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        profiledata = DataBaseHelper.shareInstance.fetchData()
        for i in profiledata{
            phoneNumberData.append(i.phoneNumer!)
        }
        
        
        

        


        // Do any additional setup after loading the view.
    }
    
    //MARK:- UIImagePickerViewController
    
    @IBAction func addImageButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        avatarImage.image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Add User Function & Validation
    
    @IBAction func addUser(_ sender: UIButton) {
        var duplicate = phoneNumberData.contains(mobileNumber.text!)
        
        if duplicate {
            let alert = UIAlertController(title: "Duplicate Phone Number", message: "Please enter differnet Number", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }
        else {
            
            
            if (firstName.text?.vaildData)! && (lastName.text?.vaildData)! && (Country.text?.vaildData)! && (State.text?.vaildData)! && (homeTown.text?.vaildData)! && (mobileNumber.text?.vaildNumber)!{
                let age = calcAge(birthday: dateOfBirth.text!)
                let dict:[String:String] = ["firstName":firstName.text!,"lastName":lastName.text!,"dob":dateOfBirth.text!,"gender":gender.text!,"country":Country.text!,"state":State.text!,"homeTown":homeTown.text!,"phoneNumber":mobileNumber.text!,"teleNumber":teleNumber.text!,"age":String(age)]
                let _ = self.avatarImage.image?.jpegData(compressionQuality: 0.75)
                if let img = self.avatarImage.image?.pngData() {
                    DataBaseHelper.shareInstance.SaveData(dict: dict, imgData: img)
                }
                
                firstName.text = ""
                lastName.text = ""
                dateOfBirth.text = ""
                gender.text = ""
                Country.text = ""
                State.text = ""
                homeTown.text = ""
                mobileNumber.text = ""
                teleNumber.text = ""
                
            }
            else {
                let alert = UIAlertController(title: "Invaild Details", message: "Please enter vaild data", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                
            }
            
        }
        
        
        
    }
    
    //MARK:- Date Picker Toolbar
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneBtnPressed))
        toolbar.setItems([doneBtn], animated: true)
        return toolbar
    }
    
    func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        dateOfBirth.inputView = datePicker
        dateOfBirth.inputAccessoryView  = createToolbar()
    }
    
    @objc func doneBtnPressed(){
        let dateFormat = DateFormatter()
        //dateFormat.dateStyle = .medium
        dateFormat.dateFormat = "MM/dd/yyyy"
        //dateFormat.timeStyle = .none
        self.dateOfBirth.text = dateFormat.string(from: datePicker.date)
        self.view.endEditing(true)
        
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //MARK:- UIPickerView
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.gender.text = genderData[row]
    }

    

}
