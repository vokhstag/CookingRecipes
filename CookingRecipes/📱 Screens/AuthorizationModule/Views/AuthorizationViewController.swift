//
//  ViewController.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 02.10.2021.
//

import UIKit

class AuthorizationViewController: UIViewController {
    // MARK: - DI
    var presenter: AuthorizationPresenterProtocol!
    // MARK: - UI
    let stackView = UIStackView()
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    lazy var scrollContentView: UIView = {
        let view = UIView()
     //  view = UIImage.Images.backroundImage
        self.scrollView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.Images.backroundImage
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var funCookingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.CustomFonts.title1
        label.text = "Fun Cooking"
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        self.scrollContentView.addSubview(label)
        return label
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.CustomFonts.subhead1
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.numberOfLines = 1
        self.scrollContentView.addSubview(label)
        return label
    }()
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Name"
        textField.font = UIFont.CustomFonts.subhead2
        textField.textContentType = .password
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        self.scrollContentView.addSubview(textField)
        return textField
    }()
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.CustomFonts.subhead1
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login"
        label.numberOfLines = 1
        self.scrollContentView.addSubview(label)
        return label
    }()
    lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Login"
        textField.font = UIFont.CustomFonts.subhead2
        textField.textContentType = .nickname
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        self.scrollContentView.addSubview(textField)
        return textField
    }()
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.CustomFonts.subhead1
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Password"
        self.scrollContentView.addSubview(label)
        return label
    }()
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Password"
        textField.font = UIFont.CustomFonts.subhead2
        textField.backgroundColor = .white
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        self.scrollContentView.addSubview(textField)
        return textField
    }()
    lazy var confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.CustomFonts.subhead1
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Confirm Password"
        self.scrollContentView.addSubview(label)
        return label
    }()
    lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Confirm Password"
        textField.font = UIFont.CustomFonts.subhead2
        textField.backgroundColor = .white
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        self.scrollContentView.addSubview(textField)
        return textField
    }()
    lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 20
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.CustomFonts.title2
        button.backgroundColor = .brandColor
        button.translatesAutoresizingMaskIntoConstraints = false
        self.scrollContentView.addSubview(button)
        button.addTarget(self, action: #selector(registrationTapped), for: .touchUpInside)
        return button
    }()
    // MARK: - Constructor
    deinit {
        removeKeyboardNotifications()
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerForKeyboardNotifications()
    }
}

// MARK: - AuthorizationViewProtocol
extension AuthorizationViewController: AuthorizationViewProtocol {
    func succes() {
        self.dismiss(animated: true, completion: nil)
    }
    func failure(errorDescription: String) {
        showAlert(message: errorDescription)
    }
}

// MARK: Setup
private extension AuthorizationViewController {
    func setup() {
        setupBackgroundImage()
        setupScrollView()
        setupfunCookingLabel()
        setupUI()
        setupSignUpButton()
        addTapRecognizerAtView()
        self.navigationController?.navigationBar.isHidden = true
    }
    func setupBackgroundImage() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: scrollContentView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    func setupScrollView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContentView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            scrollContentView.heightAnchor.constraint(greaterThanOrEqualTo: self.scrollView.heightAnchor)
        ])
        let yCenter = scrollContentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        let xCenter = scrollContentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        yCenter.priority = UILayoutPriority(rawValue: 750)
        xCenter.priority = UILayoutPriority(rawValue: 750)
        yCenter.isActive = true
        xCenter.isActive = true
    }
    func setupfunCookingLabel() {
        NSLayoutConstraint.activate([
            funCookingLabel.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 90),
            funCookingLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 12),
            funCookingLabel.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -12)
        ])
    }
    func setupUI() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(greaterThanOrEqualTo: funCookingLabel.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            confirmPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmPasswordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmPasswordLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    func setupSignUpButton() {
        NSLayoutConstraint.activate([
            logInButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 40),
            logInButton.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 60),
            logInButton.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -60),
            logInButton.heightAnchor.constraint(equalToConstant: 40),
            logInButton.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor, constant: -80)
        ])
    }
    func addTapRecognizerAtView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
}

// MARK: - Private methods
private extension AuthorizationViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // MARK: - Actions
    @objc func registrationTapped() {
        guard let login = loginTextField.text, login != "" else {
            showAlert(message: "login не может быть пустым")
            return
        }
        guard let name = nameTextField.text, name != "" else {
            showAlert(message: "Поле Name не может быть пустым")
            return
        }
        guard let password = passwordTextField.text, confirmPasswordTextField.text == password else {
            showAlert(message: "Пароли не совпадают")
            return
        }
        guard password != "", password != " " else {
            showAlert(message: "Пароль не может быть пустым")
            return
        }
        presenter.createNewUser(name: name, login: login, password: password)
    }
    @objc func kbWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
        guard let keyboardSize = kbSize as? CGRect else { return }
        if scrollView.contentOffset == CGPoint.zero {
            scrollView.contentOffset = CGPoint(x: 0, y: (keyboardSize.height - 70))
        }
    }
    @objc func kbWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }
    @objc func hideKeyboard() {
        nameTextField.resignFirstResponder()
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
    }
}
