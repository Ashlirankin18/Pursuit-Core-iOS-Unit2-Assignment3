//
//  SinglePlayerGame.swift
//  Hangman
//
//  Created by Ashli Rankin on 11/23/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class SinglePlayerGame: UIViewController {
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var dashesDisplay: UILabel!
    @IBOutlet weak var playerInputField: UITextField!
    @IBOutlet weak var playAgain: UIButton!
    @IBOutlet weak var categoryDisplay: UILabel!
    var gamePlayData = [String]()
    var gameData = HangmanWordS.catogory
    var randomWordArray = [String]()
    var matrixOfWords = [[String]]()
    var category = String()
    var words = [String]()
    var playerGuessesWord = String()
    var randomWord = String()
    var intArray = [Int]()
    var savedWordArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        playerInputField.delegate = self
        checksForRowTitle()
    }
    func checksForRowTitle(){
        guard category == category else {return}
        if category == "Christmas"{
            categoryDisplay.text = "You chose: \(category)"
            words = matrixOfWords[0]
        }else if category == "Technology"{
            categoryDisplay.text = "You chose: \(category)"
            words = matrixOfWords[2]
        }else if category == "Random"{
             categoryDisplay.text = "You chose: \(category)"
            words = matrixOfWords[1]
        }else if category == "Countries"{
             categoryDisplay.text = "You chose: \(category)"
            words = matrixOfWords[3]
        }
        guard let word =  words.randomElement() else {return}
        randomWord = word.lowercased()
        savedWord = randomWord.lowercased()
        savedWordArray = [savedWord]
        randomWordArray = Array(repeating: "⏤", count: randomWord.count )
        dashesDisplay.text = randomWordArray.joined(separator: " ")
        

}
    @IBAction func playAgainButton(_ sender: UIButton) {
    hangmanImage.image = UIImage(named: "intropic")
        playerInputField.isEnabled = true
        savedWord = randomWord
        numberOfGuesses = 8
        randomWordArray.removeAll()
        savedWordArray.removeAll()
        guard let word =  words.randomElement() else {return}
        randomWord = word.lowercased()
        savedWord = randomWord.lowercased()
        randomWordArray = Array(repeating: "⏤", count: randomWord.count )
        dashesDisplay.text = randomWordArray.joined(separator: " ")
        
    }
    
    
}

extension SinglePlayerGame: UITextFieldDelegate{
    fileprivate func NumberOfGuesses() {
        if !randomWord.lowercased().contains(playerGuessesWord.lowercased()){
            numberOfGuesses -= 1
            
            switch numberOfGuesses {
            case 7 :
                hangmanImage.image = UIImage(named: "hang1")
            case 6:
                hangmanImage.image = UIImage(named: "hang2")
            case 5:
                hangmanImage.image = UIImage(named: "hang3")
            case 4:
                hangmanImage.image = UIImage(named: "hang4")
            case 3:
                hangmanImage.image = UIImage(named: "hang5")
            case 2:
                hangmanImage.image = UIImage(named: "hang6")
            case 1:
                hangmanImage.image = UIImage(named: "hang7")
                savedWord = ""
            default:
                print("b")
                
            }
        }
    }
    
    fileprivate func ForLoops(_ playerTwoEnteredCharacter: Character) {
        for (index,letter) in randomWord.enumerated(){
            if letter == playerTwoEnteredCharacter {
                intArray.append(index)
            }
        }
        
        for element in intArray {
            randomWordArray[element] = playerGuessesWord
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        playerInputField.resignFirstResponder()
        playerGuessesWord = playerInputField.text ?? "nothing entered"
        guard playerGuessesWord != "" else {return true}
        allGuesses.append(playerGuessesWord.lowercased())
        print(allGuesses)
        
        if randomWord.lowercased().contains(playerGuessesWord.lowercased()){
            let playerTwoEnteredCharacter = Character(playerGuessesWord)
                ForLoops(playerTwoEnteredCharacter)
                dashesDisplay.text = randomWordArray.joined(separator: " ")
                intArray.removeAll()
        }
        else{
            NumberOfGuesses()
        }

        if savedWord == randomWordArray.joined() {
            hangmanImage.image = UIImage(named: "youWin")
            playerInputField.isEnabled = false
            savedWord = ""
        }
        else if savedWord != randomWordArray.joined() && numberOfGuesses == 1 {
            playerInputField.isEnabled = false
            hangmanImage.image = UIImage(named: "youLose")
            dashesDisplay.text = "the random word was \(savedWordArray.joined(separator: " "))"
            savedWord = ""
        }
        
        return true
    }


func textFieldDidEndEditing(_ textField: UITextField) {
    playerInputField.clearsOnBeginEditing = (playerInputField.text != nil)
}

func textFieldShouldClear(_ textField: UITextField) -> Bool {
    
    return true
}

    
fileprivate func restrictsCharacterLength(_ textField: UITextField, _ string: String, _ range: NSRange) -> Bool {
    let characterCountLimit = 1
    let startingLength = playerInputField.text?.count ?? 0
    let lengthToAdd = string.count
    let lengthToReplace = range.length
    let newLength = startingLength + lengthToAdd - lengthToReplace
    
    return newLength <= characterCountLimit
}

func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let charactersAllowed = NSCharacterSet.letters
    if let rangeOfCharactersAllowed = string.rangeOfCharacter(from: charactersAllowed, options: .caseInsensitive) {
        let validCharacterCount = string.distance(from: rangeOfCharactersAllowed.lowerBound, to: rangeOfCharactersAllowed.upperBound)
        return validCharacterCount == string.count && restrictsCharacterLength(textField, string, range)}
    else {
        return false
    }
    
    }


}




