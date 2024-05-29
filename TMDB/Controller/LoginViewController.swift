//
//  ViewController.swift
//  TMDB
//
//  Created by Madhu Babu Adiki on 5/25/24.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: LoginTextField!
    @IBOutlet weak var passwordTextField: LoginTextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
        
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTapped(loginButton)
        return true
    }
    
    @IBAction func loginViaWeb(_ sender: Any) {
        print("login via web tapped")
        TMDBClient.getRequestToken(completionHandler: {
            (success, error) in
            if success {
                print("Request Token generated successfully")
                DispatchQueue.main.async {
                    UIApplication.shared.open(TMDBClient.Endpoints.webAuth.url, options: [:], completionHandler: nil)
                }
            }
        })
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
    print("Login Button Tapped")
        TMDBClient.getRequestToken(completionHandler: handleRequestTokenResponse(success:error:))
    }
    
    func handleRequestTokenResponse(success: Bool, error: Error?) {
        if success {
//            print(TMDBClient.Auth.requestToken)
            DispatchQueue.main.async {
                TMDBClient.login(username: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", completionHandler: self.handleLoginResponse(success:error:))
            }
        }
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        if success {
//            print(TMDBClient.Auth.requestToken)
            TMDBClient.createSession(completionHandler: handleSessionResponse(success:error:))
        } else {
            print("Password is incorrect!")
//            animateIncorrectPassword()
        }
    }
    
    func handleSessionResponse(success: Bool, error: Error?) {
        if success {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
            }
        }
    }
}

