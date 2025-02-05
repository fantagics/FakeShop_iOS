//
//  LoginVC.swift
//  FakeShop
//
//  Created by 이태형 on 2024/07/27.
//

import UIKit
import SwiftUI
import SafariServices

class LoginVC: UIViewController {
    
    private let introView: UIView = UIView()
    private let loginPannel: UIView = UIView()
    private let welcomeLabel: UILabel = UILabel()
    private let descLabel: UILabel = UILabel()
    private let nameField: UITextField = UITextField()
    private let passwordField: UITextField = UITextField()
    private let agreeButton: UIButton = UIButton()
    private let termsLabel: UILabel = UILabel()
    private let loginButton: UIButton = UIButton()
    private let signupButton: UIButton = UIButton()
    
    private lazy var tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapEmptySpace(_:)))
    
    private let vm: LoginVM = LoginVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}

#Preview("LoginView"){
    return LoginVC()
}


//MARK: - Function
extension LoginVC{
    @objc private func didTapEmptySpace(_ sender: UIGestureRecognizer){
        self.view.endEditing(true)
    }
    
    @objc private func didTapTermsCheckBox(_ sender: UIButton){
        vm.isAgreeTerms.toggle()
        agreeButton.setImage(UIImage(systemName: vm.isAgreeTerms ? "checkmark.square" : "square"), for: .normal)
    }
    
    @objc private func didTapLinkLabel(_ sender: UIGestureRecognizer){
        let point = sender.location(in: termsLabel)
        if let serviceRect = termsLabel.boundingRectForCharacterRange(subText: "서비스 이용약관"),
           serviceRect.contains(point){
            present(SFSafariViewController(url: URL.serviceTermsUrl), animated: true)
        }
        if let serviceRect = termsLabel.boundingRectForCharacterRange(subText: "개인정보 이용약관"),
           serviceRect.contains(point){
            present(SFSafariViewController(url: URL.privateTermsUrl), animated: true)
        }
    }
    
