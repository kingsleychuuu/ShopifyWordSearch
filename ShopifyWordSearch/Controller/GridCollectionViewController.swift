//
//  GridCollectionViewController.swift
//  ShopifyWordSearch
//
//  Created by admin on 5/2/19.
//  Copyright © 2019 Kingsley. All rights reserved.
//

import UIKit

class GridCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let wordSearch = WordSearch()
    var wordsToFind = [Word]()
    var validWordIndexPath = [IndexPath]()
    var footerIndexPath = IndexPath()
    var currentWord = String()
    var confettiOn = Bool()
    var score = 0
    let cellID = "cellID"
    let footerID = "footerID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGridCollectionView()
        retrieveWordsFromJSON()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetGrid))
        title = "W O R D S E A R C H"
    }
    
    func setupGridCollectionView() {
        collectionView.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(GridCollectionViewFooter.self, forCellWithReuseIdentifier: footerID)
        collectionView?.backgroundColor = .black
    }
    
    func retrieveWordsFromJSON() {
        if let path = Bundle.main.url(forResource: "WordsToSearch", withExtension: "json") {
            let contents = try! Data(contentsOf: path)
            let words = try! JSONDecoder().decode([Word].self, from: contents)
            self.wordSearch.words = words
            self.wordSearch.makeGrid()
            self.wordsToFind = self.wordSearch.wordsToFind
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return wordSearch.labels.count+1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section >= wordSearch.labels.count {
            return 1
        } else {
            return wordSearch.labels[section].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section >= wordSearch.labels.count {
            return CGSize(width: self.view.frame.width, height: self.collectionView.frame.height - self.collectionView.frame.width - self.collectionView.safeAreaInsets.top - self.collectionView.safeAreaInsets.bottom)
        } else {
            return CGSize(width: self.view.frame.width/10, height: self.view.frame.width/10)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section >= wordSearch.labels.count {
            let view = collectionView.dequeueReusableCell(withReuseIdentifier: footerID, for: indexPath) as! GridCollectionViewFooter
            view.scoreLabel.text = "Score: \(score)"
            view.remainingWordsCountLabel.text = "Remaining: \(wordsToFind.count)"
            view.remainingWordsLabel.text = ""
            for word in wordsToFind {
                view.remainingWordsLabel.text?.append("\(word.text) \n")
            }
            footerIndexPath = indexPath
            return view
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! GridCollectionViewCell
            cell.textLabelView.text = String(wordSearch.labels[indexPath.section][indexPath.item].letter)
            if score != 0 {
                for path in validWordIndexPath {
                    if indexPath == path {
                        cell.backgroundColor = .green
                        cell.textLabelView.textColor = .black
                    }
                }
            } else {
                cell.backgroundColor = .black
                cell.textLabelView.textColor = .white
            }
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? GridCollectionViewCell {
            if let selectedLetter = cell.textLabelView.text {
                if cell.backgroundColor == .gray {
                    cell.backgroundColor = .black
                    currentWord.remove(at: currentWord.index(before: currentWord.endIndex))
                    validWordIndexPath.removeLast()
                } else if cell.backgroundColor == .black || cell.backgroundColor == .green {
                    cell.backgroundColor = .gray
                    cell.textLabelView.textColor = .white
                    currentWord += selectedLetter
                    validWordIndexPath.append(indexPath)
                    for (index, element) in wordsToFind.enumerated() {
                        if element.text.uppercased() == currentWord {
                            wordsToFind.remove(at: index)
                            score += 1
                            collectionView.reloadItems(at: validWordIndexPath)
                            collectionView.reloadItems(at: [footerIndexPath])
                            validWordIndexPath.removeAll()
                            currentWord = ""
                            if wordsToFind.count == 0 {
                                playerHasWon()
                                createParticles()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func createParticles() {
        let particleEmitter = CAEmitterLayer()
        particleEmitter.emitterPosition = CGPoint(x: view.center.x, y: -96)
        particleEmitter.emitterShape = .line
        particleEmitter.emitterSize = CGSize(width: view.frame.size.width, height: 1)
        let red = makeEmitterCell(color: UIColor.red)
        let green = makeEmitterCell(color: UIColor.green)
        let blue = makeEmitterCell(color: UIColor.blue)
        particleEmitter.emitterCells = [red, green, blue]
        view.layer.addSublayer(particleEmitter)
    }
    
    func makeEmitterCell(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 3
        cell.lifetime = 7.0
        cell.lifetimeRange = 0
        cell.color = color.cgColor
        cell.velocity = 200
        cell.velocityRange = 50
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 2
        cell.spinRange = 3
        cell.scaleRange = 0.5
        cell.scaleSpeed = -0.05
        cell.contents = UIImage(named: "particleConfetti")?.cgImage
        return cell
    }
    
    func playerHasWon() {
        let alertController = UIAlertController(title: "Congratulation!",
                                                message: "You have won",
                                                preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Wow, awesome!", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func resetGrid() {
        score = 0
        currentWord = ""
        validWordIndexPath.removeAll()
        retrieveWordsFromJSON()
        collectionView.reloadData()
        if let layers = view.layer.sublayers {
            if layers.count > 1 {
                layers[1].removeFromSuperlayer()
            }
        }
    }
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
