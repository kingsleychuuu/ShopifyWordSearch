//
//  WordSearch.swift
//  ShopifyWordSearch
//
//  Created by admin on 5/2/19.
//  Copyright © 2019 Kingsley. All rights reserved.
//

import Foundation

enum PlacementOrientation: CaseIterable {
    case leftToRight
    case rightToLeft
    case upToDown
    case DownToUp
    case topLeftToBottomRight
    case topRightToBottomLeft
    case bottomLeftToTopRight
    case bottomRightToTopLeft
    
    var movementForPlacement: (x: Int, y:Int)  {
        switch self {
        case .leftToRight:
            return (1,0)
        case .rightToLeft:
            return (-1, 0)
        case .upToDown:
            return (0, 1)
        case .DownToUp:
            return (0, -1)
        case .topLeftToBottomRight:
            return (1, 1)
        case .topRightToBottomLeft:
            return (-1, 1)
        case .bottomLeftToTopRight:
            return (1, -1)
        case .bottomRightToTopLeft:
            return (-1, -1)
        }
    }
}

struct Word: Decodable {
    var text: String
}

class Label {
    var letter: Character = " "
}

class WordSearch {
    var words = [Word]()
    var wordsToFind = [Word]()
    var gridSize = 10
    var labels = [[Label]]()
    var placementOrientation = PlacementOrientation.allCases
    
    let allLetters = (65...90).map {Character(Unicode.Scalar($0))} //ascii 65...90 is A... Z
    
    func makeGrid() {
        labels = (0 ..< gridSize).map { _ in
            (0 ..< gridSize).map { _ in
                Label()
            }
        }
        wordsToFind = placeAllWords()
        fillGaps()
        printGrid()
    }
    
    func fillGaps() {
        for row in labels {
            for cell in row {
                if cell.letter == " " {
                    if let randomLetter = allLetters.randomElement() {
                        cell.letter = randomLetter
                    }
                }
            }
        }
    }
    
    func printGrid() {
        for row in labels {
            for cell in row {
                print(cell.letter, terminator: "")
            }
            print(" ")
        }
    }
    
    func labels(fromX x: Int, y: Int, word: String, movement: (x: Int, y: Int)) -> [Label]? {
        var returnValue = [Label]()
        var xPosition = x
        var yPosition = y
        for letter in word {
            let label = labels[xPosition][yPosition]
            if label.letter == " " || label.letter == letter {
                returnValue.append(label)
                xPosition += movement.x
                yPosition += movement.y
            } else {
                return nil
            }
        }
        return returnValue
    }
    
    func canThisWordBePlacedHere(word: String, movement: (x: Int, y: Int)) -> Bool {
        let xLength = (movement.x * (word.count - 1))
        let yLength = (movement.y * (word.count - 1))
        
        
        let rows = (0 ..< gridSize).shuffled()
        let columns = (0 ..< gridSize).shuffled()
        
        
        for row in rows {
            for column in columns {
                let finalXPosition = column + xLength
                let finalYPosition = row + yLength
                
                if finalXPosition >= 0 && finalXPosition < gridSize && finalYPosition >= 0 && finalYPosition < gridSize {
                    if let returnValue = labels(fromX: column, y: row, word: word, movement: movement) {
                        for (index, letter) in word.enumerated() {
                            returnValue[index].letter = letter
                        }
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func placeWord(word: Word) -> Bool {
        let formattedWord = word.text.replacingOccurrences(of: " ", with: "").uppercased()
        return placementOrientation.shuffled().contains {
            canThisWordBePlacedHere(word: formattedWord, movement: $0.movementForPlacement)
        }
    }
    
    func placeAllWords() -> [Word] {
        return words.shuffled().filter(placeWord)
    }
}
