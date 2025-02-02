//
//  SignUpVC.swift
//  FakeShop
//
//  Created by 이태형 on 12/19/24.
//

import UIKit
//import AnyFormatKit

class SignUpVC: UIViewController {
    
    private let scrollView: UIScrollView = UIScrollView()
    private let contentScrollView: UIView = UIView()
    
    private let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    private let idTextField: UITextField = UITextField() //username
    private let idGuideLabel: UILabel = UILabel()
    private let pwTextField: UITextField = UITextField()
    private let pwGuideLabel: UILabel = UILabel()
    private let pwConfirmTextField: UITextField = UITextField()
    private let pwConfirmGuideLabel: UILabel = UILabel()
    private let firstnameTextField: UITextField = UITextField()
    private let firstNameGuideLabel: UILabel = UILabel()
    private let lastnameTextField: UITextField = UITextField()
    private let lastNameGuideLabel: UILabel = UILabel()
    private let emailTextField: UITextField = UITextField()
    private let emailGuideLabel: UILabel = UILabel()
    private let addressTextField: UITextField = UITextField()
    private let addressGuideLabel: UILabel = UILabel()
    private let phoneTextField: UITextField = UITextField()
    private let phoneGuideLabel: UILabel = UILabel()
    private let testMessage: UILabel = UILabel()
    private let signUpButton: UIButton = UIButton()
    
    private let vm: SignUpVM = SignUpVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setViewConfig()
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}

#Preview("SignUpView"){
    return UINavigationController(rootViewController: SignUpVC())
}

//MARK: - Function
extension SignUpVC{
    @objc func didTapGesture(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        guard let currentTextField = UIResponder.currentResponder as? UITextField else { return }
        scrollView.contentInset.bottom = keyboardFrame.size.height
        scrollView.scrollRectToVisible(currentTextField.frame, animated: true)
    }
    
    
    @objc func keyboardWillHide(_ sender: Notification){
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc func didTapSignUpButton(_ sender: UIButton){
        //isValidation
        let allTextFields: [UITextField] = [idTextField, pwTextField, pwConfirmTextField, firstnameTextField, lastnameTextField, emailTextField, addressTextField, phoneTextField]
        let allTextFieldType: [TextFieldType] = [.id, .password, .confirmPassword, .firstName, .lastName, .email, .address, .phone]
        guard let pwtxt: String = pwTextField.text else{
            print("pwtxt Fail")
            return
        }
        switch vm.isValidSignUp(allTextFields, allTextFieldType, pwtxt){
        case .success(_):
            //SignUpAPI -> result: Error 404
//            let datas:[String] = allTextFields.filter{$0 != pwConfirmTextField}.map{$0.text!}
//            SignUpRequest.signUp(datas){res in
//                switch res{
//                case .success(let data):
//                    print(data)
//                    self.navigationController?.popViewController(animated: true)
//                case .failure(let err):
//                    self.present(UIAlertController.messageAlert(title: "Network Error", message: err.localizedDescription, completion: nil), animated: true)
//                }
//            }
            print("Sign Up Validation Success..")
            self.navigationController?.popViewController(animated: true)
        case .failure(let error):
            present(UIAlertController.messageAlert(title: nil, message: error.validMessage, completion: nil), animated: true)
        }
    }
}

//MARK: - SETUP
extension SignUpVC{
    private func setViewConfig(){
        setNavigationBar()
        setAttribute()
        setUI()
    }
    
