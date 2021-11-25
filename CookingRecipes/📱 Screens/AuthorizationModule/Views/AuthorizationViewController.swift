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
        scrollView.backgroundColor = #colorLiteral(red: 0.8618097175, green: 0.8631474743, blue: 0.8241919949, alpha: 1)
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
        self.scrollContentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.numberOfLines = 1
        return label
    }()
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Name"
        textField.backgroundColor = .white
        textField.textContentType = .nickname
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        return textField
    }()
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login"
        label.numberOfLines = 1
        return label
    }()
    lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Login"
        textField.textContentType = .nickname
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        return textField
    }()
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Password"
        return label
    }()
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = .white
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        return textField
    }()
    lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirm Password"
        textField.backgroundColor = .white
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        return textField
    }()
    lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вход", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
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
        setupScrollView()
        setupStackView()
        setupSubviews()
        addTapRecognizerAtView()
        self.navigationController?.navigationBar.isHidden = true
    }
    func addTapRecognizerAtView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    func setupStackView() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        scrollContentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(loginLabel)
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordLabel)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(confirmPasswordTextField)
        let margins = scrollContentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: scrollContentView.centerYAnchor, constant: -200)
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
            scrollContentView.heightAnchor.constraint(greaterThanOrEqualTo: self.view.heightAnchor)
        ])
        let yCenter = scrollContentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        let xCenter = scrollContentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        yCenter.priority = UILayoutPriority(rawValue: 750)
        xCenter.priority = UILayoutPriority(rawValue: 750)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: scrollContentView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    func setupSubviews() {
        NSLayoutConstraint.activate([
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            logInButton.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 40),
            logInButton.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -40),
            logInButton.heightAnchor.constraint(equalToConstant: 48),
            logInButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -400)
        ])
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameTextField.heightAnchor.constraint(equalToConstant: 48),
            loginLabel.heightAnchor.constraint(equalToConstant: 30),
            passwordLabel.heightAnchor.constraint(equalToConstant: 30),
            loginTextField.heightAnchor.constraint(equalToConstant: 48),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
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
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardSize.height)
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
