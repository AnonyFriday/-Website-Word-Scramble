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
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer)), animated: true)
        tableView.register(WSTableViewCell.self, forCellReuseIdentifier: WSTableViewCell.reusableID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
        
    }

    
    //MARK: startGame
    func startGame() {
        title = game.getRandomWord()
        game.usedWords.removeAll(keepingCapacity: true)
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
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {[weak ac, weak self] _ in
            guard let self = self, let ac = ac else { return }
            guard let answer = ac.textFields?[0].text else {
                return
            }
            self.submit(answer: answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(answer: String) {
        let lowerCasedAnswer = answer.lowercased()
        game.usedWords.insert(lowerCasedAnswer, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
}

