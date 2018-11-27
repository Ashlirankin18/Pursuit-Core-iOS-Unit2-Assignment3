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
    @IBOutlet weak var playAgainButton: UIButton!
    
    
    var strPlayerOneEntered = String()
    var strPlayerTwoEntered = String()
    var intArray = [Int]()
    var playeroneStringArray = [String]()
    var stickImages = GameState.hangmanStickImages
    var animatedImages = GameState.hangmanAnimatedImages
    var imagesToBeUsed = [UIImage]()
    var savedWordArray = [String]()
   
    override func viewDidLoad() {
    super.viewDidLoad()
    playerOneWord.delegate = self
    playerTwoEnters.delegate = self
    checksIftheResponderResigned()
  }
    
    @IBAction func playAgainButton(_ sender: UIButton) {
        
        playerOneWord.isUserInteractionEnabled = true
        playerTwoEnters.isUserInteractionEnabled = true
        playerTwoEnters.isEnabled = true
        playerOneWord.isEnabled = true
        savedWord = ""
        playerOneWord.text = nil
        numberOfDashesDisplay.text = nil
        playeroneStringArray.removeAll()
        playerTwoEnters.text = ""
        hangmanImage.image = UIImage(named: "header")
        numberOfGuesses = 8
        
    }
    func loadCorrectHangmanImage (){
        if !stickImages.isEmpty {
            imagesToBeUsed = stickImages
        } else {
            imagesToBeUsed = animatedImages
        }
    }
    func checksIftheResponderResigned() {
        if !playerOneWord.resignFirstResponder(){
            playerTwoEnters.isEnabled = false
        }
    }
}

extension HangmanViewController: UITextFieldDelegate {
    fileprivate func NumberOfGuesses() {
        if !strPlayerOneEntered.lowercased().contains(strPlayerTwoEntered.lowercased()){
            numberOfGuesses -= 1
            loadCorrectHangmanImage()
            switch numberOfGuesses {
            case 7 :
                hangmanImage.image = imagesToBeUsed[6]
            case 6:
                hangmanImage.image = imagesToBeUsed[5]
            case 5:
                hangmanImage.image = imagesToBeUsed[4]
            case 4:
                hangmanImage.image = imagesToBeUsed[3]
            case 3:
                hangmanImage.image = imagesToBeUsed[2]
            case 2:
                hangmanImage.image = imagesToBeUsed[1]
            case 1:
                hangmanImage.image = imagesToBeUsed[0]
                savedWord = ""
            default:
                print("b")
               
            }
        }
    }
    
    fileprivate func ForLoops(_ playerTwoEnteredCharacter: Character) {
        for (index,letter) in strPlayerOneEntered.enumerated(){
            if letter == playerTwoEnteredCharacter {
                intArray.append(index)
            }
        }
        
        for element in intArray {
            playeroneStringArray[element] = strPlayerTwoEntered
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case playerOneWord:
            playerOneWord.resignFirstResponder()
            playerTwoEnters.isEnabled = true
             strPlayerOneEntered = playerOneWord.text ?? "nothing entered"
            playeroneStringArray = Array(repeating: "⏤", count: strPlayerOneEntered.count)
            numberOfDashesDisplay.text = playeroneStringArray.joined(separator: " ")
            savedWord = strPlayerOneEntered
           savedWordArray = [savedWord]
       playerOneWord.isUserInteractionEnabled = true
           
        case playerTwoEnters:
            playerTwoEnters.resignFirstResponder()
            strPlayerTwoEntered =  playerTwoEnters.text ?? "nothing entered"
            guard strPlayerTwoEntered != "" else {return true}
            allGuesses.append(strPlayerTwoEntered.lowercased())
            if allGuesses.contains(strPlayerTwoEntered){
                let playerTwoEnteredCharacter = Character(strPlayerTwoEntered)
            ForLoops(playerTwoEnteredCharacter)
            numberOfDashesDisplay.text = playeroneStringArray.joined(separator: " ")
            NumberOfGuesses()
            intArray.removeAll()
            }
        
        
        default:
            print("Invalid",separator: "")
        }
        
        if savedWord == playeroneStringArray.joined() && playerOneWord.text != "" {
            hangmanImage.image = UIImage(named: "youWin")
            textField.isEnabled = false
            savedWord = ""
        }
        else if savedWord != playeroneStringArray.joined() && numberOfGuesses == 1 {
            textField.isEnabled = false
            hangmanImage.image = UIImage(named: "youLose")
            hangmanImage.image = UIImage(named: "youLose")
            numberOfDashesDisplay.text = "the random word was \(savedWordArray.joined(separator: " "))"
            savedWord = ""
        }
        
     return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        playerTwoEnters.clearsOnBeginEditing = (playerTwoEnters.text != nil)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {

        return true
    }
    
    fileprivate func restrictCharacterLength(_ string: String, _ range: NSRange) -> Bool {
        let characterCountLimit = 1
        let startingLength = playerTwoEnters.text?.count ?? 0
        let lengthToAdd = string.count
        let lengthToReplace = range.length
        let newLength = startingLength + lengthToAdd - lengthToReplace
       
        return newLength <= characterCountLimit
    }
    
    fileprivate func limitsUserInputToLettersOnly(_ string: String, _ range: NSRange) -> Bool {
        let charactersAllowed = NSCharacterSet.letters
        if let rangeOfCharactersAllowed = string.rangeOfCharacter(from: charactersAllowed, options: .caseInsensitive) {
            let validCharacterCount = string.distance(from: rangeOfCharactersAllowed.lowerBound, to: rangeOfCharactersAllowed.upperBound)
            return validCharacterCount == string.count &&  restrictCharacterLength(string, range)
        } else  {
           
            return false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        return limitsUserInputToLettersOnly(string, range)
    }
    }
