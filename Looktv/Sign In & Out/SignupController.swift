//
//  SignupController.swift
//  Final_Look
//
//  Created by Mirzoulugbek Yusupov on 8/12/19.
//  Copyright © 2019 Mirzoulugbek Yusupov. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class SignupController: UIViewController, UINavigationControllerDelegate {
    let headerView = UIView()

    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .blue
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.textColor = .white
        label.font = UIFont(name: "Verdana-Bold", size: 20)
        return label
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.setImage(#imageLiteral(resourceName: "icon_cancel_white"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleDismissButton), for: .touchUpInside)
        return button
    }()
    
    
    let emailTextField: UITextField = {
        let field = UITextField()
        field.clipsToBounds = true
        field.contentMode = .scaleAspectFit
        field.placeholder = " example@sample.com"
        field.backgroundColor = .white
        field.font = UIFont.systemFont(ofSize: 14)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    
    let passwordTextField: UITextField = {
        let field = UITextField()
        field.clipsToBounds = true
        field.contentMode = .scaleAspectFit
        field.backgroundColor = .white
        field.font = UIFont.systemFont(ofSize: 14)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let confirmTextField: UITextField = {
        let field = UITextField()
        field.clipsToBounds = true
        field.contentMode = .scaleAspectFit
        field.backgroundColor = .white
        field.font = UIFont.systemFont(ofSize: 14)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let mobileTextField: UITextField = {
        let field = UITextField()
        field.clipsToBounds = true
        field.contentMode = .scaleAspectFit
        field.backgroundColor = .white
        field.font = UIFont.systemFont(ofSize: 14)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let birthdayTextField: UITextField = {
        let field = UITextField()
        field.clipsToBounds = true
        field.contentMode = .scaleAspectFit
        field.placeholder = " YYYYMMDD"
        field.backgroundColor = .white
        field.font = UIFont.systemFont(ofSize: 14)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    
    let okButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.backgroundColor = UIColor(red: 0 / 255, green: 209 / 255, blue:  102 / 255, alpha: 1)
        button.addTarget(self, action: #selector(handleOkButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(handleDismissButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK:- viewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2507136166, green: 0.2596068382, blue: 0.3075306118, alpha: 1)
        setupHeaderView()
        
        view.addSubview(logoImageView)
        logoImageView.anchor(top: headerView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 80, left: 100, bottom: 0, right: 100), size: CGSize(width: 110, height: 50))
        
        setupStackView()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:_ handle methods
    @objc func handleDismissButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleOkButton() {
        
        let isFormValid = emailTextField.text?.count ?? 0 > 0 || passwordTextField.text?.count ?? 0 > 0 || birthdayTextField.text?.count ?? 0 > 0

//        if !isFormValid {
//            emailTextField.placeholder = " Please input right e-mail"
//            passwordTextField.placeholder = " Please input right password"
//            birthdayTextField.placeholder = " Wrong birthday"
//        }
//
//        else {
            signUpfetch(email: "bilmadim.uz@gmail.com", password: "123456789", firstName: "Ulugbek", lastName: "Yusupov", birth: "19960902", mobile: 01058259602, nickName: "Derek")
//        }
    }
    
    //MARK:- setup methods
    fileprivate func setupHeaderView() {
        view.addSubview(headerView)
        headerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 70))
        
        
        headerView.addSubview(signUpLabel)
        signUpLabel.centerXInSuperview()
        signUpLabel.anchor(top: nil, leading: nil, bottom: headerView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 10, right: 0), size: CGSize(width: 0, height: 0))
        
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
    
    fileprivate func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,confirmTextField,mobileTextField,birthdayTextField])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 5
        view.addSubview(stackView)
        stackView.anchor(top: logoImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 50, left: 130, bottom: 0, right: 15), size: CGSize(width: 0, height: 200))
        
        view.addSubview(okButton)
        okButton.anchor(top: stackView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 50, left: 30, bottom: 0, right: 0), size: CGSize(width: 120, height: 30))
        
        view.addSubview(cancelButton)
        cancelButton.anchor(top: stackView.bottomAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 0, right: 30), size: CGSize(width: 120, height: 30))
    }
    
    fileprivate func signUpfetch(email: String, password: String, firstName: String, lastName: String, birth: String, mobile: Int, nickName: String) {
        
        let urlString = "https://api.looktv.mn/api/account/join?email=\(email)&password=\(password)&firstName=\(firstName)&lastName=\(lastName)&mobile=\(mobile)&birth=\(birth)&sex=0,nickName=\(nickName)&platformId=2c9f807e51955cea0151a5f6a83200ab"
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            
            if let err = error {
                print("Failed to login", err)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let messageJson = try JSONDecoder().decode(SignupMessage.self, from: data)
                print(messageJson)
            }
            
            catch let jsonError{
                print(jsonError)
            }
        }.resume()
    }
}
