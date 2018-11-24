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
    @IBOutlet weak var youLoseLabel: UILabel!
    
    var strPlayerOneEntered = String()
    var strPlayerTwoEntered = String()
    var strArray1 = String()
    var strArray2 = [String]()
    var intArray = [Int]()
    var playeroneStringArray = [String]()
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
    playerOneWord.delegate = self
    playerTwoEnters.delegate = self
  }
}
extension HangmanViewController: UITextFieldDelegate {
    fileprivate func NumberOfGuesses() {
        if !strPlayerOneEntered.lowercased().contains(strPlayerTwoEntered.lowercased()){
            numberOfGuesses -= 1
            switch numberOfGuesses {
            case 7:
                hangmanImage.image = UIImage.init(named: "hang1")
            case 6:
                hangmanImage.image = UIImage.init(named: "hang2")
            case 5:
                hangmanImage.image = UIImage.init(named: "hang3")
            case 4:
                hangmanImage.image = UIImage.init(named: "hang4")
            case 3:
                hangmanImage.image = UIImage.init(named: "hang5")
            case 2:
                hangmanImage.image = UIImage.init(named: "hang6")
            case 1:
                hangmanImage.image = UIImage.init(named: "hang7")
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
        playerOneWord.resignFirstResponder()
        switch textField {
        
        case playerOneWord:
             strPlayerOneEntered = playerOneWord.text ?? "nothing entered"
            playeroneStringArray = Array(repeating: "⏤", count: strPlayerOneEntered.count)//displays the number of letters in the word
             print(playeroneStringArray)
            numberOfDashesDisplay.text = playeroneStringArray.joined(separator: " ") // controls the label
            savedWord = strPlayerOneEntered
      
        case playerTwoEnters:
            playerTwoEnters.resignFirstResponder()
          strPlayerTwoEntered =  playerTwoEnters.text ?? "nothing entered"
          print(strPlayerTwoEntered)
            allGuesses.append(strPlayerTwoEntered.lowercased())
            if allGuesses.contains(strPlayerTwoEntered){
        let playerTwoEnteredCharacter = Character(strPlayerTwoEntered)
            ForLoops(playerTwoEnteredCharacter)
            print(playeroneStringArray)
            numberOfDashesDisplay.text = playeroneStringArray.joined(separator: " ")
            NumberOfGuesses()
            intArray.removeAll()
            }
            print(allGuesses)
        
        default:
            print("Invalid",separator: "")
        }
        if savedWord == playeroneStringArray.joined() {
            hangmanImage.image = UIImage(named: "youWin")
            textField.isEnabled = false
        }
        else if savedWord != playeroneStringArray.joined() && numberOfGuesses == 1 {
            textField.isEnabled = false
            hangmanImage.image = UIImage(named: "youLose")
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
            // make sure it's all of them
            let validCharacterCount = string.distance(from: rangeOfCharactersAllowed.lowerBound, to: rangeOfCharactersAllowed.upperBound)
            return validCharacterCount == string.count &&  restrictCharacterLength(string, range)
        } else  {
            // none of the characters are from the allowed set
            return false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        return limitsUserInputToLettersOnly(string, range)
    }
    }


