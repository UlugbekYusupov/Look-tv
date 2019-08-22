//
//  LoginController.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 8/12/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKCoreKit
import FBSDKLoginKit

class LoginController: UIViewController {
    
    let signupController = SignupController()
    let headerView = UIView()
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.setImage(#imageLiteral(resourceName: "icon_cancel_white"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleDismissButton), for: .touchUpInside)
        return button
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Log in"
        label.textColor = .white
        label.font = UIFont(name: "Verdana-Bold", size: 20)
        return label
    }()
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .red
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let emailTextField: UITextField = {
        let field = UITextField()
        field.clipsToBounds = true
        field.contentMode = .scaleAspectFit
        field.placeholder = " Email or phone"
        field.backgroundColor = .white
        field.font = UIFont.systemFont(ofSize: 13)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let passwordTextField: UITextField = {
        let field = UITextField()
        field.clipsToBounds = true
        field.contentMode = .scaleAspectFit
        field.placeholder = " Passsword"
        field.backgroundColor = .white
        field.font = UIFont.systemFont(ofSize: 13)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0 / 255, green: 209 / 255, blue:  102 / 255, alpha: 1)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let faceBookButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.layer.cornerRadius = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleFacebook), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0 / 255, green: 140 / 255, blue: 218 / 255, alpha: 1)
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.layer.cornerRadius = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0 / 255, green: 209 / 255, blue:  102 / 255, alpha: 1)
        return button
    }()
    
    let checkboxButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(handleCheck), for: .touchUpInside)
        return button
    }()
    
    let keepLabel: UILabel = {
        let label = UILabel()
        label.text = "Keep it logged in"
        label.font = UIFont(name: "Verdana", size: 10)
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFill
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    let forgotLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot password?"
        label.font = UIFont(name: "Verdana", size: 12)
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFill
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
//        view.backgroundColor = .clear
        setupHeaderView()
        setuoBottomItems()
        setupLogoTextField()
        setupItems()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:- setup methods
 
    fileprivate func setupHeaderView() {
        view.addSubview(headerView)
        headerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 70))
        
        
        headerView.addSubview(loginLabel)
        loginLabel.centerXInSuperview()
        loginLabel.anchor(top: nil, leading: nil, bottom: headerView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 10, right: 0), size: CGSize(width: 0, height: 0))
        
        let gradient = CAGradientLayer()
        
        
        gradient.frame =  CGRect(x: 0, y: 0, width: view.frame.width, height: 70.0)
        let leftColor = UIColor(red: 0 / 255, green: 140 / 255, blue: 218 / 255, alpha: 1)
        let rightColor = UIColor(red: 0 / 255, green: 209 / 255, blue:  102 / 255, alpha: 1)
        
        gradient.colors = [leftColor.cgColor, rightColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        headerView.layer.insertSublayer(gradient, at: 0)
        
        headerView.addSubview(dismissButton)
        dismissButton.anchor(top: nil, leading: nil, bottom: headerView.bottomAnchor, trailing: headerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 10), size: CGSize(width: 45, height: 45))
    }
    
    fileprivate func setuoBottomItems() {
        view.addSubview(signUpButton)
        signUpButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 70, bottom: 50, right: 70), size: CGSize(width: 0, height: 30))
        
        view.addSubview(faceBookButton)
        
        faceBookButton.anchor(top: nil, leading: view.leadingAnchor, bottom: signUpButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 70, bottom: 20, right: 70), size: CGSize(width: 0, height: 30))
        
    }
//    0x2839d2b70
    fileprivate func setupLogoTextField() {
        view.addSubview(logoImageView)
        logoImageView.anchor(top: headerView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 120, left: 100, bottom: 0, right: 100), size: CGSize(width: 120, height: 50))
        
        view.addSubview(emailTextField)
        emailTextField.anchor(top: logoImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 50, left: 70, bottom: 0, right: 70), size: CGSize(width: 0, height: 35))
        
        view.addSubview(passwordTextField)
        passwordTextField.anchor(top: emailTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 70, bottom: 0, right: 70), size: CGSize(width: 0, height: 35))
    }
    
    fileprivate func setupItems() {
        view.addSubview(checkboxButton)
        checkboxButton.anchor(top: passwordTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: 70, bottom: 0, right: 0), size: CGSize(width: 25, height: 25))
        
        view.addSubview(keepLabel)
        keepLabel.anchor(top: checkboxButton.topAnchor, leading: checkboxButton.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 5, left: 5, bottom: 0, right: 0), size: CGSize(width: 110, height: 15))
        
        
        view.addSubview(loginButton)
        loginButton.anchor(top: checkboxButton.topAnchor, leading: nil, bottom: nil, trailing: passwordTextField.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 80, height: 25))
        
        view.addSubview(forgotLabel)
        forgotLabel.anchor(top: loginButton.bottomAnchor, leading: checkboxButton.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 20, bottom: 0, right: 100), size: CGSize(width: 0, height: 20))
    }
    
    
    //MARK:- handle methods
    
    @objc func handleDismissButton() {
        self.dismiss(animated: true, completion: nil)
        let rootController = RootController()
        self.present(rootController,animated: true)
    }
    
    
    @objc func handleCheck() {
        if checkboxButton.isSelected {
            checkboxButton.backgroundColor = .yellow
        }
        else {
            checkboxButton.backgroundColor = .red
        }
        checkboxButton.isSelected = !checkboxButton.isSelected
    }
    
    @objc func handleFacebook() {
        self.dismiss(animated: false, completion: nil)

        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile, .email,], viewController: self) { (result) in
            switch result {
            case .cancelled:
                print("User cancelled login process")
                break
            case .failed(let error):
                print("Login failed with error = \(error.localizedDescription)")
                break
            case .success(_,_,_):
                self.getUserInfo()
            }
        }
    }
    
    fileprivate func getUserInfo() {
        let request = GraphRequest(graphPath: "me", parameters: ["fields":"id,email,picture"], httpMethod: .get)
        
        request.start { (connection, result, error) in
            
//            let detail = result as! [String: Any?]
//            guard let email = detail["email"] else {return}
//            guard let imageData = detail["picture"] else {return}
            
            let data = result as! NSDictionary
            guard let email = data["email"] else {return}
            let imageData = data.value(forKey: "picture") as! NSDictionary
            let imageUrl = imageData.value(forKey: "data") as! NSDictionary
            guard let url = imageUrl.value(forKey: "url") as! String? else {return}
            
            print(AccessToken.current?.tokenString)
            print(UIDevice.current.name)
            let uuid = UUID()
            print(uuid)
            print(url)
            
            emailIDLabel.text = (email as! String)
            userImageView.sd_setImage(with: URL(string: url), completed: nil)
        }
    }
    
    @objc func handleSignUp() {
        let signUpcontroller = SignupController()
        present(signUpcontroller, animated: true)
    }
    
    @objc func handleLogin() {
        print("log in")
    }

}
