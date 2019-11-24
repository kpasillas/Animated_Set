//
//  ViewController.swift
//  Graphical_Set
//
//  Created by Work Kris on 4/6/19.
//  Copyright © 2019 Kris P. All rights reserved.
//

import UIKit

// TODO: Animation demo (Lecture #8, 33:25)
// TODO: Use UISnapBehavior for moving cards to discard pile when matched (Lecture #8, 20:40)


class SetViewController: UIViewController {
    
    private lazy var game = Set()
    @IBOutlet weak var scoreLabel: CustomLabel!
    @IBOutlet weak var dealButton: CustomButton!
    @IBOutlet weak var newGameButton: CustomButton!
   
    @IBOutlet weak var layoutView: SetCardsLayoutView! {
        didSet {
//            print("In SetViewController -> layoutView -> didSet")
            layoutView.backgroundColor = UIColor.clear                                  // layoutView set to blue for lay-out debugging, set to clear when run
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("In SetViewController -> viewDidLoad")
        dealTwelveCardsToStartGame()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        print("In SetViewController -> viewDidLayoutSubviews (Start)")
        
    if layoutView.cardCount > 0 {                                                       // re-layout cards when device orientation changes
            layoutView.gridFrame = layoutView.bounds
            for index in layoutView.subviews.indices {
                layoutView.subviews[index].frame = layoutView.cardGrid[index]!.inset(by: layoutView.cardGrid.CardInsetSize)
            }
        }
        
//        print("In SetViewController -> viewDidLayoutSubviews (End)")
    }
    
    @IBAction func dealButtonAction(_ sender: CustomButton) {
//        print("In SetViewController -> dealButtonAction (Start)")
        
        if game.isSet {                                                                 // if cards are a set, remove and replace 3 selected cards
            let sortedCardIndices = game.selectedCardsIndices.sorted(by: { $0 > $1 })
            removeAndReplaceMatchedCards(at: sortedCardIndices)
        } else {                                                                        // if cards are not a set, deal 3 more cards at end of deck
            dealMoreCards()
        }
        
//        print("In SetViewController -> dealButtonAction (End)")
    }
    
    @IBAction func newGameAction(_ sender: CustomButton) {
//        print ("In SetViewController -> newGameAction (Start)")
        
        for _ in 0..<layoutView.subviews.count {                                        // remove old card views
            if let viewToRemove = layoutView.subviews.last as? SetCardView {
                viewToRemove.removeFromSuperview()
            }
        }
        
        game = Set()                                                                    // reset game
        dealTwelveCardsToStartGame()
        
//        print ("In SetViewController -> newGameAction (End)")
    }
    
    private func dealTwelveCardsToStartGame() {
        
        var newCardDeck = [SetCardView]()
        var indexToInsert = 0
        
        layoutView.gridFrame = layoutView.bounds
        layoutView.cardCount = game.dealtCards.count
        
        for index in game.dealtCards.indices {                                          // new cards start with alpha = 0, frame = top-left
            newCardDeck += [convertCardToCardView(game.dealtCards[index])]
            newCardDeck[index].frame = CGRect.zero
            newCardDeck[index].alpha = 0.0
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealTwelveCardsToStartGameDuration, delay: self.layoutView.dealTwelveCardsToStartGameDelay, options: [.curveEaseOut],             // 1
           animations: {
            self.updateScoreLabel()                                                     // reset game score
            self.dealButton.isEnabled = false                                           // dealButton disabled while dealing cards
            self.layoutView.addSubview(newCardDeck[indexToInsert])
                newCardDeck[indexToInsert].frame = self.layoutView.cardGrid[indexToInsert]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                newCardDeck[indexToInsert].alpha = 1.0
            }, completion: { finished in
                indexToInsert += 1
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealTwelveCardsToStartGameDuration, delay: self.layoutView.dealTwelveCardsToStartGameDelay, options: [.curveEaseOut],        // 2
                   animations: {
                        self.layoutView.addSubview(newCardDeck[indexToInsert])
                        newCardDeck[indexToInsert].frame = self.layoutView.cardGrid[indexToInsert]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                        newCardDeck[indexToInsert].alpha = 1.0
                    }, completion: { finished in
                        indexToInsert += 1
                        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealTwelveCardsToStartGameDuration, delay: self.layoutView.dealTwelveCardsToStartGameDelay, options: [.curveEaseOut],        // 3
                           animations: {
                                self.layoutView.addSubview(newCardDeck[indexToInsert])
                                newCardDeck[indexToInsert].frame = self.layoutView.cardGrid[indexToInsert]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                                newCardDeck[indexToInsert].alpha = 1.0
                            }, completion: { finished in
                                indexToInsert += 1
                                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealTwelveCardsToStartGameDuration, delay: self.layoutView.dealTwelveCardsToStartGameDelay, options: [.curveEaseOut],        // 4
                                   animations: {
                                        self.layoutView.addSubview(newCardDeck[indexToInsert])
                                        newCardDeck[indexToInsert].frame = self.layoutView.cardGrid[indexToInsert]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                                        newCardDeck[indexToInsert].alpha = 1.0
                                    }, completion: { finished in
                                        indexToInsert += 1
                                        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealTwelveCardsToStartGameDuration, delay: self.layoutView.dealTwelveCardsToStartGameDelay, options:[.curveEaseOut],     // 5
                                           animations: {
                                                self.layoutView.addSubview(newCardDeck[indexToInsert])
                                                newCardDeck[indexToInsert].frame = self.layoutView.cardGrid[indexToInsert]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                                                newCardDeck[indexToInsert].alpha = 1.0
                                            }, completion: { finished in
                                                indexToInsert += 1
                                                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealTwelveCardsToStartGameDuration, delay: self.layoutView.dealTwelveCardsToStartGameDelay, options: [.curveEaseOut],        //6
                                                   animations: {
                                                        self.layoutView.addSubview(newCardDeck[indexToInsert])
                                                        newCardDeck[indexToInsert].frame = self.layoutView.cardGrid[indexToInsert]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                                                        newCardDeck[indexToInsert].alpha = 1.0
                                                    }, completion: { finished in
                                                        indexToInsert += 1
                                                        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealTwelveCardsToStartGameDuration, delay: self.layoutView.dealTwelveCardsToStartGameDelay, options: [.curveEaseOut],        // 7
                                                           animations: {
                                                                self.layoutView.addSubview(newCardDeck[indexToInsert])
                                                                newCardDeck[indexToInsert].frame = self.layoutView.cardGrid[indexToInsert]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                                                                newCardDeck[indexToInsert].alpha = 1.0
                                                            }, completion: { finished in
                                                                indexToInsert += 1
                                                                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealTwelveCardsToStartGameDuration, delay: self.layoutView.dealTwelveCardsToStartGameDelay, options: [.curveEaseOut],        // 8
                                                                   animations: {
                                                                        self.layoutView.addSubview(newCardDeck[indexToInsert])
                                                                        newCardDeck[indexToInsert].frame = self.layoutView.cardGrid[indexToInsert]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                                                                        newCardDeck[indexToInsert].alpha = 1.0
                                                                    }, completion: { finsihed in
                                                                        indexToInsert += 1
                                                                        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealTwelveCardsToStartGameDuration, delay: self.layoutView.dealTwelveCardsToStartGameDelay, options: [.curveEaseOut],        //9
                                                                           animations: {
                                                                                self.layoutView.addSubview(newCardDeck[indexToInsert])
                                                                                newCardDeck[indexToInsert].frame = self.layoutView.cardGrid[indexToInsert]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                                                                                newCardDeck[indexToInsert].alpha = 1.0
                                                                            }, completion: { finished in
                                                                                indexToInsert += 1
                                                                                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealTwelveCardsToStartGameDuration, delay: self.layoutView.dealTwelveCardsToStartGameDelay, options: [.curveEaseOut],        // 10
                                                                                   animations: {
                                                                                        self.layoutView.addSubview(newCardDeck[indexToInsert])
                                                                                        newCardDeck[indexToInsert].frame = self.layoutView.cardGrid[indexToInsert]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                                                                                        newCardDeck[indexToInsert].alpha = 1.0
                                                                                    }, completion: { finished in
                                                                                        indexToInsert += 1
                                                                                        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealTwelveCardsToStartGameDuration, delay: self.layoutView.dealTwelveCardsToStartGameDelay, options: [.curveEaseOut],        // 11
                                                                                           animations: {
                                                                                                self.layoutView.addSubview(newCardDeck[indexToInsert])
                                                                                                newCardDeck[indexToInsert].frame = self.layoutView.cardGrid[indexToInsert]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                                                                                                newCardDeck[indexToInsert].alpha = 1.0
                                                                                            }, completion: { finished in
                                                                                                indexToInsert += 1
                                                                                                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealTwelveCardsToStartGameDuration, delay: self.layoutView.dealTwelveCardsToStartGameDelay, options: [.curveEaseOut],        // 12
                                                                                                   animations: {
                                                                                                        self.layoutView.addSubview(newCardDeck[indexToInsert])
                                                                                                        newCardDeck[indexToInsert].frame = self.layoutView.cardGrid[indexToInsert]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                                                                                                        newCardDeck[indexToInsert].alpha = 1.0
                                                                                                    }, completion: { finished in
                                                                                                        self.dealButton.isEnabled = true
                                                                                                    }
                                                                                                )
                                                                                            }
                                                                                        )
                                                                                    }
                                                                                )
                                                                            }
                                                                        )
                                                                    }
                                                                )
                                                            }
                                                        )
                                                    }
                                                )
                                            }
                                        )
                                    }
                                )
                            }
                        )
                    }
                )
            }
        )
        
    }
    
    private func relayoutCards() {
        layoutView.cardCount = game.dealtCards.count
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.relayoutCardsDuration, delay: self.layoutView.relayoutCardsDelay, options: [.curveEaseOut],
            animations: {
                for index in self.layoutView.subviews.indices {
                    self.layoutView.subviews[index].frame = self.layoutView.cardGrid[index]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                }
            }
        )
    }
    
    private func updateViewFromModel() {
//        print("In SetViewController -> updateViewFromModel (Start)")
        
        for index in layoutView.subviews.indices {                                      // set card border color
            if let cardView = layoutView.subviews[index] as? SetCardView {
                cardView.borderColorValue = getBorderColor(index)
            }
        }
        
        updateDealButton()
        updateScoreLabel()
        
//        print("In SetViewController -> updateViewFromModel (End)")
    }

    private func dealMoreCards() {
//        print("In SetViewController -> addCardsToEndOfDeck (Start)")
        
        var newCardDeck = [SetCardView]()
        var indexToInsert = 0
        
        game.dealThreeCards()
        layoutView.cardCount = game.dealtCards.count
        
        for index in (game.dealtCards.index(game.dealtCards.endIndex, offsetBy: -3))...(game.dealtCards.index(game.dealtCards.endIndex, offsetBy: -1)) {
            newCardDeck += [convertCardToCardView(game.dealtCards[index])]
            newCardDeck[indexToInsert].frame = CGRect.zero
            newCardDeck[indexToInsert].alpha = 0.0
            indexToInsert += 1
        }
        indexToInsert = 0
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.relayoutCardsDuration, delay: self.layoutView.relayoutCardsDelay, options: [.curveEaseOut],
           animations: {
                for index in self.layoutView.subviews.indices {                         // re-layout cards
                    self.layoutView.subviews[index].frame = self.layoutView.cardGrid[index]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                }
            }, completion: { finished in
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealThreeCardsDuration, delay: self.layoutView.dealThreeCardsDelay, options: [.curveEaseOut],
                   animations: {
                        self.layoutView.addSubview(newCardDeck[indexToInsert])
                        newCardDeck[indexToInsert].frame = self.layoutView.cardGrid[(self.game.dealtCards.index(self.game.dealtCards.endIndex, offsetBy: -3))]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                        newCardDeck[indexToInsert].alpha = 1.0
                    }, completion: { finished in
                        indexToInsert += 1
                        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealThreeCardsDuration, delay: self.layoutView.dealThreeCardsDelay, options: [.curveEaseOut],
                           animations: {
                                self.layoutView.addSubview(newCardDeck[indexToInsert])
                                newCardDeck[indexToInsert].frame = self.layoutView.cardGrid[(self.game.dealtCards.index(self.game.dealtCards.endIndex, offsetBy: -2))]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                                newCardDeck[indexToInsert].alpha = 1.0
                            }, completion: { finished in
                                indexToInsert += 1
                                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealThreeCardsDuration, delay: self.layoutView.dealThreeCardsDelay, options: [.curveEaseOut],
                                   animations: {
                                        self.layoutView.addSubview(newCardDeck[indexToInsert])
                                        newCardDeck[indexToInsert].frame = self.layoutView.cardGrid[(self.game.dealtCards.index(self.game.dealtCards.endIndex, offsetBy: -1))]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                                        newCardDeck[indexToInsert].alpha = 1.0
                                    }, completion: { finished in
                                        self.updateViewFromModel()
                                    }
                                )
                            }
                        )
                    }
                )
            }
        )
        
