//
//  RegisterViewController.swift
//  chat-app
//
//  Created by Aida Pourshirazi on 3/29/21.
//

import UIKit
import FirebaseAuth
import JGProgressHUD


class RegisterViewController: UIViewController {
    
    private let spinner = JGProgressHUD ( style: .dark)

    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView ()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView : UIImageView = {
        let imageView = UIImageView ()
        imageView.image = UIImage ( named: "Logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    private let emailField : UITextField = {
        let field  = UITextField ()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address...."
        
        field.leftView = UIView (frame:  CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        return field
    }()
    
    
    private let firstnameField : UITextField = {
        let field  = UITextField ()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = " First name...."
        
        field.leftView = UIView (frame:  CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        return field
    }()
    
    
    private let LastnameField : UITextField = {
        let field  = UITextField ()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = " Last name...."
        
        field.leftView = UIView (frame:  CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        return field
    }()
    
    private let passwordField : UITextField = {
        let field  = UITextField ()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password...."
        
        field.leftView = UIView (frame:  CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        
        return field
    }()

    
    private let registerButton: UIButton = {
        let button = UIButton ()
        button.setTitle ("Register", for: .normal )
        button.backgroundColor = .systemGreen
        return button
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log In "
        view.backgroundColor = .white
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem (title: "Register",
                                                             style: .done ,
                                                             target: self,
                                                             action: #selector(didTapRegister))
        
        
        registerButton.addTarget(self,
                              action : #selector(registerButtonTapped),
                              for: .touchUpInside)
        
        
        emailField.delegate = self
        passwordField.delegate = self
        
        //add subview
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        scrollView.addSubview(firstnameField)
        scrollView.addSubview(LastnameField)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        emailField.frame = CGRect(x: 30,
                                  y: imageView.bottom+10,
                                  width: scrollView.width-60,
                                  height: 52)
        
        firstnameField.frame = CGRect(x: 30,
                                  y: emailField.bottom+10,
                                  width: scrollView.width-60,
                                  height: 52)
        LastnameField.frame = CGRect(x: 30,
                                  y: firstnameField.bottom+10,
                                  width: scrollView.width-60,
                                  height: 52)
        
        passwordField.frame = CGRect(x: 30,
                                     y: LastnameField.bottom+10,
                                     width: scrollView.width-60,
                                     height: 52)
        
        registerButton.frame = CGRect(x: 30,
                                   y: passwordField.bottom+10,
                                   width: scrollView.width-60,
                                   height: 52)
        
        
        
    }
    
    
    @objc private func registerButtonTapped () {
        guard let _ = firstnameField.text,
              let _ = LastnameField.text,
              let email = emailField.text ,
              let password = passwordField.text,
              !email.isEmpty, !password.isEmpty
        else {
            alertUserLoginError()
            return
        }
        
        
        
        spinner.show(in: view )
        
        //fire base log in
         
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [ weak self] authResult, error  in
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                strongSelf.spinner.dismiss()

            }
            
            guard let result = authResult, error == nil else {
                print ("Error creating user")
                return
            }
            
            let user = result.user
            print("created user: \(user)")
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            
        })
        
        
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController (title : "Woops"
                                       , message:  "try again ", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ignore", style: .cancel , handler: nil))
        
        
        
        present( alert, animated: true)
        
    }
    
    
    @objc private func didTapRegister () {
        let vc = RegisterViewController ()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated:true)
    }
    
    
    
}


extension RegisterViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if  textField == passwordField {
            
            registerButtonTapped()
            
            
        }
        
        return true
        
    }
}
