//
//  HangmanBrain.swift
//  Hangman
//
//  Created by Ashli Rankin on 11/20/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

 struct GameState {
  var isGameOver: Bool
    static var numberOfGuesses = 7
    static var playerOneDashesArray: [String] = []
    static var playerOneStringArray:[String] = []
    static var playerTwoRight:[String] = []
    static var savedWord = String()
    static var playerTwoEnteredWordArr = [String]()
    static var allGuesses = [String]()
}
var savedWord = GameState.savedWord
var playerTwoArray = GameState.playerTwoEnteredWordArr
var numberOfGuesses = GameState.numberOfGuesses
var allGuesses = GameState.allGuesses
