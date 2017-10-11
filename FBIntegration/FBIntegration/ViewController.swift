//
//  ViewController.swift
//  FBIntegration
//
//  Created by Kavita Gaitonde on 10/10/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FacebookShare

class ViewController: UIViewController, LoginButtonDelegate {

    @IBOutlet weak var shareDialogButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile,  .email, .userFriends  ])
        loginButton.center = view.center
        loginButton.delegate = self
        
        view.addSubview(loginButton)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let accessToken = AccessToken.current {
            // User is logged in, use 'accessToken' here.
            print("User is logged in -- \(accessToken.userId!)")
            self.shareDialogButton.isHidden = true
            
            let content = LinkShareContent(url: URL(string: "https://developers.facebook.com")!)
            let shareButton = ShareButton<LinkShareContent>()
            shareButton.content = content;
            shareButton.frame.origin.x = self.view.center.x;
            shareButton.frame.origin.y = self.view.center.y + 50;
            self.view.addSubview(shareButton);
        } else {
            print("User is NOT logged in ")
            self.shareDialogButton.isHidden = true
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print("Login complete.....")
    }
    
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("Logout complete.....")
    }
    
    @IBAction func shareDialogAction(_ sender: Any) {
        let content = LinkShareContent(url: URL(string: "https://developers.facebook.com")!)
        let shareDialog = ShareDialog(content: content)
        shareDialog.mode = .native
        shareDialog.failsOnInvalidData = true
        shareDialog.completion = { result in
            // Handle share results
            print (result)
        }
        try! shareDialog.show()
    }
    
}