    private func setNavigationBar(){
        self.title = "회원가입"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            .foregroundColor : UIColor.white,
            .font : UIFont.boldSystemFont(ofSize: 22)
        ]
        appearance.backgroundColor = UIColor.primary
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func setAttribute(){
        view.backgroundColor = .white
        
        tapGesture.addTarget(self, action: #selector(didTapGesture(_:)))
        contentScrollView.addGestureRecognizer(tapGesture)
        
        [idTextField, pwTextField, pwConfirmTextField, firstnameTextField, lastnameTextField, emailTextField, addressTextField, phoneTextField].forEach{
            $0.delegate = self
        }
        [pwTextField, pwConfirmTextField].forEach{
            $0.isSecureTextEntry = true
            $0.textContentType = .oneTimeCode
        }
        emailTextField.keyboardType = .emailAddress
        phoneTextField.keyboardType = .numberPad
        
        
        [testMessage].forEach{
            $0.text = "실제로 회원가입이 이뤄지지 않습니다."
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .gray
        }
        
        [signUpButton].forEach{
            $0.setTitle("회원가입", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .primary
            $0.layer.cornerRadius = 20
            $0.addTarget(self, action: #selector(didTapSignUpButton(_:)), for: .touchUpInside)
        }
        
    }
    
    private func setUI(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentScrollView)
        [scrollView, contentScrollView].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let textFieldStack: UIStackView = {
            let stackView: UIStackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .equalSpacing
            stackView.spacing = 8
            let textFields: [UITextField] = [idTextField, pwTextField, pwConfirmTextField, firstnameTextField, lastnameTextField, emailTextField, addressTextField, phoneTextField]
            let guideLabels: [UILabel] = [idGuideLabel, pwGuideLabel, pwConfirmGuideLabel, firstNameGuideLabel, lastNameGuideLabel, emailGuideLabel, addressGuideLabel, phoneGuideLabel]
            if textFields.count == TextFieldType.allCases.count - 1 {
                for idx in 0..<textFields.count{
                    stackView.addArrangedSubview(TextFieldRow(TextFieldType(rawValue: idx) ?? TextFieldType.error, textFields[idx], guideLabels[idx]))
                }
            }
            return stackView
        }()
        contentScrollView.addSubview(textFieldStack)
        textFieldStack.translatesAutoresizingMaskIntoConstraints = false
        
        [testMessage, signUpButton].forEach{
            contentScrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentScrollView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            textFieldStack.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: 10),
            textFieldStack.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            textFieldStack.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            
            testMessage.topAnchor.constraint(equalTo: textFieldStack.bottomAnchor, constant: 20),
            testMessage.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor),
            testMessage.leadingAnchor.constraint(greaterThanOrEqualTo: contentScrollView.leadingAnchor, constant: 20),
            
            signUpButton.topAnchor.constraint(equalTo: testMessage.bottomAnchor, constant: 8),
            signUpButton.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 100),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
//            signUpButton.leadingAnchor.constraint(greaterThanOrEqualTo: contentScrollView.leadingAnchor, constant: 20),
            signUpButton.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant: -30),
        ])
    }
}


//MARK: - DD
extension SignUpVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case idTextField:
            pwTextField.becomeFirstResponder()
        case pwTextField:
            pwConfirmTextField.becomeFirstResponder()
        case pwConfirmTextField:
            firstnameTextField.becomeFirstResponder()
        case firstnameTextField:
            lastnameTextField.becomeFirstResponder()
        case lastnameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            addressTextField.becomeFirstResponder()
        case addressTextField:
            phoneTextField.becomeFirstResponder()
//        case phoneTextField:
        default:
            return false
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField{
            case idTextField: idGuideLabel.text = vm.guideMessageForValid(textField, .id, string)
            case pwTextField:
                pwGuideLabel.text = vm.guideMessageForValid(textField, .password, string)
                guard let pw: String = pwTextField.text else{return true}
                pwConfirmGuideLabel.text = vm.guideMessageForValid(textField, .confirmPassword, string, pw)
            case pwConfirmTextField:
                guard let pw: String = pwTextField.text else{return true}
                pwConfirmGuideLabel.text = vm.guideMessageForValid(textField, .confirmPassword, string, pw)
            case firstnameTextField: firstNameGuideLabel.text = vm.guideMessageForValid(textField, .firstName, string)
            case lastnameTextField: lastNameGuideLabel.text = vm.guideMessageForValid(textField, .lastName, string)
            case emailTextField: emailGuideLabel.text = vm.guideMessageForValid(textField, .email, string)
            case addressTextField: addressGuideLabel.text = vm.guideMessageForValid(textField, .address, string)
            case phoneTextField:
                guard let text = textField.text else{return true}
                if string == "" {
                    phoneGuideLabel.text = vm.guideMessageForValid(textField, .phone, string)
                    if text.count == 5 || text.count == 10 {
                        textField.text?.removeLast()
                    }
                    return true
                } else {
                    guard let _ = Int(string) else{return false}
                    guard text.count < 13 else{return false}
                    phoneGuideLabel.text = vm.guideMessageForValid(textField, .phone, string)
                    if text.count == 3 || text.count == 8 {
                        textField.text?.append("-")
                    }
                    return true
                }
            default: return true
        }
        return true
    }
}

