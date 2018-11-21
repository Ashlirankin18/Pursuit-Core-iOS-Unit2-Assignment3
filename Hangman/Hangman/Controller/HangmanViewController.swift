//
//  ViewController.swift
//  Hangman
//
//  Created by Alex Paul on 11/19/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit


class HangmanViewController: UIViewController {
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var playerOneWord: UITextField!
    @IBOutlet weak var playerTwoEnters: UITextField!
    @IBOutlet weak var numberOfDashesDisplay: UILabel!
    var playerOneEnterWordArray = GameState.playerOneDashesArray
    var playOneWord = GameState.playerOneStringArray
    var playerOneEnterString = String()
    var playerTwoEnterString = String()
    override func viewDidLoad() {
    super.viewDidLoad()
    playerOneWord.delegate = self
    playerTwoEnters.delegate = self
  }


    
}
extension HangmanViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField {
        case playerOneWord:
             playerOneEnterString = playerOneWord.text ?? "nothing entered"
             playOneWord = [playerOneEnterString]
             print(playOneWord)
            let playeroneString = String(repeatElement("⏤", count: playerOneEnterString.count))
            print(playeroneString)
            numberOfDashesDisplay.text = playeroneString
            
        case playerTwoEnters:
           playerTwoEnterString =  playerTwoEnters.text ?? "nothing entered"
           print(playerTwoEnterString)
            
        default:
            print("Invalid",separator: "")
        }
        
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
  //        print(textField.text ?? "")
//        playerOneEnterWordArray = [textField.text ?? ""]
//        print(playerOneEnterWordArray)
        return true
    }
}
