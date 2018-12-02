//
//  LoginController.swift
//  livechat
//
//  Created by Vinh Vu on 10/8/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit
import Firebase

class HandleLogin: UIViewController {
    
    var messagesController: HandleMessages?
    
    let iv: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var loginAndRegistrationButton: UIButton = {
        let lrB = UIButton(type: .system)
        lrB.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        lrB.setTitle("Register", for: UIControl.State())
        lrB.translatesAutoresizingMaskIntoConstraints = false
        lrB.setTitleColor(UIColor.white, for: UIControl.State())
        lrB.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        lrB.addTarget(self, action: #selector(loginRegisterInputAuth), for: .touchUpInside)
        
        return lrB
    }()
    
    @objc func loginRegisterInputAuth() {
        if userRegistrationAndLogin.selectedSegmentIndex == 0 {
            authorization()
        } else {
            handleRegister()
        }
    }
    
    func authorization() {
        guard let email = createEmailInput.text, let password = createPasswordInput.text else {
            print("Form is not valid")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            //user is able to login
            
            self.messagesController?.fetchUserAndSetupNavBarTitle()
            
            self.dismiss(animated: true, completion: nil)
            
        })
        
    }
    
    let createNameInput: UITextField = {
        let ip = UITextField()
        ip.placeholder = "Name"
        ip.translatesAutoresizingMaskIntoConstraints = false
        return ip
    }()
    
    let nameDivider: UIView = {
        let divider = UIView()
        divider.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    let createEmailInput: UITextField = {
        let input = UITextField()
        input.placeholder = "Email"
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    let emailDivider: UIView = {
        let divider = UIView()
        divider.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    let createPasswordInput: UITextField = {
        let input = UITextField()
        input.placeholder = "Password"
        input.translatesAutoresizingMaskIntoConstraints = false
        input.isSecureTextEntry = true
        return input
    }()
    
    lazy var profilePicture: UIImageView = {
        let picture = UIImageView()
        picture.image = UIImage(named: "spartan")
        picture.translatesAutoresizingMaskIntoConstraints = false
        picture.contentMode = .scaleAspectFill
        
        picture.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pickProfilePicture)))
        picture.isUserInteractionEnabled = true
        
        return picture
    }()
    
