//
//  WordScramble.swift
//  Word Scramble
//
//  Created by Vu Kim Duy on 16/1/21.
//

import UIKit

class WordScramble {
    var allWords    = [String]()
    var usedWords   = [String]()
    var currentWord : String!
    var handleError : ((_ title: String, _ message: String) -> Void)?
    var guessWord   : String!
    
    init() {
        WordScramble.getWordsFromFile(for: "start", with: "txt", completed: { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print(error)
            case .success(let words):
                self.allWords = words
                self.currentWord   = self.allWords.randomElement()
            }
        })
    }
    
    
    
    
    static func getWordsFromFile(for resource: String, with fileExtension: String, completed: @escaping (Result<[String],WSError>) -> Void) {
        
        if let contentWordsURL        = Bundle.main.url(forResource: resource, withExtension: fileExtension)
        {
            guard let contentOfFile   = try? String(contentsOf: contentWordsURL) else {
                completed(.failure(.unableToLoadFileFromBundle))
                return
            }
            completed(.success(contentOfFile.components(separatedBy: "\n")))
        }
    }
    
    func getRandomWord() -> String {
        let randomIndex = Int(arc4random_uniform(UInt32(allWords.count)))
        return !allWords.isEmpty ? allWords[randomIndex] : "?"
    }
    
    //MARK: Check if it's possible
    func isPossible(word: String) -> Bool {
        guard !word.isEmpty, var tempAnswer = currentWord else { return false }
        
        for letter in word {
            if let position = tempAnswer.firstIndex(of: letter) {
                tempAnswer.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    //MARK: Check if it's original
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    //MARK: Check if it's misspelleds
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let misspelledRange = checker.rangeOfMisspelledWord(in: word,
                                                            range: NSRange(location: 0, length: word.utf16.count),
                                                            startingAt: 0,
                                                            wrap: true,
                                                            language: "en_US")
        return misspelledRange.location == NSNotFound
    }
    
}