//        print("In SetViewController -> addCardsToEndOfDeck (End)")
    }
    
    private func removeAndReplaceMatchedCards(at indicesToRemoveAndReplace: [Int]) {
//        print("In SetViewController -> removeAndReplaceMatchedCards (Start)")
        
        var newCardDeck = [SetCardView]()
        var indexToRemoveAndReplace = 0
        
        game.replaceAndDeselectSet()
        
        for index in indicesToRemoveAndReplace.indices {
            newCardDeck.append(convertCardToCardView(game.dealtCards[indicesToRemoveAndReplace[index]]))
            newCardDeck[indexToRemoveAndReplace].frame = CGRect.zero
            newCardDeck[indexToRemoveAndReplace].alpha = 0.0
            indexToRemoveAndReplace += 1
        }
        indexToRemoveAndReplace = 0
     
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealThreeCardsDuration, delay: self.layoutView.dealThreeCardsDelay, options: [.curveEaseIn],
            animations: {
                if let viewToRemove = self.layoutView.subviews[indicesToRemoveAndReplace[indexToRemoveAndReplace]] as? SetCardView {
                    viewToRemove.frame = CGRect(x: viewToRemove.superview!.bounds.maxX, y: viewToRemove.superview!.bounds.maxY, width: viewToRemove.bounds.width, height: viewToRemove.bounds.height)
                    viewToRemove.transform = CGAffineTransform.identity.scaledBy(x: self.layoutView.discardCardsScale, y: self.layoutView.discardCardsScale)
                    viewToRemove.alpha = 0.0
                }
            }, completion: { finished in
                indexToRemoveAndReplace += 1
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealThreeCardsDuration, delay: self.layoutView.dealThreeCardsDelay, options: [.curveEaseIn],
                   animations: {
                        if let viewToRemove = self.layoutView.subviews[indicesToRemoveAndReplace[indexToRemoveAndReplace]] as? SetCardView {
                            viewToRemove.frame = CGRect(x: viewToRemove.superview!.bounds.maxX, y: viewToRemove.superview!.bounds.maxY, width: viewToRemove.bounds.width, height: viewToRemove.bounds.height)
                            viewToRemove.transform = CGAffineTransform.identity.scaledBy(x: self.layoutView.discardCardsScale, y: self.layoutView.discardCardsScale)
                            viewToRemove.alpha = 0.0
                        }
                    }, completion: { finished in
                        indexToRemoveAndReplace += 1
                        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealThreeCardsDuration, delay: self.layoutView.dealThreeCardsDelay, options: [.curveEaseIn],
                            animations: {
                                if let viewToRemove = self.layoutView.subviews[indicesToRemoveAndReplace[indexToRemoveAndReplace]] as? SetCardView {
                                    viewToRemove.frame = CGRect(x: viewToRemove.superview!.bounds.maxX, y: viewToRemove.superview!.bounds.maxY, width: viewToRemove.bounds.width, height: viewToRemove.bounds.height)
                                    viewToRemove.transform = CGAffineTransform.identity.scaledBy(x: self.layoutView.discardCardsScale, y: self.layoutView.discardCardsScale)
                                    viewToRemove.alpha = 0.0
                                }
                            }, completion: { finished in
                                for index in indicesToRemoveAndReplace.indices {        // remove discarded card cardViews
                                    if let viewToRemove = self.layoutView.subviews[indicesToRemoveAndReplace[index]] as? SetCardView {
                                        viewToRemove.removeFromSuperview()
                                    }
                                }
                                
                                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealThreeCardsDuration, delay: self.layoutView.dealThreeCardsDelay, options: [.curveEaseOut],
                                    animations: {
                                        let viewToAdd = newCardDeck.removeLast()
                                        self.layoutView.insertSubview(viewToAdd, at: indicesToRemoveAndReplace[indexToRemoveAndReplace])
                                        viewToAdd.frame = self.layoutView.cardGrid[indicesToRemoveAndReplace[indexToRemoveAndReplace]]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                                        viewToAdd.alpha = 1.0
                                    }, completion: { finished in
                                        indexToRemoveAndReplace -= 1
                                        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealThreeCardsDuration, delay: self.layoutView.dealThreeCardsDelay, options: [.curveEaseOut],
                                           animations: {
                                                let viewToAdd = newCardDeck.removeLast()
                                                self.layoutView.insertSubview(viewToAdd, at: indicesToRemoveAndReplace[indexToRemoveAndReplace])
                                                viewToAdd.frame = self.layoutView.cardGrid[indicesToRemoveAndReplace[indexToRemoveAndReplace]]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                                                viewToAdd.alpha = 1.0
                                            }, completion: { finished in
                                                indexToRemoveAndReplace -= 1
                                                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealThreeCardsDuration, delay: self.layoutView.dealThreeCardsDelay, options: [.curveEaseOut],
                                                   animations: {
                                                        let viewToAdd = newCardDeck.removeLast()
                                                        self.layoutView.insertSubview(viewToAdd, at: indicesToRemoveAndReplace[indexToRemoveAndReplace])
                                                        viewToAdd.frame = self.layoutView.cardGrid[indicesToRemoveAndReplace[indexToRemoveAndReplace]]!.inset(by: self.layoutView.cardGrid.CardInsetSize)
                                                        viewToAdd.alpha = 1.0
                                                    }, completion: { finished in
                                                        self.updateViewFromModel()
                                                    }
                                                )
                                            }
                                        )
                                    }
                                )
                            }
                        )
                    }
                )
            }
        )