    lazy var userRegistrationAndLogin: UISegmentedControl = {
        let loginRegistration = UISegmentedControl(items: ["Login", "Register"])
        loginRegistration.translatesAutoresizingMaskIntoConstraints = false
        loginRegistration.tintColor = UIColor.white
        loginRegistration.selectedSegmentIndex = 1
        loginRegistration.addTarget(self, action: #selector(createLoginRegistrationText), for: .valueChanged)
        return loginRegistration
    }()
    
    @objc func createLoginRegistrationText() {
        let title = userRegistrationAndLogin.titleForSegment(at: userRegistrationAndLogin.selectedSegmentIndex)
        loginAndRegistrationButton.setTitle(title, for: UIControl.State())
        
        overallHeightInput?.constant = userRegistrationAndLogin.selectedSegmentIndex == 0 ? 100 : 150
        
        nameHeightInput?.isActive = false
        nameHeightInput = createNameInput.heightAnchor.constraint(equalTo: iv.heightAnchor, multiplier: userRegistrationAndLogin.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameHeightInput?.isActive = true
        createNameInput.isHidden = userRegistrationAndLogin.selectedSegmentIndex == 0
        
        emailHeightInput?.isActive = false
        emailHeightInput = createEmailInput.heightAnchor.constraint(equalTo: iv.heightAnchor, multiplier: userRegistrationAndLogin.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailHeightInput?.isActive = true
        
        passwordHeightInput?.isActive = false
        passwordHeightInput = createPasswordInput.heightAnchor.constraint(equalTo: iv.heightAnchor, multiplier: userRegistrationAndLogin.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordHeightInput?.isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        view.addSubview(iv)
        view.addSubview(loginAndRegistrationButton)
        view.addSubview(profilePicture)
        view.addSubview(userRegistrationAndLogin)
        
        inputView()
        createLoginAndRegistrationButton()
        setupProfileImageView()
        setupLoginControl()
    }
    
    func setupLoginControl() {
        userRegistrationAndLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userRegistrationAndLogin.bottomAnchor.constraint(equalTo: iv.topAnchor, constant: -12).isActive = true
        userRegistrationAndLogin.widthAnchor.constraint(equalTo: iv.widthAnchor, multiplier: 1).isActive = true
        userRegistrationAndLogin.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    func setupProfileImageView() {
        profilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profilePicture.bottomAnchor.constraint(equalTo: userRegistrationAndLogin.topAnchor, constant: -12).isActive = true
        profilePicture.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profilePicture.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    var overallHeightInput: NSLayoutConstraint?
    var nameHeightInput: NSLayoutConstraint?
    var emailHeightInput: NSLayoutConstraint?
    var passwordHeightInput: NSLayoutConstraint?
    
    func inputView() {
        iv.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iv.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        iv.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        overallHeightInput = iv.heightAnchor.constraint(equalToConstant: 150)
        overallHeightInput?.isActive = true
        
        iv.addSubview(createNameInput)
        iv.addSubview(nameDivider)
        iv.addSubview(createEmailInput)
        iv.addSubview(emailDivider)
        iv.addSubview(createPasswordInput)
        
        createNameInput.leftAnchor.constraint(equalTo: iv.leftAnchor, constant: 12).isActive = true
        createNameInput.topAnchor.constraint(equalTo: iv.topAnchor).isActive = true
        
        createNameInput.widthAnchor.constraint(equalTo: iv.widthAnchor).isActive = true
        nameHeightInput = createNameInput.heightAnchor.constraint(equalTo: iv.heightAnchor, multiplier: 1/3)
        nameHeightInput?.isActive = true
        
        nameDivider.leftAnchor.constraint(equalTo: iv.leftAnchor).isActive = true
        nameDivider.topAnchor.constraint(equalTo: createNameInput.bottomAnchor).isActive = true
        nameDivider.widthAnchor.constraint(equalTo: iv.widthAnchor).isActive = true
        nameDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        createEmailInput.leftAnchor.constraint(equalTo: iv.leftAnchor, constant: 12).isActive = true
        createEmailInput.topAnchor.constraint(equalTo: createNameInput.bottomAnchor).isActive = true
        
        createEmailInput.widthAnchor.constraint(equalTo: iv.widthAnchor).isActive = true
        
        emailHeightInput = createEmailInput.heightAnchor.constraint(equalTo: iv.heightAnchor, multiplier: 1/3)
        
        emailHeightInput?.isActive = true
        
        emailDivider.leftAnchor.constraint(equalTo: iv.leftAnchor).isActive = true
        emailDivider.topAnchor.constraint(equalTo: createEmailInput.bottomAnchor).isActive = true
        emailDivider.widthAnchor.constraint(equalTo: iv.widthAnchor).isActive = true
        emailDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        createPasswordInput.leftAnchor.constraint(equalTo: iv.leftAnchor, constant: 12).isActive = true
        createPasswordInput.topAnchor.constraint(equalTo: createEmailInput.bottomAnchor).isActive = true
        
        createPasswordInput.widthAnchor.constraint(equalTo: iv.widthAnchor).isActive = true
        passwordHeightInput = createPasswordInput.heightAnchor.constraint(equalTo: iv.heightAnchor, multiplier: 1/3)
        passwordHeightInput?.isActive = true
    }
    
    func createLoginAndRegistrationButton() {
        loginAndRegistrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginAndRegistrationButton.topAnchor.constraint(equalTo: iv.bottomAnchor, constant: 12).isActive = true
        loginAndRegistrationButton.widthAnchor.constraint(equalTo: iv.widthAnchor).isActive = true
        loginAndRegistrationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}








