//
//  WordScramble.swift
//  Word Scramble
//
//  Created by Vu Kim Duy on 16/1/21.
//

import Foundation

class WordScramble {
    var allWords    = [String]()
    var usedWords   = [String]()
    
    init() {
        WordScramble.getWordsFromFile(for: "start", with: "txt", completed: { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print(error)
            case .success(let words):
                self.allWords = words
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
    
}