//        print("In SetViewController -> removeAndReplaceMatchedCards (End)")
    }
    
    private func removeMatchedCards(at indicesToRemove: [Int]) {
//        print("In SetViewController -> removeMatchedCards (Start)")
        
        game.discardAndDeselectSet()
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealThreeCardsDuration, delay: self.layoutView.dealThreeCardsDelay, options: [.curveEaseIn],
           animations: {
                if let viewToRemove = self.layoutView.subviews[indicesToRemove[0]] as? SetCardView {
                    viewToRemove.frame = CGRect(x: viewToRemove.superview!.bounds.maxX, y: viewToRemove.superview!.bounds.maxY, width: viewToRemove.bounds.width, height: viewToRemove.bounds.height)
                    viewToRemove.transform = CGAffineTransform.identity.scaledBy(x: self.layoutView.discardCardsScale, y: self.layoutView.discardCardsScale)
                    viewToRemove.alpha = 0.0
                }
            }, completion: { finished in
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealThreeCardsDuration, delay: self.layoutView.dealThreeCardsDelay, options: [.curveEaseIn],
                   animations: {
                        if let viewToRemove = self.layoutView.subviews[indicesToRemove[1]] as? SetCardView {
                            viewToRemove.frame = CGRect(x: viewToRemove.superview!.bounds.maxX, y: viewToRemove.superview!.bounds.maxY, width: viewToRemove.bounds.width, height: viewToRemove.bounds.height)
                            viewToRemove.transform = CGAffineTransform.identity.scaledBy(x: self.layoutView.discardCardsScale, y: self.layoutView.discardCardsScale)
                            viewToRemove.alpha = 0.0
                        }
                    }, completion: { finished in
                        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: self.layoutView.dealThreeCardsDuration, delay: self.layoutView.dealThreeCardsDelay, options: [.curveEaseIn],
                           animations: {
                                if let viewToRemove = self.layoutView.subviews[indicesToRemove[2]] as? SetCardView {
                                    viewToRemove.frame = CGRect(x: viewToRemove.superview!.bounds.maxX, y: viewToRemove.superview!.bounds.maxY, width: viewToRemove.bounds.width, height: viewToRemove.bounds.height)
                                    viewToRemove.transform = CGAffineTransform.identity.scaledBy(x: self.layoutView.discardCardsScale, y: self.layoutView.discardCardsScale)
                                    viewToRemove.alpha = 0.0
                                }
                            }, completion: { finished in
                                for index in indicesToRemove.indices {
                                    if let viewToRemove = self.layoutView.subviews[indicesToRemove[index]] as? SetCardView {
                                        viewToRemove.removeFromSuperview()
                                    }
                                }
                                self.relayoutCards()
                                self.updateViewFromModel()
                            }
                        )
                    }
                )
            }
        )
        
