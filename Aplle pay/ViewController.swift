//
//  ViewController.swift
//  Aplle pay
//
//  Created by student on 29.03.2018.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var correctWorldlabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    var listofwords = [
        "Анастасия",
        "Анна",
        "Мария"
    ]
    
    let incorrectMovesAllowed = 7
    
    var totalWins = 0 {
        didSet {
            currentGame.formattedWord = currentGame.word
            newRound(after: 0.5)
        }
    }
    var totalLoses = 0 {
        didSet {
            newRound(after: 0.5)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    func enableButtons(_ enable: Bool, in view: UIView) {
        if view is UIButton {
            (view as! UIButton).isEnabled = enable
        } else {
            for subview in view.subviews {
                enableButtons(enable, in: subview)
            }
        }
        
    }
    
    var currentGame: Game!
    
    func newRound() {
        guard !listofwords.isEmpty else {
            enableButtons(false, in: view)
            updateUI()
            return
        }
        
        let newWord = listofwords.removeFirst().lowercased()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, gusessedLetters: [])
        
        enableButtons(true, in: view)
            updateUI()
    }
    
    func newRound(after delay: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.newRound()
        }
    }
    func updateGameState() {
        if currentGame.incorrectMovesRemaining < 1 {
            totalLoses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        }
        updateUI()
    }
    
    func updateUI() {
        let name = "Tree \(currentGame.incorrectMovesRemaining)"
        imageView.image = UIImage(named: name)
        
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        letters[0] = letters[0].capitalized
        let wordWithSpacing = letters.joined(separator: " ")
        
        correctWorldlabel.text = wordWithSpacing
        
        scoreLabel.text = "Выигрыши: \(totalWins), Проигрыши: \(totalLoses)"
    }
}
