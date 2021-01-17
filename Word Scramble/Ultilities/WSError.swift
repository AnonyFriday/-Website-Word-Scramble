//
//  WSError.swift
//  Word Scramble
//
//  Created by Vu Kim Duy on 16/1/21.
//

import Foundation

enum WSAlertError: Error{
    case isOriginal
    case isPossible(String)
    case isReal
    case isLessThanThreeLetters
        
    func getErrorContents() -> (title: String, message: String) {
        switch self {
        case .isLessThanThreeLetters:
            return ("Invalid Length", "Your guessed word's length has to be greater than three")
        case .isOriginal:
            return ("Word used already","Be more original!")
        case .isPossible(let currentWord):
            return ("Word not possible","You can't spell that word from the current word \(currentWord)")
        case .isReal:
            return ("Word not recognised","You can't just make them up, you know!")
        }
    }
}

enum WSPrintError: String, Error {
    case unableToLoadFileFromBundle = "Unable to load the file from the bundle"
}


