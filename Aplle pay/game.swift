//
//  Game.swift
//  Aplle pay
//
//  Created by student on 05.04.2018.
//  Copyright © 2018 student. All rights reserved.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var gusessedLetters: [Character]
    
    var formattedWord: String {
        get {
            var guessedWord = ""
            for letter in word {
                if gusessedLetters.contains(letter) {
                    guessedWord += "\(letter)"
                } else {
                    guessedWord += "_"
                }
            }
            
            return guessedWord
        }
        set {
            for letter in newValue {
                playerGuessed(letter: letter)
            }
        }
    }
    
    
    mutating func playerGuessed(letter: Character) {
        gusessedLetters.append(letter)
        
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
}
