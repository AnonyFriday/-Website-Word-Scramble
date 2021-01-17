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
    
    
    //MARK: Submit the Answer
    func submit(answer: String) {
        game.verifyAnswer(answer: answer) { [weak self](result) in
            guard let self = self else { return }
            switch result {
            case .success(let _):
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            case .failure(let error):
                let errorTitle   = error.getErrorContents().title
                let errorMessage = error.getErrorContents().message
                self.presentErrorAlertController(title: errorTitle, message: errorMessage, buttonTitle: "Ok")
            }
        }
    }
}

