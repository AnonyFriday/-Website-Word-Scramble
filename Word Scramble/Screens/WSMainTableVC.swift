//
//  ViewController.swift
//  Word Scramble
//
//  Created by Vu Kim Duy on 16/1/21.
//

import UIKit

class ViewController: UITableViewController {

    lazy var game = WordScramble()

    override func loadView() {
        super.loadView()
        navigationItem.setRightBarButtonItems(
            [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer)),
             UIBarButtonItem(title: "New game", style: .done, target: self, action: #selector(resetGame))
            ], animated: true)
        tableView.register(WSTableViewCell.self, forCellReuseIdentifier: WSTableViewCell.reusableID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIElements()
    }
    
    //MARK: startGame
    @objc func resetGame() {
        game.getNewGame()
        updateUIElements()
    }
    
    func updateUIElements() {
        title = game.currentWord
        self.tableView.reloadData()
    }
    
    //MARK: Table View Section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.usedWords.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WSTableViewCell.reusableID, for: indexPath) as? WSTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "Word")
        }
        
        cell.textLabel?.text = game.usedWords[indexPath.row]
        print(cell)
        return cell
    }
    
    //MARK: AlertController Section
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Type your guess", message: "Your answer", preferredStyle: .alert)
        
        ac.addTextField()
        let alertAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let self = self, let ac = ac else { return }
            guard let answer = ac.textFields?.first?.text else { return }
            self.submit(answer: answer)
        }
        ac.addAction(alertAction)
        present(ac,animated: true)
    }
    
    
    func submit(answer: String) {
        game.guessWord       = answer.lowercased()
        
        if game.isOriginal(word: game.guessWord)
        {
            if game.isPossible(word: game.guessWord)
            {
                if game.isReal(word: game.guessWord)
                {
                    game.usedWords.insert(game.guessWord, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.tableView.insertRows(at: [indexPath], with: .automatic)
                }
                else
                {
                    presentErrorAlertController(title: "Word not recognised", message: "You can't just make them up, you know!", buttonTitle: "Ok")
                }
            }
            else
            {
                presentErrorAlertController(title: "Word not possible", message: "You can't spell that word from \(game.currentWord.uppercased() )", buttonTitle: "Ok")
            }
        }
        else
        {
            presentErrorAlertController(title: "Word used already", message: "Be more original!", buttonTitle: "Ok")
        }
    }
}

