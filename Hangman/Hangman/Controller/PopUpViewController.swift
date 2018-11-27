//
//  PopUpViewController.swift
//  Hangman
//
//  Created by Ashli Rankin on 11/27/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel()
        seguetest()
    }
    
    @IBAction func dismissButton(_ sender: UIButton) {
  
        dismiss(animated: true, completion: nil)
    
    }
    func displayLabel(){
        welcomeLabel.text =
        """
        Welcome to Hangman:
        
        There are two ways to play the game
        
        1: Multiplayer - Click Either image to begin a multiplayer game
        
        2: Single Player - Click the single player button to player against the computer and challange youself
        
        TAP TO DISMISS
        """
    }
    func seguetest() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "secondSegue") as? HomePage
    else{return}
    present( vc, animated: true, completion: nil)
    vc.modalPresentationStyle = .overCurrentContext
        
}
}