    @objc private func didTapButton(_ sender: UIButton){
        if sender == loginButton{
            vm.loginValid(nameField, passwordField){ res in
                switch res{
                case .success(_):
                    let nextvc = MainTabBarController()
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootView(nextvc, animated: false)
                case .failure(let err):
                    self.present(UIAlertController.messageAlert(title: nil, message: err.message, completion: nil), animated: true)
                }
            }
            print("try Login")
        } else if sender == signupButton{
//            let nextVC = UIHostingController(rootView: SignUpSV())
            let nextVC = SignUpVC()
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else { print("didTapButton : somthing is wrong..")}
    }
    
}

//MARK: - inital_UI
extension LoginVC{
    private func setup(){
        setNavigation()
        setAttribute()
        setUI()
    }
    //NavigationController
    private func setNavigation(){
        self.navigationItem.backButtonDisplayMode = .minimal
    }
    //Attribute
    private func setAttribute(){
        view.backgroundColor = .white
        view.addGestureRecognizer(tapGesture)
        
        [welcomeLabel].forEach{
            $0.text = "환영합니다!"
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = .boldSystemFont(ofSize: 40)
        }
        [descLabel].forEach{
            $0.numberOfLines = 0
            $0.textAlignment = .left
//            $0.font = .systemFont(ofSize: 16)
            let appName = "페이크샵"
            let usedApiName = "fakestoreapi"
            let loginableData = "(mor_2314/83r5^_)"
            let guideText = String(format: "'%@'은 '%@'을 사용한 가짜 쇼핑 앱입니다. %@", appName, usedApiName, loginableData)
            let generalAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 16),
                .foregroundColor: UIColor.black.cgColor
            ]
            let accentAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 16),
                .foregroundColor: UIColor.black.cgColor
            ]
            let blurAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 16),
                .foregroundColor: UIColor.gray.cgColor
            ]
            let mutableString: NSMutableAttributedString = NSMutableAttributedString()
            mutableString.append(NSAttributedString(string: guideText, attributes: generalAttributes))
            mutableString.setAttributes(accentAttributes, range: (guideText as NSString).range(of: appName))
            mutableString.setAttributes(accentAttributes, range: (guideText as NSString).range(of: usedApiName))
            mutableString.setAttributes(blurAttributes, range: (guideText as NSString).range(of: loginableData))
            $0.attributedText = mutableString
            $0.sizeToFit()
        }
        
        [nameField, passwordField].forEach{
            $0.addLeftPadding(20)
            if let clearButton = $0.value(forKeyPath: "_clearButton") as? UIButton{
                clearButton.setImage(UIImage(systemName: "x.circle"), for: .normal)
                clearButton.tintColor = .primaryColor
            }
            $0.clearButtonMode = .always
            $0.font = .systemFont(ofSize: 16)
            $0.layer.cornerRadius = 25
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor.primaryColor?.cgColor
        }
        nameField.placeholder = "user name"
        passwordField.placeholder = "password"
        passwordField.isSecureTextEntry = true
        
        [agreeButton].forEach{
            $0.setImage(UIImage(systemName: vm.isAgreeTerms ? "checkmark.square" : "square"), for: .normal)
            $0.tintColor = .primaryColor
            $0.addTarget(self, action: #selector(didTapTermsCheckBox(_:)), for: .touchUpInside)
        }
        
        [termsLabel].forEach{
            $0.numberOfLines = 0
            $0.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLinkLabel(_:)))
            $0.addGestureRecognizer(tapGesture)
            
            let serviceTerm = "서비스 이용약관"
            let privateTerm = "개인정보 이용약관"
            let guideText = String(format: "%@과 %@에 동의합니다.", serviceTerm, privateTerm)
            let generalAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 13),
                .foregroundColor: UIColor.black.cgColor
            ]
            let linkAttributes: [NSAttributedString.Key: Any] = [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .font: UIFont.systemFont(ofSize: 13),
                .foregroundColor: UIColor.primaryColor?.cgColor ?? UIColor.blue.cgColor
            ]
            let mutableString: NSMutableAttributedString = NSMutableAttributedString()
            mutableString.append(NSAttributedString(string: guideText, attributes: generalAttributes))
            mutableString.setAttributes(linkAttributes, range: (guideText as NSString).range(of: serviceTerm))
            mutableString.setAttributes(linkAttributes, range: (guideText as NSString).range(of: privateTerm))
            
            $0.attributedText = mutableString
            $0.sizeToFit()
        }
        
        [loginButton].forEach{
            $0.backgroundColor = .primaryColor
            $0.setTitle("로그인", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 20)
            $0.layer.cornerRadius = 20
            $0.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        }
        
        [signupButton].forEach{
            $0.setTitle("회원가입", for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 20)
            $0.setTitleColor(.primaryColor, for: .normal)
            $0.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        }
    }
    //UI
    private func setUI(){
        [introView, loginPannel].forEach{
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [welcomeLabel, descLabel].forEach{
            introView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [nameField, passwordField].forEach{
            loginPannel.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let termsAgreement: UIStackView = UIStackView(arrangedSubviews: [agreeButton, termsLabel])
        [termsAgreement].forEach{
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .fill
            $0.spacing = 8
            loginPannel.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let loginBtnStack: UIStackView = UIStackView()
        [loginButton, signupButton].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            loginBtnStack.addArrangedSubview($0)
        }
        [loginBtnStack].forEach{
            $0.axis = .vertical
            $0.alignment = .center
            $0.distribution = .equalSpacing
            $0.spacing = 10
            loginPannel.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        NSLayoutConstraint.activate([
            loginPannel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginPannel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginPannel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            introView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            introView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            introView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            introView.bottomAnchor.constraint(equalTo: loginPannel.topAnchor),
            
            welcomeLabel.leadingAnchor.constraint(equalTo: introView.leadingAnchor, constant: 16),
            welcomeLabel.trailingAnchor.constraint(equalTo: introView.trailingAnchor, constant: -16),
            welcomeLabel.centerYAnchor.constraint(equalTo: introView.centerYAnchor, constant: -20),
            descLabel.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: welcomeLabel.trailingAnchor),
            descLabel.centerYAnchor.constraint(equalTo: introView.centerYAnchor, constant: 28),
            
            nameField.topAnchor.constraint(equalTo: loginPannel.topAnchor, constant: 16),
            nameField.centerXAnchor.constraint(equalTo: loginPannel.centerXAnchor),
            nameField.leadingAnchor.constraint(equalTo: loginPannel.leadingAnchor, constant: 32),
            nameField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 16),
            passwordField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            passwordField.heightAnchor.constraint(equalTo: nameField.heightAnchor),
            
            termsAgreement.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            termsAgreement.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            termsAgreement.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            termsAgreement.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            loginBtnStack.topAnchor.constraint(equalTo: termsAgreement.bottomAnchor, constant: 16),
            loginBtnStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            loginButton.widthAnchor.constraint(equalToConstant: 110),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            signupButton.widthAnchor.constraint(equalTo: loginButton.widthAnchor),
            signupButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
            
            
            loginBtnStack.bottomAnchor.constraint(equalTo: loginPannel.bottomAnchor, constant: -16),
        ])
    }
}