//        print("In SetViewController -> removeMatchedCards (End)")
    }
    
    private func convertCardToCardView(_ card: SetCard) -> SetCardView {
//        print("In SetViewController -> convertCardToCardView")
        
        // initialize new CardView
        let borderColor = UIColor.darkGray
        let newCardView = SetCardView(shapeSymbol: card.shape.description, shapeNumber: card.number.rawValue, shapeColor: card.colorValue, shapeShading: card.shading.description, borderColorValue: borderColor)
        
        // add Tap function
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapCardAction(_:)))
        tap.numberOfTapsRequired = 1
        newCardView.isUserInteractionEnabled = true
        newCardView.addGestureRecognizer(tap)
        
        return newCardView
    }

    @objc func tapCardAction(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
            case .ended:
                if var selectedCardIndex = layoutView.subviews.firstIndex(of: recognizer.view!) {
                    if game.isSet {                                                     // if selected cards are a set
                        let sortedSelectedCardIndices = game.selectedCardsIndices.sorted(by: { $0 > $1 })
                        if game.deckIsEmpty {                                               // if no more cards to deal
                            if sortedSelectedCardIndices.contains(selectedCardIndex) {          // if selected card is not already selected, deselect all then select new card
                                removeMatchedCards(at: sortedSelectedCardIndices)
                            } else {
                                for index in sortedSelectedCardIndices.indices {                    // adjust selectedCardIndex if < selectedCardIndices
                                    let indexToRemove = sortedSelectedCardIndices[index]
                                    if indexToRemove < selectedCardIndex {
                                        selectedCardIndex -= 1
                                    }
                                }
                                removeMatchedCards(at: sortedSelectedCardIndices)
                                game.selectCard(at: selectedCardIndex)
                            }
                        } else {                                                            // if there are more cards to deal
                            removeAndReplaceMatchedCards(at: sortedSelectedCardIndices)         // if selected card is already selected, deselect all
                            if !sortedSelectedCardIndices.contains(selectedCardIndex) {         // if selected card is not already selected, deselect all then select new card
                                game.selectCard(at: selectedCardIndex)
                            }
                        }
                    } else if game.selectedCardsIndices.count == 3 {                    // if there are three selected cards which are not a set, deselect three cards
                        game.deselectNonSetAndSelectCard(at: selectedCardIndex)
                        updateViewFromModel()
                    } else {                                                            // if fewer than three cards are selected, add new selected card
                        game.selectCard(at: selectedCardIndex)
                        updateViewFromModel()
                    }
                }
            default:
                break
        }
    }
    
    private func getBorderColor(_ index: Int) -> UIColor {
        var color = UIColor()
        
        if game.selectedCardsIndices.contains(index) {                                  // card is selected
            if game.selectedCardsIndices.count == 3 {                                       // card is potentially part of a set
                if game.isSet {                                                                 // card is part of a set
                    color = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                } else {                                                                        // card is not part of a set
                    color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                }
            } else {
                color = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            }
        } else {
            color = UIColor.darkGray
        }
        
        return color
    }

    private func updateDealButton() {
        dealButton.isEnabled = !game.deckIsEmpty
    }

    private func updateScoreLabel() {
        scoreLabel.updateText(string: "Score: \(game.score)")
    }

}

extension SetCard {
    var colorValue: UIColor {
        switch self.color {
            case .red: return UIColor.red
            case .green: return UIColor.green
            case .purple: return UIColor.purple
        }
    }
}

extension SetCardsLayoutView {
    var dealTwelveCardsToStartGameDuration: Double {
        return 0.15
    }
    
    var dealTwelveCardsToStartGameDelay: Double {
        return 0.07
    }
    
    var relayoutCardsDuration: Double {
        return 0.25
    }
    
    var relayoutCardsDelay: Double {
        return 0.1
    }
    
    var dealThreeCardsDuration: Double {
        return 0.25
    }
    
    var dealThreeCardsDelay: Double {
        return 0.1
    }
    
    var discardCardsScale: CGFloat {
        return 0.01
    }
}
